role Getopt::Long::Grammarish {
    regex TOP {
        | <command> [<.getopt-delim> <option-list>]? [<.getopt-delim> <argument-list>]?
        | <command> <.getopt-delim> <argument-list> [<.getopt-delim> <option-list>]? }

    token command { <gen-arg> }
    token option-list { <option>+ % \h+ }
    token option { '--' <long-opt> | '-' <short-opt> }
    token long-opt {
        <opt-name> [['=' | \h+] <opt-arg>]?
    }
    token short-opt {
        <opt-name> [['=' | \h+] <opt-arg>]?
    }
    token opt-name { <gen-arg> }
    token gen-arg { <-[-]> <-[=\s]>* || <getopt-quoted-string>  }
    token opt-arg { <gen-arg> }
    token argument-list { <argument>+ % \h+ }
    token argument { <gen-arg> }

    # Quoted string
    regex getopt-quoted-string {
        '\'' ~ '\'' <-[']>*  || '"' ~ '"' <-["]>* || '⎡' ~ '⎦' <-[⎡⎦]>* || '«' ~ '»' <-[«»]>*
    }

    # The delimiter can be overridden in sub-classes, e.g.:
    #token getopt-delim { \h* [',' \h*]? }
    token getopt-delim { \h+ }
}
