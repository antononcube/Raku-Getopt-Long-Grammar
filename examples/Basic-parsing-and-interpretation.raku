#!/usr/bin/env raku

use lib '.';
use lib './lib';

use Getopt::Long::Grammar;

#my $cmd = '%%chat_meta --chat_id=cw1 --prompt';
my $cmd = '%%chat_meta cw1 --api_key=cd77fdfw1 --prompt';
say getopt-parse($cmd);

say "-" x 120;
say getopt-parse($cmd);

say "-" x 120;
say getopt-interpret($cmd).raku;