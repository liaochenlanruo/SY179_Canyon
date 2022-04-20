#!/usr/bin/perl
use strict;
use warnings;

my %hash;
open IN, "gene2pathway.txt" || die;
<IN>;
while (<IN>) {
	chomp;
	$_=~s/[\n\r]+//g;
	$_=~/(\S+)\t(.+)/;
	$hash{$1} = $2;
}
close IN;

open INF, "SCyc.txt" || die;
open OUT, ">SCyc.PathWay.txt" || die;
<INF>;
while (<INF>) {
	chomp;
	$_=~s/[\n\r]+//g;
	my @lines = split /\t/;
	if (exists $hash{$lines[0]}) {
		print OUT "$_\t$hash{$lines[0]}\n";
	}else {
		print OUT "$_\n";
	}
}
close INF;
close OUT;
