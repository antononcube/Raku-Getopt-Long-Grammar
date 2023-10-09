class Getopt::Long::Grammar::Actions {
    method TOP($/) {
        my %res;
        if $<command> { %res<command> = $<command>.Str }
        if $<getopt-args><option-list> { %res<options> = $<getopt-args><option-list>.made }
        if $<getopt-args><argument-list> { %res<arguments> = $<getopt-args><argument-list>.made }
        make %res;
    }

    method command($/) {
        make $/.Str;
    }

    method getopt-args($/) {
        make $/.values[0].made;
    }

    method option-list($/) {
        make $<option>>>.made.List;
    }

    method option($/) {
        make $/.values[0].made;
    }

    method opt-spec($/) {
        make {
            name => $<opt-name>.made,
            value => $<opt-val>.made // True
        }
    }

    method argument-list($/) {
        make $<argument>.map(*.made).List;
    }

    method opt-name($/) {
        make $/.Str;
    }

    method opt-val($/) {
        make $/.Str;
    }

    method argument($/) {
        make $/.Str;
    }
}
