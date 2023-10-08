
use lib 'lib';

use Getopt::Long::Grammar;

use Test;

# Define a few command-line examples to test
my @tests = (
{
    str => '%%chat --option1 arg1 --option2 arg2 arg3 arg4',
    :!gather,
    ast => {
        command  => '%%chat',
        options  => (
            { name => 'option1', value => 'arg1' },
            { name => 'option2', value => 'arg2' }
        ),
        arguments => <arg3 arg4>
    }
},

{
    str => '%%chat arg2 arg3 arg4 --option1 arg1 --option2',
    :!gather,
    ast => {
        command  => '%%chat',
        options  => (
        { name => 'option1', value => 'arg1' },
        { name => 'option2', :value}
        ),
        arguments => <arg2 arg3 arg4>
    }
},

{
    str => '%%chat_meta cw1 --api_key=cd77fdfw1 --lr 1 --prompt --lr 2',
    :gather,
    ast => {
        command  => '%%chat_meta',
        options  => { api_key => 'cd77fdfw1', :prompt, lr => ("1", "2") },
        arguments => ('cw1',)
    }
},
);

# Run the tests
for @tests -> %test {
    my $parsed = getopt-interpret(%test<str>, gather => %test<gather>);
    is-deeply $parsed, %test<ast>, "Testing: {%test<str>}";
}

# Finish the test run
done-testing;
