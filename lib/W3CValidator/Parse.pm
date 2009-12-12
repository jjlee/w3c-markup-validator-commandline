package W3CValidator::Parse;

use strict;
use warnings;

use File::Spec          qw();
use HTML::Parser   3.25 qw(); # Need 3.25 for $p->ignore_elements.
use IO::File            qw();
use IPC::Open3          qw(open3);
use Set::IntSpan        qw();
use Text::Iconv         qw();
use Text::Wrap          qw(wrap);

use W3CValidator::Constants;
use W3CValidator::Util;

#
# Define global variables.
use vars qw($DEBUG $CFG $VERSION);

sub alarm_handler
{
        print STDERR "check: Alarm clock received because parser ran for too long\n";
        if((defined($main::child_pid)) && ($main::child_pid != 0))
        {
                kill 15, $main::child_pid;
        }
}


# Pass a filehandle to the file to check as an argument...
sub parse_file
{
	my ($CFG,$File,$spin)=@_;

	#
	# By default, use SGML catalog file and SGML Declaration.
	my $catalog  = File::Spec->catfile($CFG->{'SGML Library'}, 'sgml.soc');
	my @xmlflags = qw(
	                  -R
	                  -wvalid
	                  -wnon-sgml-char-ref
	                  -wno-duplicate
	                 );

	#
	# Switch to XML semantics if file is XML.
	if (&is_xml($File->{Type})) {
	  $catalog  = File::Spec->catfile($CFG->{'SGML Library'}, 'xml.soc');
	  push(@xmlflags, '-wxml');
	  &add_warning($File, "The XML validator has some limitations");
	}


	#
	# Defaults for SP; turn off fixed charset mode and set encoding to UTF-8.
	$ENV{SP_CHARSET_FIXED} = 'NO';
	$ENV{SP_ENCODING}      = 'UTF-8';
	$ENV{SP_BCTF}          = 'UTF-8';

	#
	# Tell onsgmls about the SGML Library.
	$ENV{SGML_SEARCH_PATH} = $CFG->{'SGML Library'};


	##
	## HTML. Turn back to SGML semantics.
	if (&is_html($File->{Type})) {
	  $ENV{SP_CHARSET_FIXED} = 'YES';
	  $ENV{SP_ENCODING}      = 'UTF-8';
	  $catalog  = File::Spec->catfile($CFG->{'SGML Library'}, 'catalog');
	  @xmlflags = '-wnon-sgml-char-ref';
	}

	##
	## MathML and XHTML. Must be here because they're usually served as text/html
	## to deal with braindead browsers. In other words, these override the check for &is_html.
	$catalog = File::Spec->catfile($CFG->{'SGML Library'}, 'xhtml.soc')
	  if &is_xhtml($File->{Type});
	$catalog = File::Spec->catfile($CFG->{'SGML Library'}, 'mathml.soc')
	  if &is_mathml($File->{Type});


	# There seems to be a rogue -R in the xmlflags - we should sort it
	# properly, but for now, just yank it out. Proper solution NOT IMPLEMENTED
	shift(@xmlflags) if($xmlflags[0] eq "-R");
	my @cmd = ($CFG->{'SGML Parser'}, '-c', $catalog, '-E0', @xmlflags);

	$File->{SP_CHARSET_FIXED}=$ENV{SP_CHARSET_FIXED};
	$File->{SP_ENCODING}=$ENV{SP_ENCODING};
	$File->{SP_BCTF}=$ENV{SP_BCTF};

	#
	# Temporary filehandles.
	#my $spin  = IO::File->new_tmpfile;
	my $spout = IO::File->new_tmpfile;
	my $sperr = IO::File->new_tmpfile;

	#
	# Dump file to a temp file for parsing.
	#for (@{$File->{Content}}) {
	#  print $spin $_, "\n";
	#}

	#
	# seek() to beginning of the file.
	seek $spin, 0, 0;

	#
	# Run it through SP, redirecting output to temporary files.
	my $pid;

	do {
	  no warnings 'once';
	  local(*SPIN, *SPOUT, *SPERR)  = ($spin, $spout, $sperr);
	  $main::child_pid=open3("<&SPIN", ">&SPOUT", ">&SPERR", @cmd);
	  $pid=$main::child_pid;
	};

	#
	# Close input file, reap the kid, and rewind temporary filehandles.
	undef $spin;
	$SIG{ALRM}=\&alarm_handler;
	alarm(300);
	waitpid $pid, 0;
	seek $_, 0, 0 for $spout, $sperr;

	$main::child_pid=0;

	$File = &parse_errors($File, $sperr); # Parse error output.
	undef $sperr; # Get rid of no longer needed filehandle.

	$File->{ESIS} = [];
	my $elements_found = 0;
	while (<$spout>) {
	  push @{$File->{'DEBUG'}->{ESIS}}, $_;
	  $elements_found++ if /^\(/;
	
	  if (/^Axmlns() \w+ (.*)/ or /^Axmlns:([^ ]+) \w+ (.*)/) {
	    if (not $File->{Namespace} and $elements_found == 0 and $1 eq "") {
	      $File->{Namespace} = $2;
	    }
	    $File->{Namespaces}->{$2}++;
	  }

	  next if / IMPLIED$/;
	  next if /^ASDAFORM CDATA /;
	  next if /^ASDAPREF CDATA /;
	  chomp; # Removes trailing newlines
	  push @{$File->{ESIS}}, $_;
	}
	undef $spout;

	if ((defined($File->{ESIS}->[-1])) && ($File->{ESIS}->[-1] =~ /^C$/)) {
	  undef $File->{ESIS}->[-1];
	  $File->{'Is Valid'} = TRUE;
	} else {
	  $File->{'Is Valid'} = FALSE;
	}


	#
	# Set Version to be the FPI initially.
	$File->{Version} = $File->{DOCTYPE};

	#
	# Extract any version attribute from the ESIS.
	for (@{$File->{ESIS}}) {
	  no warnings 'uninitialized';
	  next unless /^AVERSION CDATA (.*)/;
	  $File->{Version} = $1;
	  last;
	}

	#
	# Force "XML" if type is an XML type and an FPI was not found.
	# Otherwise set the type to be the FPI.
	if (&is_xml($File->{Type}) and not $File->{DOCTYPE}) {
	  $File->{Version} = 'XML';
	} else {
	  $File->{Version} = $File->{DOCTYPE} unless $File->{Version};
	}


	#$File->{Version} = $File->{DOCTYPE} if &is_xhtml($File->{Type});
	#$File->{Version} = $File->{DOCTYPE} if &is_mathml($File->{Type});
	#$File->{Version} = $File->{DOCTYPE} if &is_svg($File->{Type});
	#$File->{Version} = $File->{DOCTYPE} if &is_smil($File->{Type});

	# Get the pretty text version of the FPI if a mapping exists.
	if (my $prettyver = $CFG->{'FPI to Text'}->{$File->{Version}}) {
	  $File->{Version} = $prettyver;
	} else {
	  $File->{Version} = &ent($File->{Version});
	}
	# Now remove HTML (!)
	# This is cheesy, but it works nicely without too much
	# messing with configs etc.
	$File->{Version}=~s/<[^>]*>//mg;

	if (&is_xml($File->{Type}) and $File->{Namespace}) {
	  my $rns = &ent($File->{Namespace});
	  if (&is_xhtml($File->{Type}) and $File->{Namespace} ne 'http://www.w3.org/1999/xhtml') {
	    &add_warning($File, "Unknown namespace ($rns) for text/html document!");
	  } elsif (&is_svg($File->{Type}) and $File->{Namespace} ne 'http://www.w3.org/2000/svg') {
	    &add_warning($File, "Unknown namespace ($rns) for SVG document!");
	  }

	  if (scalar keys %{$File->{Namespaces}} > 1) {
	    my $namespaces = '';
	    for (keys %{$File->{Namespaces}}) {
	      my $ns = &ent($_);
	      $namespaces .= "$ns\n"
          unless $_ eq $File->{Namespace}; # Don't repeat Root Namespace.
	    }
	    &add_table($File, 'Other Namespaces', $namespaces . '')
	      if $File->{Opt}->{Verbose};
	  }
	}


	  if ($File->{'Is Valid'} == TRUE) {
	    &report_valid($File);
	  } else {
		unless ($File->{Version} eq 'unknown') {
			print "Result: This document is not valid $File->{Version}\n";
		} else {
			print "Result: This document is not valid\n";
		}
		&report_errors($File);
	  }

	#
	# Get rid of $File object and exit.
	undef $File;
	return 1;
}

1;
