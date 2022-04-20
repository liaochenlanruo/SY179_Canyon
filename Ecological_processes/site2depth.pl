#!/usr/bin/perl
use strict;
use warnings;

my %hash;
open IN, "sample-metadata.tsv" || die;
while (<IN>) {
	chomp;
	my @lines = split;
	$hash{$lines[0]} = $lines[3] . " cmbsf";
}
close IN;

open INF, "bNTI_RCbray.txt" || die;
open OUT, ">bNTI_RCbray_depth.txt" || die;
while (<INF>) {
	chomp;
	my @line = split;
	next if $line[0] eq $line[1];
	if (exists $hash{$line[0]}) {
		print OUT $hash{$line[0]} . "\t";
	}else {print OUT $line[0] . "\t";
	}if (exists $hash{$line[1]}) {
		print OUT $hash{$line[1]} . "\t" . "$line[2]\t$line[3]\n";
	}else {print OUT $line[1] . "\t" . "$line[2]\t$line[3]\n";
	}
}
close INF;
close OUT;
