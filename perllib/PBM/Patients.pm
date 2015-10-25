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
			address => '311 Arsenal Street, Watertown, MA',
			allergies => 'dust',
			sex => 'm',
		},
		{
			id => 2,
			name => 'Jane Doe',
			address => '1600 Pennsylvania Avenue, Washington, D.C.',
			allergies => 'pollen',
			sex => 'f',
		},
		{
			id => 3,
			name => 'Sam Smith',
			address => '36 Faneuil Street, Brighton, MA',
			allergies => 'none',
			sex => 'm',
		},
		{
			id => 4,
			name => 'John Doe',
			address => '35 Massachusetts Avenue, Cambridge, MA',
			allergies => 'none',
			sex => 'm',
		},
		{
			id => 5,
			name => 'Sara Doe',
			address => '80 Essex Avenue, Montclair, NJ',
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
