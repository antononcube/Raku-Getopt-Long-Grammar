role Getopt::Long::Grammarish {
    regex TOP {
        | <command> [<.delim> <option-list>]? [<.delim> <argument-list>]?
        | <command> <.delim> <argument-list> [<.delim> <option-list>]? }
    token delim { \h* [',' \h+]? }
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
    token gen-arg { <-[-]> <-[=\s]>* || <quoted-string>  }
    token opt-arg { <gen-arg> }
    token argument-list { <argument>+ % \h+ }
    token argument { <gen-arg> }
    regex quoted-string { '\'' ~ '\'' <-[']>*  || '"' ~ '"' <-["]>* || '⎡' ~ '⎦' <-[⎡⎦]>* || '«' ~ '»' <-[«»]>* }
}
