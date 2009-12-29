"""%prog RELEASE_AREA [action ...]

Perform needed actions to release package, doing the work in directory
RELEASE_AREA.

If no actions are given, print the tree of actions and do nothing.

Note that some ("clean*") actions do rm -rf on RELEASE_AREA or subdirectories
of RELEASE_AREA.  Other actions install software.
"""

# This script depends on the code from this git repository:
# git://github.com/jjlee/mechanize-build-tools.git

import cStringIO as StringIO
import glob
import optparse
import os
import rfc822
import sys

import action_tree
import cmd_env

import buildtools.release as release
import buildtools.testdeb


# Taken from git-buildpackage.  Should really use --git-posttag to record
# actual tag name rather than assuming this won't change.
def sanitize_version(version):
    if ':' in version: # strip of any epochs
        version = version.split(':', 1)[1]
    return version.replace('~', '.')


class Test(object):

    def set_up(self, env):
        env.cmd(cmd_env.write_file_cmd(
                "test.html",
                """\
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN"
    "http://www.w3.org/TR/html4/strict.dtd">
<html>
  <head><title>Title</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>Hello, valid world.
  </body>
</html>
"""))

    def run_test(self, env):
        env.cmd(["w3c-validate", "test.html"])

    def verify(self, output):
        return output == "Result: This document is valid HTML 4.01 Strict\n"


class Releaser(object):

    key = "A362A9D1"

    def __init__(self, env, git_repository_path, release_dir,
                 run_in_repository=False):
        self._env = release.GitPagerWrapper(env)
        self._source_repo_path = git_repository_path
        self._in_source_repo = release.CwdEnv(self._env,
                                              self._source_repo_path)
        self._clone_path = os.path.join(release_dir, "clone")
        self._in_clone = release.CwdEnv(self._env, self._clone_path)
        if run_in_repository:
            self._in_repo = self._in_source_repo
            self._repo_path = self._source_repo_path
        else:
            self._in_repo = self._in_clone
            self._repo_path = self._clone_path
        self._release_dir = release_dir
        self._in_release_dir = release.CwdEnv(self._env, self._release_dir)

    def _get_version_from_changelog(self):
        output = release.get_cmd_stdout(
            self._in_repo, ["dpkg-parsechangelog", "--format", "rfc822"])
        message = rfc822.Message(StringIO.StringIO(output))
        [version] = message.getheaders("Version")
        return version

    def install_deps(self, log):
        def ensure_installed(package_name, ppa=None):
            release.ensure_installed(self._env,
                                     cmd_env.PrefixCmdEnv(["sudo"], self._env),
                                     package_name, ppa)
        ensure_installed("build-essential")
        ensure_installed("pristine-tar")
        ensure_installed("git-buildpackage")

    def print_next_tag(self, log):
        print self._get_version_from_changelog()

    def clean(self, log):
        self._env.cmd(release.rm_rf_cmd(self._release_dir))

    def clone(self, log):
        self._env.cmd(["git", "clone",
                       self._source_repo_path, self._clone_path])
        self._in_clone.cmd(["git", "checkout", "master"])
        def make_local_branch(name):
            self._in_clone.cmd(["git", "branch", name, "origin/%s" % name])
        make_local_branch("pristine-tar")
        make_local_branch("upstream")

    def build(self, log):
        self._in_repo.cmd(["git-buildpackage",
                           "--git-pristine-tar",
                           "--git-ignore-new",
                           "--git-tag",
                           "--git-sign-tags",
                           "--git-keyid=%s" % self.key,  # for signing tags
                           "-k%s" % self.key,  # for signing packages
                           ])

    def build_source_package(self, log):
        self._in_repo.cmd(["git-buildpackage",
                           "--git-pristine-tar",
                           "-S",
                           "-k%s" % self.key,  # for signing packages
                           ])

    def submit_to_ppa(self, log):
        dput_cf = os.path.join(self._release_dir, "dput.cf")
        self._env.cmd(cmd_env.write_file_cmd(dput_cf, """\
[w3cvalidator]
fqdn = ppa.launchpad.net
method = ftp
incoming = ~jjl/w3cvalidator/ubuntu/
login = anonymous
allow_unsigned_uploads = 0
"""))
        version = self._get_version_from_changelog()
        changes = os.path.join(
                self._repo_path, "..",
                "w3c-markup-validator-commandline_%s_source.changes" % version)
        print "changes %r" % changes
        self._env.cmd(["dput", "--config", dput_cf, "w3cvalidator", changes])

    def push_tag(self, log):
        version = self._get_version_from_changelog()
        tag_name = "debian/%s" % sanitize_version(version)
        self._in_repo.cmd([
                "git", "push",
                "git@github.com:jjlee/w3c-markup-validator-commandline.git",
                "tag", tag_name])

    def _get_deb_path(self):
        version = self._get_version_from_changelog()
        return os.path.join(
            self._repo_path, "..",
            "w3c-markup-validator-commandline_%s_all.deb" % version)

    @action_tree.action_node
    def all(self):
        work_dir = "/tmp/w3c-test"
        test = buildtools.testdeb.PbuilderActions(self._env, work_dir,
                                                  self._get_deb_path,
                                                  test=Test())
        return [
            self.clean,
            self.clone,
            self.print_next_tag,
            self.build,
            self.build_source_package,
            ("test", test.all),
            self.submit_to_ppa,
            self.push_tag,
            ]


def parse_options(args):
    parser = optparse.OptionParser(usage=__doc__.strip())
    release.add_basic_env_options(parser)
    parser.add_option("--git-repository", metavar="DIRECTORY",
                      help="path to mechanize git repository (default is cwd)")
    parser.add_option("--in-source-repository", action="store_true",
                      dest="in_repository",
                      help=("run all commands in original repository "
                            "(specified by --git-repository), rather than in "
                            "the clone of it in the release area"))
    options, remaining_args = parser.parse_args(args)
    nr_args = len(remaining_args)
    try:
        options.release_area = remaining_args.pop(0)
    except IndexError:
        parser.error("Expected at least 1 argument, got %d" % nr_args)
    return options, remaining_args


def main(argv):
    options, action_tree_args = parse_options(argv[1:])
    env = release.get_env_from_options(options)
    git_repository_path = options.git_repository
    if git_repository_path is None:
        git_repository_path = os.getcwd()
    releaser = Releaser(env, git_repository_path, options.release_area,
                        options.in_repository)
    action_tree.action_main(releaser.all, action_tree_args)


if __name__ == "__main__":
    main(sys.argv)
