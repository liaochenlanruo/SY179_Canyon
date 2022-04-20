#!/usr/bin/perl
use strict;
use warnings;

my %hash;
open IN, "RC_bray.list" || die;
while (<IN>) {
	chomp;
	my @lines = split;
	$hash{$lines[0]}{$lines[1]} = $lines[2];
	$hash{$lines[1]}{$lines[0]} = $lines[2];
}
close IN;

open IN, "fungi_weighted_bNTI.txt" || die;
open OUT, ">bNTI_RCbray.txt" || die;
print OUT "Site1\tSite2\tbNTI\tRCbray\n";
while (<IN>) {
	chomp;
	my @lines = split;
	if (exists $hash{$lines[0]}{$lines[1]}) {
		print OUT "$lines[0]\t$lines[1]\t$lines[2]\t" . $hash{$lines[0]}{$lines[1]} . "\n";
	}else{
		print OUT "$lines[0]\t$lines[1]\t$lines[2]\t" . "NA\n";
	}
}
close IN;
close OUT;
