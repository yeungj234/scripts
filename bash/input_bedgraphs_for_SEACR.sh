# Description: convert paired-end BAM to a fragment bedgraph file to be used as an input file to call peaks on SEACR. This is for CUT&Tag/CUT&RUN samples.

# source of script: github.com/FredHutch/SEACR 

# specify variables: 
$sample.bam=
$sample.bed=
$sample.clean.bed=
$sample.fragments.bed
$sample.fragments.bedgraph

# script: 

bedtools bamtobed -bedpe -i $sample.bam > $sample.bed
awk '$1==$4 && $6-$2 < 1000 {print $0}' $sample.bed > $sample.clean.bed
cut -f 1,2,6 $sample.clean.bed | sort -k1,1 -k2,2n -k3,3n > $sample.fragments.bed
bedtools genomecov -bg -i $sample.fragments.bed -g my.genome > $sample.fragments.bedgraph
