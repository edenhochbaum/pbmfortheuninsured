package PBM::Drugs;

use strict;
use warnings;

use Text::CSV;

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

sub get_pharmacies {
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

1;
