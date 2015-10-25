package PBM::Patients;

use strict;
use warnings;

sub name {
	my ($id) = @_;

	my $patient = get_patient_from_id($id);

	return $patient->{name};
}

sub patients {
	return [
		{
			id => 1,
			name => 'John Smith',
			address => '121 Center Court, Memphis, TN',
			allergies => 'dust',
			sex => 'm',
		},
		{
			id => 2,
			name => 'Jane Doe',
			address => '100 Riverset Ln, Memphis 38103',
			allergies => 'pollen',
			sex => 'f',
		},
		{
			id => 3,
			name => 'Sam Smith',
			address => '252 N Lauderdale St, Memphis, TN 38105',
			allergies => 'none',
			sex => 'm',
		},
		{
			id => 4,
			name => 'John Doe',
			address => '6420 Knight Arnold Rd, Memphis TN 38115',
			allergies => 'none',
			sex => 'm',
		},
		{
			id => 5,
			name => 'Sara Doe',
			address => '6015 Summer Trace, Memphis TN 38134',
			allergies => 'peanuts',
			sex => 'f',
		},
	],
}

sub get_patient_from_id {
	my ($id) = @_;

	return patients()->[$id-1];

}

1;
