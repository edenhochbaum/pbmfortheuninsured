#!/usr/bin/perl

$| = 1;

use CGI;
print CGI::header();

my $query = CGI->new;

my $id = $query->param('id') || 'unknown';

use Text::Handlebars;

print sprintf('stand-in for patient id [%s]', $id);
