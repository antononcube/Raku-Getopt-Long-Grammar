class Getopt::Long::Grammar::Actions {
    method TOP($/) {
        my %res;
        if $<command> { %res<command> = $<command>.Str }
        if $<option-list> { %res<options> = $<option-list>.made }
        if $<argument-list> { %res<arguments> = $<argument-list>.made }
        make %res;
    }

    method command($/) {
        make $/.Str;
    }

    method option-list($/) {
        make $<option>>>.made.List;
    }

    method option($/) {
        make $/.values[0].made;
    }

    method long-opt($/) {
        make {
            name => $<opt-name>.made,
            value => $<opt-arg>.made // True
        }
    }

    method short-opt($/) {
        make {
            name => $<opt-name>.made,
            value => $<opt-arg>.made // True,
        }
    }

    method argument-list($/) {
        make $<argument>.map(*.made).List;
    }

    method opt-name($/) {
        make $/.Str;
    }

    method opt-arg($/) {
        make $/.Str;
    }

    method argument($/) {
        make $/.Str;
    }
}
