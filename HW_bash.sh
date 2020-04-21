#!/bin/bash
file=`cat sample1.vcf`
chrom=$(grep "^chr" sample1.vcf | awk '{print $1}' | uniq)
touch result.csv
#echo CHROM$'\t' {A,T,G,C}\>{A,T,G,C}
echo CHROM$'\t'A\>G$'\t'A\>C$'\t'A\>T$'\t'G\>A$'\t'G\>C$'\t'G\>T$'\t'C\>A$'\t'C\>G$'\t'C\>T$'\t'T\>A$'\t'T\>G$'\t'T\>C$'\t'SUMM > result.csv

#echo CHROM\\tA>C\\tA>G\\tA>T\\tC>A\\tC>G\\tC>T\\tG>A\\tG>T\\tG>C\\tT>A\\tT>C\\tT>G\\t > result.csv
#echo $chrom
for c in $chrom
do
  str=${c}$'\t'
  line="A    G    C    T"
  for let in $line
  do
    for lett in $line
    do
       if [ "$let" != "$lett" ];
       then
          result=`grep -E "$c" sample1.vcf | grep -c -E "\t$let\t$lett\t"`
          str="${str}${result}"$'\t'
       fi
    done
#  grep $c sample1.vcf
  done
   summ=`grep -E "$c" sample1.vcf | grep -c -E "\t[ATGC]\t[ATGC]\t"`
   str="${str}${summ}"
#  strok="${c}$'\t'${str}"
  echo $str >> result.csv
done
sort -nk14 -o result.csv result.csv
