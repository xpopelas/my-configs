#!/usr/bin/env perl

use strict;
use warnings;
use feature qw(say);
use Capture::Tiny qw(capture);

my $ip = capture { system qq{curl -s http://api.ipify.org} };

if ( -d "/proc/sys/net/ipv4/conf/tun0" ) {
	 say " $ip";
} elsif ( -d "/proc/sys/net/ipv4/conf/ppp0" ) {
	 say " $ip";
} else {
	say "Hidden";
}
