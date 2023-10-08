use Getopt::Long::Grammar::Actions;

grammar Getopt::Long::Grammar {
    regex TOP {
        | <command> [\h+ <options>]? [\h+ <arguments>]?
        | <command> \h+ <arguments> [\h+ <options>]? }
    token command { <gen-arg> }
    token options { <option>+ % \h+ }
    token option { '--' <long-opt> | '-' <short-opt> }
    token long-opt {
        <opt-name> [['=' | \h+] <opt-arg>]?
    }
    token short-opt {
        <opt-name> [['=' | \h+] <opt-arg>]?
    }
    token opt-name { <gen-arg> }
    token gen-arg { <-[-]> <-[=\s]>* || <quoted-string>  }
    token opt-arg { <gen-arg> }
    token arguments { <argument>+ % \h+ }
    token argument { <gen-arg> }
    regex quoted-string { '\'' ~ '\'' <-[']>*  || '"' ~ '"' <-["]>* || '⎡' ~ '⎦' <-[⎡⎦]>* || '«' ~ '»' <-[«»]>* }
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