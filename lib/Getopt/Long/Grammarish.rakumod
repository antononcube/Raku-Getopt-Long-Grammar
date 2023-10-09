role Getopt::Long::Grammarish {
    regex TOP {
        | <getopt-command> [<.getopt-delim> <getopt-args>]?
        | <getopt-args>
    }

    regex getopt-args {
        | <option-list>? [<.getopt-delim> <argument-list>]?
        | <argument-list> [<.getopt-delim> <option-list>]? }

    token getopt-command { <.generic-arg> }
    token option-list { <option>+ % \h+ }
    token option { [ '--' | '-'] <option-pair> }
    token option-pair {
        <option-name> [['=' | \h+] <option-value>]?
    }
    token option-name { <.generic-arg> }
    token option-value { <.generic-arg> }
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
