class Getopt::Long::Grammar::Actions {
    method TOP($/) {
        my %res;
        if $<command> { %res<command> = $<command>.Str }
        if $<options> { %res<options> = $<options>.made }
        if $<arguments> { %res<arguments> = $<arguments>.made }
        make %res;
    }

    method command($/) {
        make $/.Str;
    }

    method options($/) {
        make $<option>>>.made;
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

    method arguments($/) {
        make $<argument>.map(*.made);
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
