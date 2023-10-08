#!/usr/bin/env raku

use Getopt::Long::Grammar;

#my $cmd = '%%chat_meta --chat_id=cw1 --prompt';
my $cmd = '%%chat_meta cw1 --api_key=cd77fdfw1 --lr 1 --prompt --lr 2';
say getopt-parse($cmd);

say "=" x 120;
say getopt-interpret($cmd):gather.raku;

say "-" x 120;
say getopt-interpret($cmd):!gather;
