package PBM::Drugs;

use strict;
use warnings;

use Text::CSV;

sub naive_string_inlist {
	my ($elem, @list) = @_;

	foreach my $l (@list) {
		return 1 if ($elem eq $l);
	}
	return 0;
}

# returns listref of hashrefs, with each hashref having Drug, Id, and locations
sub get_all_data {
	my $csv = Text::CSV->new({ sep_char => ',' });
	my $file = sprintf('%s/data/drugs.csv', $ENV{DOCUMENT_ROOT});
	open(my $data, '<', $file) or die "Could not open '$file' $!\n";

	my $header = <$data>;
	chomp $header;
	$csv->parse($header);
	my @fields = $csv->fields();

	my @elements;
	while (my $datum = <$data>) {
		chomp $datum;

		if ($csv->parse($datum)) {
			my %elem;
			@elem{@fields} = $csv->fields();
			push(@elements, \%elem);
		}
	}
	return \@elements;
}

sub get_drug_names {
	my $elements = get_all_data();
	return [ map { $_->{Drug} } @$elements ];
}

sub get_pharmacies { # TODO: canonical order isn't guaranteed
	my $elements = get_all_data();
	return [grep { $_ !~ /^Drug$/ and $_ !~ /^Id$/ } keys($elements->[0])]
}

sub drug_to_id_map {
	my $elements = get_all_data();
	return +{
		map {
			($_->{Drug} => $_->{Id});
		} @$elements
	};
}

sub id_to_drug_map {
	my $elements = get_all_data();
	return +{
		map {
			($_->{Id} => $_->{Drug})
		} @$elements
	};
}

# removes the ids
sub drug_map_to_elements {
	my $elements = get_all_data();
	return +{
		map {
			delete($_->{Id});
			(delete($_->{Drug}) => $_)
		} @$elements
	};
}

# takes listref of drugs
# returns a hashref of { drug => [pharmacy => price] }
sub get_pharmacies_for_drugs {
	my ($drugs) = @_;

	my @pharmacies = @{get_pharmacies()};

	my $drug_map_to_elements = drug_map_to_elements();

	my $rv = {};

	foreach my $drug (@$drugs) {
		$rv->{$drug} = $drug_map_to_elements->{$drug};
	}

	return $rv;
}

# return listref of prices for the given drug, ordered by pharmacy canonical order
sub get_ordered_pharmacy_prices_for_drug {
	my ($drug) = @_;

	my @drugs = @{get_drug_names()};

	unless (naive_string_inlist($drug, @drugs)) {
		die sprintf('drug [%s] not in list [%s]', $drug, join(', ', @drugs));
	}

	my $drugmaptoelements = drug_map_to_elements()->{$drug};

	return [values %$drugmaptoelements];
}

# return listref of summed prices for the given drugs, ordered by pharmacy canonical order
sub get_pharmacy_total_prices_for_drugs {
	my ($drugssubset) = @_;

	my @drugssubset = @$drugssubset;
	my @alldrugs = @{get_drug_names()};

	foreach my $drug (@drugssubset) {
		unless (naive_string_inlist($drug, @alldrugs)) {
			die sprintf('drug [%s] not in list [%s]', $drug, join(', ', @alldrugs));
		}
	}

	my $totals = [(0) x @{get_pharmacies()}];

	foreach my $drug (@drugssubset) {
		$totals = _array_sum($totals, get_ordered_pharmacy_prices_for_drug($drug));
	}

	return $totals;
}

# TODO: amateur hour: bad on 0-length arrays, arrays w/o numeric entries, etc.
sub _array_sum {
	my ($array1, $array2) = @_;

	my @array1 = @$array1;
	my @array2 = @$array2;

	unless (@array1 == @array2) {
		die sprintf('different sizes [%i] vs. [%i] for array1 and array2', scalar(@array1), scalar(@array2));
	}

	my @sums;

	foreach my $i (0 .. @array1-1) {
		push(@sums, $array1[$i]+$array2[$i]);
	}

	return \@sums;
}

1;
