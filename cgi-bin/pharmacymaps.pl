#!/usr/bin/perl

$| = 1;

print 'Content-Type: application/json', "\n\n";
use JSON;

my $addresses = [
	{
		label => 'white house',
		address => '1600 Pennsylvania Avenue, Washington, D.C.',
	},
	{
		label => 'whirlybird',
		address => '36 Faneuil Street, Brighton, 02135',
	},
	{
		label => 'athena health hq',
		address => '311 Arsenal Street, Watertown, MA',
	},
];

print encode_json($addresses);

