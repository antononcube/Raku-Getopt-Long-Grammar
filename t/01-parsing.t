
use lib './lib';

use Getopt::Long::Grammar;
use Getopt::Long::Grammarish;

use Test;

plan *;

my $cmd = Getopt::Long::Grammar.new;

## 1
# Testing `command` parsing
my $command-match = $cmd.parse('my_command');
ok $command-match, 'Command is matched';

## 2
is $command-match<command>, 'my_command', 'Command is correct';

## 3
# Testing `options` parsing
my $long-opt-match = $cmd.parse('my_command --option=value');
ok $long-opt-match, 'Long option is matched';

## 4
is $long-opt-match<option-list><option>>><long-opt>>><opt-name>, 'option', 'Long option name is correct';

## 5
is $long-opt-match<option-list><option>>><long-opt>>><opt-arg>>><gen-arg>, 'value', 'Long option argument is correct';

## 6
my $short-opt-match = $cmd.parse('my_command -o value');
ok $short-opt-match, 'Short option is matched';

## 7
is $short-opt-match<option-list><option>>><short-opt>>><opt-name>, 'o', 'Short option name is correct';

## 8
is $short-opt-match<option-list><option>>><short-opt>>><opt-arg>, 'value', 'Short option argument is correct';

## 9
# Testing `arguments` parsing
my $args-match = $cmd.parse('my_command arg1 arg2');
ok $args-match, 'Arguments are matched';

## 10
is $args-match<argument-list><argument>[0], 'arg1', 'First argument is correct';

## 11
is $args-match<argument-list><argument>[1], 'arg2', 'Second argument is correct';

## 12
# Testing full command line
my $full-match = $cmd.parse('my_command --opt1=val1 -o val2 arg1 arg2');
ok $full-match, 'Full command line is matched';

## 13
is $full-match<command>, 'my_command', 'Command is correct';

## 14
is $full-match<option-list><option>[0]<long-opt><opt-name>, 'opt1', 'First long option name is correct';

## 15
is $full-match<option-list><option>[0]<long-opt><opt-arg>, 'val1', 'First long option argument is correct';

## 16
is $full-match<option-list><option>[1]<short-opt><opt-name>, 'o', 'Short option name is correct';

## 17
is $full-match<option-list><option>[1]<short-opt><opt-arg>, 'val2', 'Short option argument is correct';

## 18
is $full-match<argument-list><argument>[0], 'arg1', 'First argument is correct';

## 19
is $full-match<argument-list><argument>[1], 'arg2', 'Second argument is correct';

## 20
my $valid-match20 = $cmd.parse('my_command --opt1 -o=val2');
ok $valid-match20, 'Valid syntax is matched';

## 21
my grammar GetoptComma does Getopt::Long::Grammarish {
    token getopt-delim { \h* [',' \h*]? }
}
my $cmd2 = GetoptComma.new;
my $valid-match21 = $cmd2.parse('my_command --opt1, -o=val2, -p 32');
ok $valid-match21, 'Comma delimiter syntax is  matched';

done-testing;
