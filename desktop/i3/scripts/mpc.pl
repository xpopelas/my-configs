#!/usr/bin/env perl

use strict;
use warnings;
use feature qw(say);
use Capture::Tiny qw(capture);

sub filter {
	return "tr '\n' ' ' | grep -Po '.*(?= \[playing\])|paused' | tr -d '\n'";
}

sub get_songs {
	my ($arg1, $arg2) = @_;	
	if ($arg1 eq "play") {
		my $NCMP = capture { system q{mpc | grep "^\[playing\]" | awk '{print $1}'}};	
		$NCMP =~ s/\s+//g;
		return $NCMP;
	} elsif ($arg1 eq "length") {
		my $NUM_NCMP = capture { system qq{mpc | head -1 | wc -c}};
		$NUM_NCMP =~ s/\s+//g;
		return $NUM_NCMP;
	} elsif ($arg1 eq "rename") {
		my $S_NCMP = capture { system qq{mpc | head -1 | head -c 30}};
		$S_NCMP =~ s/\s*$//g;
		return $S_NCMP;
	} else {
		my $MPC_CURRENT = capture { system qq{mpc current}};
		$MPC_CURRENT =~ s/\s*$//g;
		return $MPC_CURRENT;
	}
}

sub print_status {
	if (get_songs("play") eq "[playing]" ) { 
	    if (get_songs("length") lt 30) {
	    	my $song = get_songs("sp");
	        say " : $song";
	    } else {
	    	my $song = get_songs("rename");
	        say " : $song...";
	    }    
	} else {
	    say " : Pause ";
	}	
}

print_status;

my $filter = filter;

if ($ENV{'BLOCK_BUTTON'} == 1) {
	system qq{sh ~/.i3/lmc toggle | $filter};
}
elsif ($ENV{'BLOCK_BUTTON'} == 4) {
	system qq{sh ~/.i3/lmc next | $filter};
}
elsif ($ENV{'BLOCK_BUTTON'} == 5) {
	system qq{sh ~/.i3/lmc prev | $filter};
}