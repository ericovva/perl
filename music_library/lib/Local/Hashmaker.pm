use 5.010;  # for say, given/when
use strict;
use warnings;
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
	my @arr = split m{[/.-]}, $str;
	my %entity = ();
	my $i = 0;
	for my $elem (@arr) {
		next if $elem =~ /^\s*$/;
		$elem =~ s/^\s+//;
		$elem =~ s/\s+$//;
		given ($i){
			when ($i == 0){ $entity{'band'} = $elem; }
			when ($i == 1){ $entity{'year'} = $elem; }
			when ($i == 2){ $entity{'album'} = $elem; }
			when ($i == 3){ $entity{'track'} = $elem; }
			when ($i == 4){ $entity{'format'} = $elem; }
		}
		$i++;
	}
	return %entity;
}

1;