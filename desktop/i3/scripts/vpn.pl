#!/usr/bin/env perl

use strict;
use warnings;
use feature qw(say);
use Capture::Tiny qw(capture);

my @stat;

sub check_status {
	if ( -d "/proc/sys/net/ipv4/conf/tun0" ) {
		return 1;
	} elsif ( -d "/proc/sys/net/ipv4/conf/ppp0" ) {
		return 1;
	} else {
		return 0;
	}	
}

sub proc_status {
	if (check_status == 1) {
		@stat = ( "#95c5f6", ": On" );
	} else {
		@stat = ( "#F80E27", ": Off" );
	}	
}

sub get_cur_con {
	my $con = capture { system qq{nmcli -t -f name,type,device con | grep vpn | grep eth0} };
	my ($name, $type, $dev) = split /:/, $con;
	if (length($name) > 1){
		return $name;
	}
	return "mullvad_au-mel";
}

sub sel_con {
	my $con = capture { system qq{nmcli -t -f name,type con | grep vpn} };
	my @cons = split /\n/, $con;
	
	my $arnum = scalar(grep {defined $_} @cons), "\n";
	
	if($arnum > 1) {
		$con = $cons[int(rand(@cons))];		
	}
	
	my ($name, $type) = split /:/, $con;
	if (length($name) > 1){
		return $name;
	}
	return "mullvad_au-mel";
}

proc_status;

say qq{<span foreground=\"$stat[0]\">$stat[1]</span>};

if ($ENV{'BLOCK_BUTTON'} == 1) {
	if ( check_status == 0 ) {
		my $name = sel_con;
		system qq{nmcli con up id $name};
		system qq{sh ~/.i3/lmc con};
	} else {
		system qq{i3-nagbar -t warning -m 'VPN is already Connected, No need to connect again'};
		system qq{sh ~/.i3/lmc con};	
	}
}
elsif ($ENV{'BLOCK_BUTTON'} == 2) {
	system qq{nm-connection-editor};
	system qq{sh ~/.i3/lmc con};
}
elsif ($ENV{'BLOCK_BUTTON'} == 3) {
	if ( check_status == 1 ) {
		my $name = get_cur_con;
		system qq{nmcli con down id $name};				
		system qq{sh ~/.i3/lmc con};
	} else {
		system qq{i3-nagbar -t warning -m 'VPN is already Disconnected, No need to disconnect again'};
		system qq{sh ~/.i3/lmc con};
	}
}