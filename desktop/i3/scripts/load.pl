#!/usr/bin/env perl

use strict;
use warnings;
use feature qw(say switch);
use Capture::Tiny qw(capture);


my $load = capture { system q{uptime | awk '{print $(NF-2)}'} };
$load =~ s/\,\s*$//g;

sub get_color {
	given (shift) {
		when ($_ < 4.4) {
			return "#51799d";
		}
		when ($_ < 8.2) {
			return "#f8f50e";
		} 
		default {
			return "#F80E27";
		}
	}
}

say "<span foreground=\"" . get_color($load) . "\">: $load</span>";