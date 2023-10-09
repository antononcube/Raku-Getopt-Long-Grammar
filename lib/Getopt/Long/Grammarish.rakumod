role Getopt::Long::Grammarish {
    regex TOP {
        | <getopt-command> <getopt-args>?
        | <getopt-args>
    }

    regex getopt-args {
        | [<.getopt-delim> <option-list>]? [<.getopt-delim> <argument-list>]?
        | <.getopt-delim> <argument-list> [<.getopt-delim> <option-list>]? }

    token getopt-command { <.generic-arg> }
    token option-list { <option>+ % \h+ }
    token option { [ '--' | '-'] <opt-spec-pair> }
    token opt-spec-pair {
        <opt-name> [['=' | \h+] <opt-value>]?
    }
    token opt-name { <.generic-arg> }
    token opt-value { <.generic-arg> }
    token argument-list { <argument>+ % \h+ }
    token argument { <.generic-arg> }

    # Generic argument name or value
    token generic-arg { <-[-]> <-[=\s]>* || <getopt-quoted-string>  }

    # Quoted string
    regex getopt-quoted-string {
        '\'' ~ '\'' <-[']>*  || '"' ~ '"' <-["]>* || '⎡' ~ '⎦' <-[⎡⎦]>* || '«' ~ '»' <-[«»]>*
    }

    # The delimiter can be overridden in sub-classes, e.g.:
    #token getopt-delim { \h* [',' \h*]? }
    token getopt-delim { \h+ }
}
