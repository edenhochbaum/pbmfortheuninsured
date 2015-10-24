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
	my $elements = get_drugs();
	return [ map { $_->{Drug} } @$elements ];
}

1;
