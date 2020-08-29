#!/usr/bin/env perl
exit;
use strict;
use warnings;
use feature qw(say);
use Capture::Tiny qw(capture);

my $color;
my $str;
my @stat;

sub get_updates {
	my $update = capture { system qq{cl-update -p | grep \"will be installed\"} };	
	return $update;
}

sub check_updates {
	my ($arg1, $arg2) = @_;	
	$arg1 = capture { system qq{echo '$arg1' | cut -d' ' -f 3}};
	$arg1 =~ s/\s+//g;
	return $arg1;
}

if ( $str = check_updates(get_updates) and $str ne "" ) {
	@stat = ( "#F80E27", ": $str" );
} else {
	@stat = ( "#bd806b", ": Up to Date" );	
}

say "<span foreground=\"$stat[0]\">$stat[1]</span>";