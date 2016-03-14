#!/usr/bin/env perl 
use 5.010;  # for say, given/when
use strict;
use warnings;
use Getopt::Long;
#use strict;
#use warnings;
use Data::Printer;
#BEGIN { push(@INC, '/lib/'); }
use lib::Local::Hashmaker;
use lib::Local::Sort_and_filter;
use lib::Local::DrawTable;
#--band 'Midas Fall' --sort track --columns year,band,album,track,year
my $band = '';   
my $sort = '';
my $columns = '';
my $format ='';      
my $album = '';
my $year = '';
my $track = '';
GetOptions ('band=s' => \$band, 
			'sort=s' => \$sort, 
			'columns=s' => \$columns, 
			'format=s' => \$format,
			'album=s' => \$album,
			'year=i' => \$year,
			'track=s' => \$track
			);
#print "$band, $sort $columns\n";
my @ar1;
while (<>) {
	my %h = make_hash($_);
	push (@ar1, \%h);
}
	#p @ar1; 
{
	package Sort_and_filter;
	my_sort(\@ar1,$sort);
	my $length_hash = filter(\@ar1,$band,$year,$album,$track,$format);
	#p %$length_hash;

	DrawTable::draw(\@ar1,\%$length_hash,$columns);
}

	
