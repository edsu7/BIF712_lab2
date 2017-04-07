#!/home/bif701_163a30/software/bin/perl

use strict;
use warnings;

my $humanHBB =  <<"_END_";
ORIGIN      
	1 acatttgctt ctgacacaac tgtgttcact agcaacctca aacagacacc atggtgcatc
       61 tgactcctga ggagaagtct gccgttactg ccctgtgggg caaggtgaac gtggatgaag
      121 ttggtggtga ggccctgggc aggctgctgg tggtctaccc ttggacccag aggttctttg
      181 agtcctttgg ggatctgtcc actcctgatg ctgttatggg caaccctaag gtgaaggctc
      241 atggcaagaa agtgctcggt gcctttagtg atggcctggc tcacctggac aacctcaagg
      301 gcacctttgc cacactgagt gagctgcact gtgacaagct gcacgtggat cctgagaact
      361 tcaggctcct gggcaacgtg ctggtctgtg tgctggccca tcactttggc aaagaattca
      421 ccccaccagt gcaggctgcc tatcagaaag tggtggctgg tgtggctaat gccctggccc
      481 acaagtatca ctaagctcgc tttcttgctg tccaatttct attaaaggtt cctttgttcc
      541 ctaagtccaa ctactaaact gggggatatt atgaagggcc ttgagcatct ggattctgcc
      601 taataaaaaa catttatttt cattgc
//
_END_

my $monkeyHBB = <<"_END_";
ORIGIN      
	1 acacttgctt ctgacacaac tgtgttcacg agcaacctca aacagacacc atggtgcatc
       61 tgactcctga ggagaagaat gccgtcacca ccctgtgggg caaggtgaac gtggatgaag
      121 ttggtggtga ggccctgggc aggctgctgg tggtctaccc ttggacccag aggttctttg
      181 agtcctttgg ggatctgtcc tctcctgatg ctgttatggg caaccctaag gtgaaggctc
      241 atggcaagaa agtgcttggt gcctttagtg atggcctgaa tcacctggac aacctcaagg
      301 gtacctttgc ccagctcagt gagctgcact gtgacaagct gcatgtggat cctgagaact
      361 tcaagctcct gggcaacgtg ctggtgtgtg tgctggccca tcactttggc aaagaattca
      421 ccccgcaagt gcaggctgcc tatcagaaag tggtggctgg tgtggctaat gccctggccc
      481 acaagtacca ctaagctcac tttcttgctg tccaatttct accaaaggtt cctttgttcc
      541 caaagtccaa ctactgaact gggggatatt atgaagggcc ttgaggatct ggattctgcc
      601 taat
//
_END_

$humanHBB =~ s/[^a-z]//g;
$monkeyHBB =~ s/[^a-z]//g;
$humanHBB =~ s/t/u/g;
$monkeyHBB =~ s/t/u/g;
$humanHBB = uc($humanHBB);
$monkeyHBB = uc($monkeyHBB);

my ($count, $percentage);
for (my $i=0; $i<length($humanHBB)||$i<length($monkeyHBB); $i++){
    if (substr($humanHBB,$i,1) eq substr($monkeyHBB,$i,1)){
        $count++;
        }
    }
$percentage =sprintf("%.4f",$count/length($humanHBB)*100);

$humanHBB =~ tr[AUCG][UAGC];
$monkeyHBB =~ tr[AUCG][UAGC];

my (@arrayX , @arrayY );
my %amino = (
     AAA=>"K", AAG=>"K",
     GAA=>"E", GAG=>"E",
     AAC=>"N", AAU=>"N",
     GAC=>"D", GAU=>"D",
     ACA=>"T", ACC=>"T", ACG=>"T", ACU=>"T", 
     GCA=>"A", GCC=>"A", GCG=>"A", GCU=>"A",
     GGA=>"G", GGC=>"G", GGG=>"G", GGU=>"G",
     GUA=>"V", GUC=>"V", GUG=>"V", GUU=>"V",
     AUG=>"M",
     UAA=>"*", UAG=>"*", UGA=>"*",
     AUC=>"I", AUU=>"I", AUA=>"I",
     UAC=>"Y", UAU=>"Y",
     CAA=>"Q", CAG=>"Q",
     AGC=>"S", AGU=>"S",
     UCA=>"S", UCC=>"S", UCG=>"S", UCU=>"S",
     CAC=>"H", CAU=>"H",
     UGC=>"C", UGU=>"C",
     CCA=>"P", CCC=>"P", CCG=>"P", CCU=>"P",
     UGG=>"W",
     AGA=>"R", AGG=>"R",
     CGA=>"R", CGC=>"R", CGG=>"R", CGU=>"R",
     UUA=>"L", UUG=>"L", CUA=>"L", CUC=>"L", CUG=>"L", CUU=>"L",
     UUC=>"F", UUU=>"F"
);

my $humanLength = length($humanHBB);

$humanLength-=$humanLength%3; 


my $monkeyLength = length($monkeyHBB);

$monkeyLength-=$monkeyLength%3; 


for (my $i=0, my $j=0 ; $i<$humanLength && $j<$humanLength/3; $i+=3, $j++){
    $arrayX[$j]= $amino{substr($humanHBB,$i,3)};

}

for (my $i=0, my $j=0 ; $i<$monkeyLength && $j<$monkeyLength/3; $i+=3, $j++){
    $arrayY[$j]= $amino{substr($monkeyHBB,$i,3)};
}
print " ";
print @arrayX;
print "\n";

for (my $i=0 ; $i<scalar @arrayY; $i++){
    print $arrayY[$i];
    print " "x$i;
    if ($arrayX[$i] eq $arrayY[$i]){
        print "X";
    }
    else {
        print " ";
    }
    print "\n";
} 
print "percent identity: $percentage%";


