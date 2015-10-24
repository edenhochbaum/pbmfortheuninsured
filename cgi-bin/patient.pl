#!/usr/bin/perl

$| = 1;

use CGI;
use PBM::Drugs;

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
	meds => PBM::Drugs::get_drug_names(),
};

print Text::Handlebars->new->render_string($hbstemplate, $patientdata);
