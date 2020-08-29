#!/usr/bin/env perl

use strict;
use warnings;
use feature qw(say);
use File::Find;

my $dir = "/home/pheonix/.local/share/Trash/files/";
my $counter = 0;

find(\&wanted, $dir);

if ( $counter == 0 ) {
	say "";#qq{<span foreground=\"#bd806b\">: $counter</span>};
} else {
	say qq{<span foreground=\"#F80E27\">: $counter</span>};
}

sub wanted {
    -f && $counter++;
}

if ($ENV{'BLOCK_BUTTON'} == 1) {
		system qq{pcmanfm 'trash:///'};	
}
elsif ($ENV{'BLOCK_BUTTON'} == 3) {
	system qq{trash-empty};   	
}