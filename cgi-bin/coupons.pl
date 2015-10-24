#!/usr/bin/perl

$| = 1;

use CGI;
print CGI::header();

my $query = CGI->new;

my $params = $query->Vars;

print sprintf('patient id is [%s]', $params->{patientid});

print '<br>';

my @onmeds = grep { $_ =~ /^med_/ && $params->{$_} eq 'on'} keys %$params;
print '<br>';
print sprintf('on meds are: [%s]', join(', ', @onmeds));
