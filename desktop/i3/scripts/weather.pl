#!/usr/bin/env perl

use strict;
#use warnings;
use feature qw(say);
use Capture::Tiny qw(capture);

my $num = @ARGV;
my $METRIC = 1;
 
if ($num != 1) {

	print "\nUSAGE: weather.pl <locationcode>\n\n";
	exit;
}

my $url = capture { system qq{curl -s 'http://rss.accuweather.com/rss/liveweather_rss.asp?metric=$METRIC&locCode=EN|AU|$ARGV[0]|BALAKLAVA' | grep 'Currently:'} };


sub check_url {
	if ($url =~ /Currently/) {
		return 1;
	}
	return 0;
}

sub check_condition {

	my $str;

	if($_[0] eq "Sunny" || $_[0] eq "Mostly Sunny" || $_[0] eq "Partly Sunny" || $_[0] eq "Intermittent Clouds" || $_ [0]eq "Hazy Sunshine" || 
		$_[0] eq "Hazy Sunshine" || $_[0] eq "Hot") 
	{ 
		$str = $str . "";
	}
	if($_[0] eq "Mostly Cloudy" || $_[0] eq "Cloudy" || $_[0] eq "Dreary (Overcast)" || $_[0] eq "Fog") 
	{ 
		$str = $str . "";
	}
	if( $_[0] eq "Showers" || $_[0] eq "Mostly Cloudy w/ Showers" || $_[0] eq "Partly Sunny w/ Showers" || $_[0] eq "T-Storms" || 
		$_[0] eq "Mostly Cloudy w/ T-Storms" || $_[0] eq "Partly Sunny w/ T-Storms" || $_[0] eq "Rain")
	{
		$str = $str . "";
	}
	if( $_[0] eq "Windy")
	{
		$str = $str . "";
	} 
	if($_[0] eq "Flurries" || $_[0] eq "Mostly Cloudy w/ Flurries" || $_[0] eq "Partly Sunny w/ Flurries" || $_[0] eq "Snow" || 
		$_[0] eq "Mostly Cloudy w/ Snow" || $_[0] eq "Ice" || $_[0] eq "Sleet" || $_[0] eq "Freezing Rain" || $_[0] eq "Rain and Snow" || 
		$_[0] eq "Cold")
	{
		$str = $str . "";
	}
	if($_[0] eq "Clear" || $_[0] eq "Mostly Clear" || $_[0] eq "Partly Cloudy" || $_[0] eq "Intermittent Clouds" || 
		$_[0] eq "Hazy Moonlight" || $_[0] eq "Mostly Cloudy" || $_[0] eq "Partly Cloudy w/ Showers" || $_[0] eq "Mostly Cloudy w/ Showers" || 
		$_[0] eq "Partly Cloudy w/ T-Storms" || $_[0] eq "Mostly Cloudy w/ Flurries" || $_[0] eq "Mostly Cloudy w/ Snow")
	{
		$str = $str . "";
	}

	return $str;	

}

if (check_url) {
	
	$url =~ s/			<title>Currently: +//;
	$url =~ s/\<\/title\>+//;

	my @values=split(":",$url); 
	
	my $type = $values[0];	
	my $temp = $values[1];		
	

	my $weather = check_condition($type) . $temp;
	$weather =~ s/\s*$//;
	say $weather;

} else {
	say "\nURL Failed to fetch current weather.";
}

