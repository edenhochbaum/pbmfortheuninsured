#!/usr/bin/perl

$| = 1;

use CGI;
print CGI::header();

my $oldquery = CGI->new;

use Data::Dumper;
print Dumper($oldquery);

print 'just another';
