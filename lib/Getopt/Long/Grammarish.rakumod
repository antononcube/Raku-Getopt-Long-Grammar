role Getopt::Long::Grammarish {
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
