#!/usr/bin/perl

$| = 1;

use strict;
use warnings;

use CGI;
use Text::Handlebars;
use File::Slurp;
use PBM::Drugs;

print CGI::header();

my $query = CGI->new;

my $params = $query->Vars;

my @onmeds = grep { $_ =~ /^med_/ && $params->{$_} eq 'on'} keys %$params;
@onmeds = map { $_ =~ /^med_(.*)$/ } @onmeds;

use Data::Dumper;

my $coupons_file = sprintf('%s/hbs/coupons.hbs', $ENV{DOCUMENT_ROOT});

my $hbstemplate = File::Slurp::read_file($coupons_file);

my $couponsdata = PBM::Drugs::get_pharmacies_for_drugs(\@onmeds);
my $pharmacies = PBM::Drugs::get_pharmacies();

print Text::Handlebars->new->render_string($hbstemplate, {
	pharmacies => $pharmacies,
	drugs => [
		map {
			my $drugname = $_;
			+{
				name => $drugname,
				pharmacy => {
					value => [ map { (values $couponsdata->{$drugname})[$_-1] } (1 .. scalar(@$pharmacies)) ],
				},
			};
		} @onmeds
	],
	totals => PBM::Drugs::get_pharmacy_total_prices_for_drugs(\@onmeds),
	bestpharmacy => PBM::Drugs::get_best_pharmacy_for_drugs(\@onmeds),
});
