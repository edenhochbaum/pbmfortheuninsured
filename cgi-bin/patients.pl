#!/usr/bin/perl

$| = 1;

use CGI;
print CGI::header();

my $query = CGI->new;

use Text::Handlebars;
use File::Slurp;

my $patients_file = sprintf('%s/hbs/patients.hbs', $ENV{DOCUMENT_ROOT});

my $hbstemplate = File::Slurp::read_file($patients_file);

my $patientsdata = {
	patients => [
		{
			name => 'John Smith',
			id => 1,
		},
		{
			name => 'Jane Doe',
			id => 2,
		},
		{
			name => 'Sam Smith',
			id => 3,
		},
		{
			name => 'Sara Smith',
			id => 4,
		},
		{
			name => 'John Doe',
			id => 5,
		},
	],
};

print Text::Handlebars->new->render_string($hbstemplate, $patientsdata);
