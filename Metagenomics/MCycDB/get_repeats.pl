#!/usr/bin/perl
use strict;
use warnings;

my %hash;
open IN, $ARGV[0] || die;
open OUT, ">$ARGV[1]" || die;

while (<IN>) {
	chomp;
	$_=~ s/[\r\n]+//g;
	$hash{$_}++;
}
close IN;

foreach  (keys %hash) {
	print OUT "$_\t$hash{$_}\n";
}
close OUT;
