#!/usr/bin/perl

$| = 1;

use CGI;
print CGI::header();

my $query = CGI->new;

use PBM::Patients;

use Text::Handlebars;
use File::Slurp;

my $patients_file = sprintf('%s/hbs/patients.hbs', $ENV{DOCUMENT_ROOT});

my $hbstemplate = File::Slurp::read_file($patients_file);

my $patientsdata = {
	patients => PBM::Patients::patients(),
};

print Text::Handlebars->new->render_string($hbstemplate, $patientsdata);
