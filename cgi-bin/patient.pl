#!/usr/bin/perl

$| = 1;

use CGI;
use PBM::Drugs;
use PBM::Patients;

print CGI::header();

my $query = CGI->new;

my $id = $query->param('id') || 'unknown';
my $sex = $query->param('sex') || 'unknown';

use Text::Handlebars;
use File::Slurp;

my $patient_file = sprintf('%s/hbs/patient.hbs', $ENV{DOCUMENT_ROOT});

my $hbstemplate = File::Slurp::read_file($patient_file);

my $patient = PBM::Patients::get_patient_from_id($id);

my $patientdata = {
	patientname => $patient->{name},
	patientid => $id,
	allergies => $patient->{allergies},
	meds => PBM::Drugs::get_drug_names(),
	sex => $sex,
};

print Text::Handlebars->new->render_string($hbstemplate, $patientdata);
