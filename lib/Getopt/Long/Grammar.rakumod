use Getopt::Long::Grammar::Actions;

grammar Getopt::Long::Grammar {
    rule TOP         {
        | <command> <options>? <arguments>?
        | <command> <arguments> <options>? }
    token command    { <[%_.&\w-]>+ }
    token options    { <option>+ % \h+ }
    token option     { '--' <long-opt> | '-' <short-opt> }
    token long-opt   { <opt-name> [ [ '=' | \h+ ] <opt-arg> ]? }
    token short-opt  { <opt-name> [ <.ws> <opt-arg> ]? }
    token opt-name   { <[-_\w]>+ }
    token gen-arg    { <[_:.&\w]> <[-_:.&\w]>* }
    token opt-arg    { <gen-arg> }
    token arguments  { <argument>+ % \h+ }
    token argument   { \S+ }
}

#===========================================================
sub getopt-parse(Str $line) is export {
    return Getopt::Long::Grammar.new.parse($line);
}

sub getopt-subparse(Str $line) is export {
    return Getopt::Long::Grammar.new.subparse($line);
}

sub getopt-interpret(Str $line) is export {
    my $actions = Getopt::Long::Grammar::Actions.new;
    return Getopt::Long::Grammar.new.parse($line, :$actions).made;
}