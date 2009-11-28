package W3CValidator::Constants;

use strict;
use warnings;

use Exporter;
use vars qw($VERSION @ISA @EXPORT);
$VERSION   = sprintf("%s", "Revision: 1.1.1.1" );
@ISA    = qw(Exporter);
@EXPORT = qw(
        TRUE
	FALSE
	MAX_PARSER_EXEC_TIME
	T_DEBUG
	T_INFO
	T_WARN
	T_ERROR
	T_FATAL
	O_SOURCE
	O_CHARSET
	O_DOCTYPE
);

#
# Define global constants
use constant TRUE  => 1;
use constant FALSE => 0;

use constant MAX_PARSER_EXEC_TIME => 1;

#
# Tentative Validation Severities.
use constant T_DEBUG =>  1; # 0000 0001
use constant T_INFO  =>  2; # 0000 0010
use constant T_WARN  =>  4; # 0000 0100
use constant T_ERROR =>  8; # 0000 1000
use constant T_FATAL => 16; # 0001 0000

#
# Output flags for error processing
use constant O_SOURCE  =>  1; # 0000 0001
use constant O_CHARSET =>  2; # 0000 0010
use constant O_DOCTYPE =>  4; # 0000 0100


