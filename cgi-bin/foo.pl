#!/usr/bin/perl

$| = 1;

use strict;
use warnings;

use CGI;
print CGI::header();

use PBM::Drugs;

my $d = PBM::Drugs::get_drugs();

print sprintf('drugs are: %s', $d);
