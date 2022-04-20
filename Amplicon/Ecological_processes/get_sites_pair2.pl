#!/usr/bin/perl
use strict;
use warnings;

open IN, "bNTI_RCbray.txt" || die;
open OUT, ">bNTI_RCbray_pair.txt" || die;
<IN>;
while (<IN>) {
	chomp;
	#$_=~/(([A-Z])\.*\d+)\t(([A-Z])\.*\d+)\t(\S+)\t(\S+)/;
	$_=~/(([A-Z]).+)\t(([A-Z]).+)\t(\S+)\t(\S+)/;
	next if $1 eq $3;
	if ($2 gt $4) {
		if ($5 < -2) {
			print OUT $4 . " vs. " . $2 . "\t" . $5 . "\t" . $6 . "\t" . "Homogeneous selection" . "\n";
		}elsif ($5 > 2) {
			print OUT $4 . " vs. " . $2 . "\t" . $5 . "\t" . $6 . "\t" . "Heterogeneous selection" . "\n";
		}else {
			if ($6 < -0.95) {
				print OUT $4 . " vs. " . $2 . "\t" . $5 . "\t" . $6 . "\t" . "Homogenizing dispersal" . "\n";
			}elsif ($6 > 0.95) {
				print OUT $4 . " vs. " . $2 . "\t" . $5 . "\t" . $6 . "\t" . "Dispersal limitation" . "\n";
			}else {
				print OUT $4 . " vs. " . $2 . "\t" . $5 . "\t" . $6 . "\t" . "Drift" . "\n";
			}
		}
#		print OUT $2 . " vs. " . $1 . "\t" . $3 . "\t" . $4 . "\n";
	}elsif ($2 lt $4) {
		if ($5 < -2) {
			print OUT $2 . " vs. " . $4 . "\t" . $5 . "\t" . $6 . "\t" . "Homogeneous selection" . "\n";
		}elsif ($5 > 2) {
			print OUT $2 . " vs. " . $4 . "\t" . $5 . "\t" . $6 . "\t" . "Heterogeneous selection" . "\n";
		}else {
			if ($6 < -0.95) {
				print OUT $2 . " vs. " . $4 . "\t" . $5 . "\t" . $6 . "\t" . "Homogenizing dispersal" . "\n";
			}elsif ($6 > 0.95) {
				print OUT $2 . " vs. " . $4 . "\t" . $5 . "\t" . $6 . "\t" . "Dispersal limitation" . "\n";
			}else {
				print OUT $2 . " vs. " . $4 . "\t" . $5 . "\t" . $6 . "\t" . "Drift" . "\n";
			}
		}
#		print OUT $1 . " vs. " . $2 . "\t" . $3 . "\t" . $4 . "\n";
	}

	elsif ($2 eq $4) {
		if ($5 < -2) {
			print OUT $2 . "\t" . $5 . "\t" . $6 . "\t" . "Homogeneous selection" . "\n";
		}elsif ($5 > 2) {
			print OUT $2 . "\t" . $5 . "\t" . $6 . "\t" . "Heterogeneous selection" . "\n";
		}else {
			if ($6 < -0.95) {
				print OUT $2 . "\t" . $5 . "\t" . $6 . "\t" . "Homogenizing dispersal" . "\n";
			}elsif ($6 > 0.95) {
				print OUT $2 . "\t" . $5 . "\t" . $6 . "\t" . "Dispersal limitation" . "\n";
			}else {
				print OUT $2 . "\t" . $5 . "\t" . $6 . "\t" . "Drift" . "\n";
			}
		}
#		print OUT $1 . "\t" . $3 . "\t" . $4 . "\n";
	}

}
close IN;
close OUT;


my (%site, %process, %hash);
open IN, "bNTI_RCbray_pair.txt" || die;
open OUT, ">bNTI_RCbray_pair.stats" || die;
open OUTF, ">bNTI_RCbray_pair.stats.list" || die;

while (<IN>) {
	chomp;
	my @lines = split /\t/;
	$site{$lines[0]}++;
	$process{$lines[3]}++;
	$hash{$lines[0]}{$lines[3]}++;
}
close IN;

my @site = sort keys %site;
my @process = sort keys %process;
print OUT "Sites\t";
print OUT join("\t", @process) . "\n";

for (my $i=0; $i<@site; $i++) {
	print OUT $site[$i];
	for (my $j=0; $j<@process; $j++) {
		if (exists $hash{$site[$i]}{$process[$j]}) {
			print OUT "\t" . $hash{$site[$i]}{$process[$j]};
		}else {
			print OUT "\t0";
		}
	}
	print OUT "\n";
}
close OUT;

print OUTF "Sites\tEcological processes\tValue\n";
for (my $i=0; $i<@site; $i++) {
#	print OUT $site[$i];
	for (my $j=0; $j<@process; $j++) {
		if (exists $hash{$site[$i]}{$process[$j]}) {
			print OUTF $site[$i] . "\t$process[$j]\t" . $hash{$site[$i]}{$process[$j]} ."\n";
		}else {
			print OUTF $site[$i] . "\t$process[$j]\t0" . "\n";
		}
	}
}

close OUTF;