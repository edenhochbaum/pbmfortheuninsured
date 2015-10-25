#!/usr/bin/perl

$| = 1;

use CGI;
use PBM::Drugs;
use PBM::Patients;

print CGI::header();

my $query = CGI->new;

my $address = $query->param('address') || 'unknown';

use Text::Handlebars;
use File::Slurp;

my $patient_file = sprintf('%s/hbs/map.hbs', $ENV{DOCUMENT_ROOT});

my $hbstemplate = File::Slurp::read_file($patient_file);

my $mapdata = {
	address => $address,
};

print Text::Handlebars->new->render_string($hbstemplate, $mapdata);
