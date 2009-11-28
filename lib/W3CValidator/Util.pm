package W3CValidator::Util;

#
# Pragmas.
use strict;
use warnings;

use File::Spec          qw();
use HTML::Parser   3.25 qw(); # Need 3.25 for $p->ignore_elements.
use HTTP::Request       qw();
use IO::File            qw();
use IPC::Open3          qw(open3);
use Set::IntSpan        qw();
use Text::Iconv         qw();
use Text::Wrap          qw(wrap);

use Encode;

use W3CValidator::Constants;

# Define global variables.
use vars qw($DEBUG $CFG $VERSION);

use Exporter;
use vars qw($VERSION @ISA @EXPORT);
$VERSION   = sprintf("%s", "Revision: 1.1.1.1" );
@ISA    = qw(Exporter);
@EXPORT = qw(
        add_warning
        print_warnings
        normalize_newlines
        exact_charset
        ent
        truncate_line
        override_doctype
        parse_errors
        report_errors
        report_valid
        preparse
	charset_conflicts
	is_xml
	is_svg
	is_smil
	is_html
	is_xhtml
	is_mathml
	transcode
	check_utf8
	byte_error
	find_base_encoding
	find_xml_encoding
	abort_if_error_flagged
	conflict
);



#############################################################################
# Subroutine definitions
#############################################################################

#
# Add a waring message to the output.
sub add_warning {push @{shift->{Warnings}}, shift};


#
# Print out a list of warnings.
sub print_warnings {
  my $File = shift;
  return unless defined @{$File->{Warnings}};
	foreach (@{$File->{Warnings}})
	{
		print "Warning: $_\n";
	}
}

#
# Normalize newline forms (CRLF/CR/LF) to native newline.
sub normalize_newlines {
  my $file = shift;
  local $_ = shift;  #charset
  my $pattern = '';

  # don't use backreference parentheses!
  $pattern = '\x00\x0D(?:\x00\x0A)?|\x00\x0A' if /^utf-16be$/;
  $pattern = '\x0D\x00(?:\x0A\x00)?|\x0A\x00' if /^utf-16le$/;
  # $pattern = '\x00\x00\x00\x0D(?:\x00\x00\x00\x0A)?|\x00\x00\x00\x0A' if /^UCS-4be$/;
  # $pattern = '\x0D\x00\x00\x00(?:\x0A\x00\x00\x00)?|\x0A\x00\x00\x00' if /^UCS-4le$/;
  # insert other special cases here, such as EBCDIC
  $pattern = '\x0D(?:\x0A)?|\x0A' if !$pattern;    # all other cases

  return [split /$pattern/, $file];
}

#
# find exact charset from general one (utf-16)
#
# needed for per-line conversion and line splitting
# (BE is default, but this will apply only to HTML)
sub exact_charset {
  my $File = shift;
  my $general_charset = shift;
  my $exact_charset = $general_charset;

  if ($general_charset eq 'utf-16') {
    if ($File->{Charset}->{Auto} =~ m/^utf-16[bl]e$/) {
      $exact_charset = $File->{Charset}->{Auto};
    } else { $exact_charset = 'utf-16be'; }
  }
  # add same code for ucs-4 here
  return $exact_charset;
}



#
# Return $_[0] encoded for HTML entities (cribbed from merlyn).
#
# Note that this is used both for HTML and XML escaping.
#
sub ent {
  local $_ = shift;
  return '' unless defined; # Eliminate warnings
  s(["<&>"]){'&#' . ord($&) . ';'}ge;  # should switch to hex sooner or later
  return $_;
}


#
# Truncate source lines for report.
#
# This *really* wants Perl 5.8.0 and it's improved UNICODE support.
# Byte semantics are in effect on all length(), substr(), etc. calls,
# so offsets will be wrong if there are multi-byte sequences prior to
# the column where the error is detected.
#
sub truncate_line {
  my $line  = shift;
  my $col   = shift;
	return "",0 if(!defined($line));

  my $start = $col;
  my $end   = $col;

  for (1..40) {
    $start-- if ($start - 1 >= 0);            # in/de-crement until...
    $end++   if ($end   + 1 <= length $line); # ...we hit end of line.
  }

  unless ($end - $start == 80) {
    if ($start == 0) { # Hit start of line, maybe grab more at end.
      my $diff = 40 - $col;
      for (1..$diff) {
        $end++ if ($end + 1 <= length $line);
      }
    } elsif ($end == length $line) { # Hit end of line, maybe grab more at beginning.
      my $diff = 80 - $col;
      for (1..$diff) {
        $start-- if ($start - 1 >= 0);
      }
    }
  }

  #
  # Add elipsis at end if necessary.
  unless ($end   == length $line) {substr $line, -3, 3, '...'};

  $col = $col - $start; # New offset is diff from $col to $start.
	if( (($end - $start) <= length($line)) && ($start <= length($line)) )
	{
  		$line = substr $line, $start, $end - $start; # Truncate.
	}
	else
	{
		$line="";
	}

  #
  # Add elipsis at start if necessary.
  unless ($start == 0)            {substr $line,  0, 3, '...'};

  return $line, $col;
}


#
# Suppress any existing DOCTYPE by commenting it out.
sub override_doctype {
  no strict 'vars';
  my $File    = shift;
  local $dtd  = $CFG->{'Doctypes'}->{$File->{Opt}->{DOCTYPE}};
  local $HTML = '';
  local $seen = FALSE;

  my $declaration = sub {
    $seen = TRUE;
    $HTML .= "$dtd\n" . '<!-- ' . $_[0] . ' -->';
  };

  HTML::Parser->new(default_h     => [sub {$HTML .= shift}, 'text'],
                    declaration_h => [$declaration, 'text']
                   )->parse(join "\n", @{$File->{Content}})->eof();

  $File->{Content} = [split /\n/, $HTML];
  unshift @{$File->{Content}}, $dtd unless $seen;
  return $File;
}


#
# Parse errors reported by SP.
sub parse_errors ($$) {
  my $File = shift;
  my $fh   = shift;

  $File->{Errors} = []; # Initialize to an (empty) anonymous array ref.

  for (<$fh>) {
    push @{$File->{'DEBUG'}->{Errors}}, $_;
    my($err, @errors);
    next if /^<OSFD>0:[0-9]+:[0-9]+:[^A-Z]/;
    next if /numbers exceeding 65535 not supported/;
    next if /URL Redirected to/;

    my(@_err) = split /:/;
	next if(!defined($_err[1]));
    next unless $_err[1] eq '<OSFD>0';
    if ($_err[1] =~ m(^<URL>)) {
      @errors = ($_err[0], join(':', $_err[1], $_err[2]), @_err[3..$#_err]);
    } else {
      @errors = @_err;
    }
    $err->{src}  = $errors[1];
    $err->{line} = $errors[2];
    $err->{char} = $errors[3];
    $err->{type} = $errors[4];
    if ($err->{type} eq 'E' or $err->{type} eq 'X' or $err->{type} eq 'Q') {
      $err->{msg}  = $errors[5];
    } elsif ($err->{type} eq 'W') {
      &add_warning($File, "Line $err->{line}, column $err->{char}: $errors[5]");
      $err->{msg}  = $errors[5];
    } else {
      $err->{type} = 'I';
      $err->{msg}  = $errors[4];
    }

    # Strip curlies from lq-nsgmls output.
    $err->{msg} =~ s/[{}]//g;

    # An unknown FPI and no SI.
    if ($err->{msg} =~ m(cannot generate system identifier for entity)
     or $err->{msg} =~ m(unrecognized DOCTYPE)i
     or $err->{msg} =~ m(no document type declaration)i) {
      $File->{'Error Flagged'} = TRUE;
      $File->{'Error Message'} = "Cannot parse because public identifier is unknown";
    }

    # No or unknown FPI and a relative SI.
    if ($err->{msg} =~ m(cannot (open|find))) {
      $File->{'Error Flagged'} = TRUE;
      $File->{'Error Message'} = "Cannot parse because document references system specific files";
    }

    # No DOCTYPE.
    if ($err->{msg} =~ m(prolog can\'t be omitted)) {
      $File->{'Error Flagged'} = TRUE;
      $File->{'Error Message'} = "Cannot parse because no DOCTYPE specified";
    }


    &abort_if_error_flagged($File, O_DOCTYPE);
    push @{$File->{Errors}}, $err;
  }
  undef $fh;
  return $File;
}

#
# Generate a HTML report of detected errors.
sub report_errors ($) {
  my $File = shift;

  if (scalar @{$File->{Errors}}) {

    foreach my $err (@{$File->{Errors}}) {
      my($line, $col) = &truncate_line($File->{Content}->[$err->{line}-1], $err->{char});

      # Strip curlies from lq-nsgmls output.
      $err->{msg} =~ s/[{}]//g;

	$err->{msg}=~s/[\n\r]//g;

      print "Error: line " . $err->{line} . " column " . $err->{char} . ": " . $err->{msg} . "\n";
    }
  }
}


#
# Output "This page is Valid" report.
sub report_valid {
  my $File        = shift;
  my $gifborder   = ' border="0"';
  my $xhtmlendtag = '';
  my($image_uri, $alttext, $gifhw);
  my $URI         = &ent($File->{URI});

  unless ($File->{Version} eq 'unknown' or defined $File->{Tentative}) {
    if ($File->{Version}) {
      print "Result: This document is valid $File->{Version}\n";
    } else {
      print "This document is valid\n";
    }

    &print_warnings($File) unless $File->{Opt}->{Verbose};

  } elsif (&is_xml($File->{Type}) and not $File->{DOCTYPE}) {
    print "Result: This document is well-formed XML\n";
  } elsif (defined $File->{Tentative}) {
    print "Result: This document tentatively validates as $File->{Version}\n";;
    &print_warnings($File);
  } else {
    print "Result: This document validates as the document type specified\n";
  }
}

#
# Do an initial parse of the Document Entity to extract charset and FPI.
sub preparse {
  my $File = shift;

  #
  # Reset DOCTYPE, Root, and Charset (for second invocation).
  $File->{Charset}->{META} = '';
  $File->{DOCTYPE}         = '';
  $File->{Root}            = '';
	$File->{_Counted}=0;

  my $dtd = sub {
    return if $File->{Root};
    ($File->{Root}, $File->{DOCTYPE}) = shift =~  m(<!DOCTYPE\s+(\w+)\s+PUBLIC\s+(?:[\'\"])([^\"\']+)(?:[\"\']).*>)si;
  };

  my $start = sub {
    my $tag  = shift;
    my $attr = shift;
    my %attr = map {lc($_) => $attr->{$_}} keys %{$attr};

    if ($File->{Root}) {
      if (lc $tag eq 'meta') {
        if (lc $attr{'http-equiv'} eq 'content-type') {
          if ($attr{content} =~ m(charset\s*=[\s\"\']*([^\s;\"\'>]*))si) {
            $File->{Charset}->{META} = lc $1;
          }
        }
      }
      return unless $tag eq $File->{Root};
    } else {
      $File->{Root} = $tag;
    }
    if ($attr->{xmlns}) {$File->{Namespace} = $attr->{xmlns}};
  };

	my $text = sub {
		my ($self,$text)=@_;
		$File->{_Counted}=$File->{_Counted}+length($text);
		if($File->{_Counted} > 1000000)
		{
			print "Stopping preparse because counted too much\n";
			$self->eof;
		};
	};

		

	# First, open the file with the charset included, if PerlIO supports
	# it. Otherwise, use UTF8 (slightly dodgy default, but hey...)
	my $fh;
	my $file_open;
	my $filename=$File->{Filename};
	my $charset=$File->{Charset}->{Use};

	if((!defined($charset)) || ($charset eq ""))
	{
		# ??? Let The HTML parser worry about it ;-)
		$file_open=open($fh, "<:bytes", $filename);
	}
	elsif(Encode::perlio_ok($charset))
	{
		$charset=~tr/A-Z/a-z/;
		if(($charset eq 'utf8') || ($charset eq 'utf-8'))
		{
			$file_open=open($fh, "<:utf8", $filename);
		}
		else
		{
			$file_open=open($fh, "<:encoding($charset)", $filename);
		}
	}
	else
	{
		$file_open=open($fh, "<:utf8", $filename);
	}
	unless($file_open)
	{
		# FIle didn't open?
		$File->{'Error Flagged'} = TRUE;
		$File->{'Error Message'} = "Could not open file $filename";
		return $File;
	}


  my $p = HTML::Parser->new(api_version => 3);
  $p->xml_mode(TRUE);
  $p->ignore_elements('BODY');
  $p->ignore_elements('body');
  $p->handler(declaration => $dtd, 'text');
  $p->handler(start => $start, 'tag,attr');
	$p->handler(text => $text, 'self,text');

	#while(!defined(${$File->{Content}}[0]))
	#{
	#	shift @{$File->{Content}};
	#}

  #$p->parse(join "\n", @{$File->{Content}});
	$p->parse_file($fh);

  $File->{DOCTYPE} = '' unless defined $File->{DOCTYPE};
  $File->{DOCTYPE} =~ s(^\s+){ }g;
  $File->{DOCTYPE} =~ s(\s+$){ }g;
  $File->{DOCTYPE} =~ s(\s+) { }g;

  return $File;
}

#
# Utility subs to tell if type "is" something.
sub is_xml    {shift =~ m(^[^+]+\+xml$)};
sub is_svg    {shift =~ m(svg\+xml$)};
sub is_smil   {shift =~ m(smil\+xml$)};
sub is_html   {shift =~ m(html\+sgml$)};
sub is_xhtml  {shift =~ m(xhtml\+xml$)};
sub is_mathml {shift =~ m(mathml\+xml$)};


#
# Check charset conflicts and add any warnings necessary.
sub charset_conflicts {
  my $File = shift;
  #
  # Handle the case where there was no charset to be found.
  unless ($File->{Charset}->{Use}) {
    &add_warning($File, "No Character Encoding detected - correct validation requires this");
    $File->{Tentative} |= T_WARN;
  }

  my $cs_use  = $File->{Charset}->{Use}  ? &ent($File->{Charset}->{Use})  : '';
  my $cs_opt  = $File->{Opt}->{Charset}  ? &ent($File->{Opt}->{Charset})  : '';
  my $cs_http = $File->{Charset}->{HTTP} ? &ent($File->{Charset}->{HTTP}) : '';
  my $cs_xml  = $File->{Charset}->{XML}  ? &ent($File->{Charset}->{XML})  : '';
  my $cs_meta = $File->{Charset}->{META} ? &ent($File->{Charset}->{META}) : '';

  #
  # warn about charset override
  if ($File->{Charset}->{Override} &&
      $File->{Charset}->{Override} ne $File->{Charset}->{Use}) {
    &add_warning($File, "Character Encoding was detected as $cs_use but has been supressed and $cs_opt used instead");
    $File->{Tentative} |= T_ERROR;
  }

  #
  # Add a warning if there was charset info conflict (HTTP header,
  # XML declaration, or <meta> element).
  if (&conflict($File->{Charset}->{HTTP}, $File->{Charset}->{XML})) {
    &add_warning($File, "The specified character encoding ($cs_http) differs from that in the XML declaration ($cs_xml) - using $cs_http");
  } elsif (&conflict($File->{Charset}->{HTTP}, $File->{Charset}->{META})) {
    &add_warning($File, "The specified character encoding ($cs_http) differs from that in the meta element ($cs_xml) - using $cs_http");
  }
  elsif (&conflict($File->{Charset}->{XML}, $File->{Charset}->{META})) {
    &add_warning($File, "The specified character encoding ($cs_http) differs from that in the XML declaration ($cs_xml) - using $cs_xml");
    $File->{Tentative} |= T_WARN;
  }

  return $File;
}


#
# Transcode to UTF-8
sub transcode {
	my ($CFG,$File)=@_;

  my ($command, $result_charset) = split " ", $CFG->{Charsets}->{$File->{Charset}->{Use}}, 2;

  $result_charset = exact_charset($File, $result_charset);
  if ($command eq 'I') {
    # test if given charset is available
    eval {my $c = Text::Iconv->new($result_charset, 'utf-8')};
    $command = '' if $@;
  } elsif ($command eq 'X') {
    $@ = "$File->{Charset}->{Use} undefined; replace by $result_charset";
  }

  if ($command ne 'I') {
    my $cs = &ent($File->{Charset}->{Use});
    $File->{'Error Flagged'} = TRUE;
    $File->{'Error Message'} = "Transcoding error $@ while transcoding $cs to UTF-8";
    return $File;
  }

  my $c = Text::Iconv->new($result_charset, 'utf-8');
  my $line = 0;
  for (@{$File->{Content}}) {
    my $in = $_;
    $line++;
    $_ = $c->convert($_); # $_ is local!!
    if ($in ne "" and $_ eq "") {
      push @{$File->{Lines}}, $line;
      $_ = "#### encoding problem on this line, not shown ####";
    }
  }
  return $File;
}

#
# Check correctness of UTF-8 both for UTF-8 input and for conversion results
sub check_utf8 {
  my $File = shift;

  for (my $i = 0; $i < $#{$File->{Content}}; $i++) {
    # substitution needed for very long lines (>32K), to avoid backtrack
    # stack overflow. Handily, this also happens to count characters.
    local $_ = $File->{Content}->[$i];
    my $count =
    s/  [\x00-\x7F]                           # ASCII
      | [\xC2-\xDF]        [\x80-\xBF]        # non-overlong 2-byte sequences
      |  \xE0[\xA0-\xBF]   [\x80-\xBF]        # excluding overlongs
      | [\xE1-\xEC\xEE\xEF][\x80-\xBF]{2}     # straight 3-byte sequences
      |  \xED[\x80-\x9F]   [\x80-\xBF]        # excluding surrogates
      |  \xF0[\x90-\xBF]   [\x80-\xBF]{2}     # planes 1-3
      | [\xF1-\xF3]        [\x80-\xBF]{3}     # planes 4-15
      |  \xF4[\x80-\x8F][\x80-\xBF]{2}        # plane 16
     //xg;
    if (length) {
      push @{$File->{Lines}}, ($i+1);
      $File->{Content}->[$i] = "#### encoding problem on this line, not shown ####";
      $count = 50; # length of above text
    }
    $count += 0; # Force numeric.
    $File->{Offsets}->[$i + 1] = [$count, $File->{Offsets}->[$i]->[1] + $count];
  }
  return $File;
}

#
# byte error analysis
sub byte_error {
  my $File = shift;
  my @lines = @{$File->{Lines}};
  if (scalar @lines) {
    $File->{'Error Flagged'} = TRUE;
    my $s = $#lines ? 's' : '';
    my $lines = join ', ', split ',', Set::IntSpan->new(\@lines)->run_list;
    my $cs = &ent($File->{Charset}->{Use});
    $File->{'Error Message'} = "Unable to validate due to invalid byte strings for $cs";
  }
  return $File;
}

#
# Autodetection as in Appendix F of the XML 1.0 Recommendation.
# <http://www.w3.org/TR/2000/REC-xml-20001006#sec-guessing>
#
# return values are: (base_encoding, BOMSize, Size, Pattern)
sub find_base_encoding {
  local $_ = shift;

  # With a Byte Order Mark:
  return ('ucs-4be',  4, 4, '\0\0\0(.)')
    if /^\x00\x00\xFE\xFF/; # UCS-4, big-endian machine (1234)
  return ('ucs-4le',  4, 4, '(.)\0\0\0')
    if /^\xFF\xFE\x00\x00/; # UCS-4, little-endian machine (4321)
  return ('utf-16be', 2, 2, '\0(.)')
    if /^\xFE\xFF/;         # UTF-16, big-endian.
  return ('utf-16le', 2, 2, '(.)\0')
    if /^\xFF\xFE/;         # UTF-16, little-endian.
  return ('utf-8',    3, 1, '')
    if /^\xEF\xBB\xBF/; # UTF-8.

  # Without a Byte Order Mark:
  return ('ucs-4be',  0, 4, '\0\0\0(.)')
    if /^\x00\x00\x00\x3C/; # UCS-4 or 32bit; big-endian machine (1234 order).
  return ('ucs-4le',  0, 4, '(.)\0\0\0')
    if /^\x3C\x00\x00\x00/; # UCS-4 or 32bit; little-endian machine (4321 order).
  return ('utf-16be', 0, 2, '\0(.)')
    if /^\x00\x3C\x00\x3F/; # UCS-2, UTF-16, or 16bit; big-endian.
  return ('utf-16le', 0, 2, '(.)\0')
    if /^\x3C\x00\x3F\x00/; # UCS-2, UTF-16, or 16bit; little-endian.
  return ('utf-8',    0, 1, '')
    if /^\x3C\x3F\x78\x6D/; # UTF-8, ISO-646, ASCII, ISO-8859-*, Shift-JIS, EUC, etc.
  return ('ebcdic',   0, 1, '')
    if /^\x4C\x6F\xA7\x94/; # EBCDIC
  return ('',         0, 1, '');
                            # nothing in particular
}


#
# Find encoding in document according to XML rules
# Only meaningful if file contains a BOM, or for well-formed XML!
# Now opens the file, reads the first few bytes and uses that, rather
# than requiring th file to be slurped into memory!
sub find_xml_encoding {
  my $File = shift;
  my ($CodeUnitSize, $Pattern);

	my $file_start="";
	if(open(MYFILE,"< " . $File->{Filename}))
	{
		binmode(MYFILE);
		my $data;
		my $i=sysread MYFILE, $data, 10000;
		if($i>0)
		{
			$file_start=$data;
		}
		close(MYFILE);
	}

  ($File->{Charset}->{Auto}, $File->{BOM}, $CodeUnitSize, $Pattern)
    = &find_base_encoding($file_start);
  my $someBytes = substr $file_start, $File->{BOM}, ($CodeUnitSize * 100);
  my $someText = '';                  # 100 arbitrary, but enough in any case

  # translate from guessed encoding to ascii-compatible
  if ($File->{Charset}->{Auto} eq 'ebcdic') {
    # special treatment for EBCDIC, maybe use tr///
    # work on this later
  }
  elsif (!$Pattern) {
    $someText = $someBytes; # efficiency shortcut
  }
  else { # generic code for UTF-16/UCS-4
    $someBytes =~ /^(($Pattern)*)/s;
    $someText = $1;       # get initial piece without chars >255
    $someText =~ s/$Pattern/$1/sg;    # select the relevant bytes
  }

  # try to find encoding pseudo-attribute
  my $s = '[\ \t\n\r]';
  $someText =~ m(^<\?xml $s+ version $s* = $s* ([\'\"]) [-._:a-zA-Z0-9]+ \1 $s+
                  encoding $s* = $s* ([\'\"]) ([A-Za-z][-._A-Za-z0-9]*) \2
                )xso;

  $File->{Charset}->{XML} = lc $3;
  return $File;
}

#
# Abort with a message if an error was flagged at point.
sub abort_if_error_flagged
{
	my $File = shift;
	if ($File->{'Error Flagged'}) {
		die "Error: " . $File->{'Error Message'} . "\n";
		
	}
}

#
# conflicting encodings
sub conflict {
  my $encodingA = shift;
  my $encodingB = shift;
  return $encodingA && $encodingB && ($encodingA ne $encodingB);
}

#
# The end - phew! [wipes brow]
#
