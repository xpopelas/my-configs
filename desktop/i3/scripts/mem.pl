#!/usr/bin/env perl

use strict;
use warnings;
use feature qw(say);
use Capture::Tiny qw(capture);

my $mem = capture { system q{free -m | awk 'NR==2{printf "%0.0f\n",$3/$2*100}'} };

$mem =~ s/\s+//g;

if ( $mem < 50 ) {
	say qq{<span foreground=\"#51799d\">: $mem%</span>};
} elsif ( $mem < 70 ) {
	say qq{<span foreground=\"#f8f50e\">: $mem%</span>};
} else {
	say qq{<span foreground=\"#F80E27\">: $mem%</span>};
}