#!/usr/bin/perl

$| = 1;

use CGI;
print CGI::header();

my $query = CGI->new;

my $id = $query->param('id') || 'unknown';

use Text::Handlebars;
use File::Slurp;

my $patient_file = sprintf('%s/hbs/patient.hbs', $ENV{DOCUMENT_ROOT});

my $hbstemplate = File::Slurp::read_file($patient_file);

my $patientdata = {
	patientname => 'patient name',
	patientid => $id,
	pcp => 'pcp here',
	hpi => 'hpi here',
	allergies => 'allergies here',
	dischargeinstructions => 'discharge instructions here',
	meds => ['med1', 'med2', 'med3'],
};

print Text::Handlebars->new->render_string($hbstemplate, $patientdata);
