
use lib './lib';

use Getopt::Long::Grammar;
use Getopt::Long::Grammar::Actions;

use Test;

# Define a few command-line examples to test
my @tests = (
{
    str => 'command --option1 arg1 --option2 arg2 arg3 arg4',
    ast => {
        command  => 'command',
        options  => [
            { long-opt => { opt-name => 'option1', opt-arg => 'arg1' }, short-opt => Nil },
            { long-opt => { opt-name => 'option2', opt-arg => 'arg2' }, short-opt => Nil }
        ],
        arguments => ['arg3', 'arg4']
    }
},
# ... more test definitions ...
);

# Run the tests
for @tests -> %test {
    my $parsed = Getopt::Long::Grammar.parse(%test<str>, :actions(Getopt::Long::Grammar::Actions.new));
    is-deeply $parsed.ast, %test<ast>, "Testing: {%test<str>}";
}

# Finish the test run
done-testing;
