use Getopt::Long::Grammar::Actions;
use Getopt::Long::Grammarish;

grammar Getopt::Long::Grammar
        does Getopt::Long::Grammarish {
}

#===========================================================
sub getopt-parse(Str $line) is export {
    return Getopt::Long::Grammar.new.parse($line);
}

sub getopt-subparse(Str $line) is export {
    return Getopt::Long::Grammar.new.subparse($line);
}

sub getopt-interpret(Str $line, Bool :$gather = True) is export {
    my $actions = Getopt::Long::Grammar::Actions.new;
    my %res = Getopt::Long::Grammar.new.parse($line, :$actions).made;
    if $gather && %res<options> {
        %res<options> = %res<options>.classify({ $_<name> }).map({
            my @t = $_.value.map(*<value>);
            $_.key => (@t.elems == 1 ?? @t.head !! @t.List)
        }).Hash;
    }
    return %res;
}