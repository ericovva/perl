package Sort_and_filter;
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
no strict; no warnings;
no warnings 'experimental';
sub my_sort{
	my ($arr_ref,$sort_key) = @_;
	if ($sort_key){
		given ($sort_key) {
		when($sort_key eq "year"){
			if (@$arr_ref){
				 @$arr_ref = sort {$a->{$sort_key} <=> $b->{$sort_key}} @$arr_ref;
		    	#p @$arr_ref;
			}
		   
		}
		default {
			if (@$arr_ref){
				@$arr_ref = sort {$a->{$sort_key} cmp $b->{$sort_key}} @$arr_ref ;
			}
			
		    #p @$arr_ref;
		}
	}

	}
	
}
sub search{
	my ($arr_ref,$i,$column,$column_value) = @_;
	if ($column_value ne '') {  
		if ($column eq "year"){
			if (${$arr_ref}[$i] ->{$column} + 0 != $column_value){
				return 0;
			}
		}
		elsif ( ${$arr_ref}[$i] ->{$column} ne $column_value ){ 
			return 0;
		} 
	}
	return 1;
}

sub filter{
	my ($arr_ref,$band,$year,$album,$track,$format) = @_;
	my %length_hash;

	# };
	# while (@arr) {
	#   my $hash = shift(@arr);
	#   if ($band ne '') {  if ( $hash ->{"band"} ne $band ){ delete $hash;} }
	# }
	for my $i (0..$#{$arr_ref}) {
		if (search($arr_ref,$i,"band",$band) && search($arr_ref,$i,"year",$year) &&
		search($arr_ref,$i,"album",$album) && search($arr_ref,$i,"track",$track) &&
		search($arr_ref,$i,"format",$format) ){
			if (%length_hash){
				if ($length_hash{'band'} < length ${$arr_ref}[$i] ->{'band'}){ 
					$length_hash{'band'} =  length ${$arr_ref}[$i] ->{'band'};
				}
				if ($length_hash{'year'} < length ${$arr_ref}[$i] ->{'year'}){
					$length_hash{'year'} =  length ${$arr_ref}[$i] ->{'year'};
				}
				if ($length_hash{'album'} < length ${$arr_ref}[$i] ->{'album'}){
					$length_hash{'album'} =  length ${$arr_ref}[$i] ->{'album'};
				}
				if ($length_hash{'track'} < length ${$arr_ref}[$i] ->{'track'}){
					$length_hash{'track'} =  length ${$arr_ref}[$i] ->{'track'};
				}
				if ($length_hash{'format'} < length ${$arr_ref}[$i] ->{'format'}){
					$length_hash{'format'} =  length ${$arr_ref}[$i] ->{'format'};
				}

			}
			else {
				$length_hash{'band'} = length ${$arr_ref}[$i] ->{'band'};
				$length_hash{'year'} = length ${$arr_ref}[$i] ->{'year'};
				$length_hash{'album'} = length ${$arr_ref}[$i] ->{'album'};
				$length_hash{'track'} = length ${$arr_ref}[$i] ->{'track'};
				$length_hash{'format'} = length ${$arr_ref}[$i] ->{'format'};

			}
			
			next;
		}
		else {
			delete ${$arr_ref}[$i];
		}
	}
	#p @$arr_ref;
	#p %length_hash;
	return \%length_hash;
}	

1;
