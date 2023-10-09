class Getopt::Long::Grammar::Actions {
    method TOP($/) {
        my %res;
        if $<getopt-command> { %res<command> = $<getopt-command>.Str }
        if $<getopt-args><option-list> { %res<options> = $<getopt-args><option-list>.made }
        if $<getopt-args><argument-list> { %res<arguments> = $<getopt-args><argument-list>.made }
        make %res;
    }

    method getopt-command($/) {
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

    method opt-spec-pair($/) {
        make {
            name => $<opt-name>.made,
            value => $<opt-value>.made // True
        }
    }

    method argument-list($/) {
        make $<argument>.map(*.made).List;
    }

    method opt-name($/) {
        make $/.Str;
    }

    method opt-value($/) {
        make $/.Str;
    }

    method argument($/) {
        make $/.Str;
    }
}
