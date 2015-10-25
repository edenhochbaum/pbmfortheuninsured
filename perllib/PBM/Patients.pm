package PBM::Patients;

use strict;
use warnings;

sub name {
	my ($id) = @_;

	return 'john.'.$id;
}

sub patients {
	return [
		{
			id => 1,
			name => 'John Smith',
			allergies => 'dust',
			sex => 'm',
		},
		{
			id => 2,
			name => 'Jane Doe',
			allergies => 'pollen',
			sex => 'f',
		},
		{
			id => 3,
			name => 'Sam Smith',
			allergies => 'none',
			sex => 'm',
		},
		{
			id => 4,
			name => 'Sara Doe',
			allergies => 'peanuts',
			sex => 'f',
		},
		{
			id => 5,
			name => 'John Doe',
			allergies => 'none',
			sex => 'm',
		},

	],
}

1;
