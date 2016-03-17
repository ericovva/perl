use 5.010;  # for say, given/when
use strict;
use warnings;
use Data::Printer;
BEGIN{
	if ($] < 5.018) {
		package experimental;
		use warnings::register;
	}
}
no warnings 'experimental';
use Data::Printer;
sub make_hash{ 
	my ($str) = @_;
	my (@ar) = split m{[/]}, $str;
	my %entity; 
	@entity{qw(band year album track format)} = (
		$ar[1],
		do{split m{[-]},$ar[2]},
		do{split m{[.]},$ar[3]}
		);
	return %entity;
}

1;