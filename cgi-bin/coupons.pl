#!/usr/bin/perl

$| = 1;

use strict;
use warnings;

use CGI;
use PBM::Drugs;

print CGI::header();

my $query = CGI->new;

my $params = $query->Vars;

print sprintf('patient id is [%s]', $params->{patientid});

print '<br><br>';

my @onmeds = grep { $_ =~ /^med_/ && $params->{$_} eq 'on'} keys %$params;
print sprintf('on meds are: [%s]', join(', ', map { $_ =~ /^med_(.*)$/ } @onmeds));

print '<br><br>';

my $drugs = PBM::Drugs::get_all_data();

use Data::Dumper;

print Dumper($drugs);

print 'foobar';
