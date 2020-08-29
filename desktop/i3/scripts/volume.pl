#!/usr/bin/env perl

use strict;
use warnings;
use feature qw(say);

my $volumeicon;

my $volume = qx{amixer get Master | grep -E -o '[0-9]{1,3}?%' | head -1};

my $nvolume = substr($volume, 0, -2);

#print $nvolume;

if($nvolume == int(0)) {
     $volumeicon = "";
 } else {
     $volumeicon = "";
 }

print "$volumeicon $volume","\n";

if ($ENV{'BLOCK_BUTTON'} == 1) {
    system qq{pavucontrol};
}
elsif ($ENV{'BLOCK_BUTTON'} == 4) {
    if($nvolume != int(100)) {	
        system q{sh ~/.i3/lmc up};	
    } else {
        system qq{i3-nagbar -t warning -m 'Volume set to MAX'};
    }
}
elsif ($ENV{'BLOCK_BUTTON'} == 5) {
    if($nvolume != int(0)) {
        system q{sh ~/.i3/lmc down};
    } else {
        system qq{i3-nagbar -t warning -m 'Volume set to MIN'};
    }
}



