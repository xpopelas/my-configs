#!/usr/bin/env perl

use strict;
use warnings;
use feature qw(say);
use Capture::Tiny qw(capture);

my $home;
my $root;
my $num_args = @ARGV;

sub get_home {
	$home = capture { system qq{df -h | grep '/home/' | awk '{print \$4}'} };
	$home =~ s/\s+//g;
	say $home;
}

sub get_root {
	$root = capture { system qq{df -h | grep '/sdb2' | awk '{print \$4}'} };
  	$root =~ s/\s+//g;
	say $root;

}

if ($num_args != 1) {    
    exit;
}
else {
    if ($ARGV[0] eq "home") {
    	get_home;
    }
    elsif ($ARGV[0] eq "root") {
    	get_root;
    }
}