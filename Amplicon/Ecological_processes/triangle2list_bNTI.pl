#!/usr/bin/env perl
use strict;
use warnings;

my %hash;
my @str;
open IN, "fungi_weighted_bNTI.csv" || die;
open OUT, ">fungi_weighted_bNTI.txt" || die;

<IN>;
while (<IN>) {
	chomp;
	my @line = split /,/;
	push @str,$line[0];
	print OUT "$line[0]\t$line[0]\t0\n";
}
close IN;
print join("\n",@str);


#my $count=-1;
open INF, "fungi_weighted_bNTI.csv" || die;
<INF>;
while (<INF>) {
	chomp;
	my $count = 1;
	my @lines = split /,/;
	for (my $i=1; $i<@lines; $i++) {
		my $j = $i-$count;
		if ($lines[$i] ne "NA") {
			print OUT "$str[$j]\t$lines[0]\t$lines[$i]\n";
		}
		#print OUT "$lines[0]\t$str[$j]\t$lines[$i]\n";
		$j++;
	}
}
close INF;
close OUT;
