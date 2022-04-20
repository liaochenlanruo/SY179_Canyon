#!/usr/bin/env perl
use strict;
use warnings;

my %hash;
my @str;
open IN, "RC_bray.txt" || die;
open OUT, ">RC_bray.list" || die;

<IN>;
while (<IN>) {
	chomp;
	my @line = split /\t/;
	$line[0] =~ s/"//g;
	push @str,$line[0];
	print OUT "$line[0]\t$line[0]\t0\n";
}
close IN;
print join("\n",@str);


#my $count=-1;
open INF, "RC_bray.txt" || die;
<INF>;
while (<INF>) {
	chomp;
	my $count = 1;
	my @lines = split /\t/;
	for (my $i=1; $i<@lines; $i++) {
		my $j = $i-$count;
		$lines[0] =~ s/"//g;
		print OUT "$str[$j]\t$lines[0]\t$lines[$i]\n";
		#print OUT "$lines[0]\t$str[$j]\t$lines[$i]\n";
		$j++;
	}
}
close INF;
close OUT;
