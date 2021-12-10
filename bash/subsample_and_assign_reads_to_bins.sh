binLen=500 #binLen=500 because we want divide the genome into 500bp bins
BAMFILE=/rugpfs/fs0/risc_lab/scratch/jyeung/HeLA/ENCODE_ENCSR000AQ0/hg38_bam_files/ENCFF409PGL.bam
SUBSAMPLEBAM=/rugpfs/fs0/risc_lab/scratch/jyeung/HeLA/ENCODE_ENCSR000AQ0/hg38_bam_files/ENCFF409PGL_subsampled.bam
SUBSAMPLEBEDFILE=/rugpfs/fs0/risc_lab/scratch/jyeung/HeLA/ENCODE_ENCSR000AQ0/bed_files/hg38_bed/ENCFF409PGL_subsampled.bed
SUBSAMPLE_BINLEN=/rugpfs/fs0/risc_lab/scratch/jyeung/HeLA/ENCODE_ENCSR000AQ0/bed_files/hg38_bed/ENCFF409PGL_subsampled_binLen.bed

# retrieve number of mapped reads in each chromosome and sum up the number of reads to get total reads. determine number of reads to get the percentage to subsample by 
frac=$(samtools idxstats $BAMFILE |cut -f3 |awk 'BEGIN {total=0} {total += $1} END {frac= 9000000/total; if (frac >1) {print 1} else {print frac}}')

#downsample original bam file
samtools view -bs $frac $BAMFILE > $SUBSAMPLEBAM

#convert bam file to bed file 
bedtools bamtobed -i $SUBSAMPLEBAM > $SUBSAMPLEBEDFILE

# find midpoint of fragment and assign it to genomic bin 
awk -v w=$binLen '{print $1,int (($2+$3)/(2*w))*w + w/2}' $SUBSAMPLEBEDFILE |sort -k1,1V -k2,2n | uniq -c |awk -v OFS="\t" '{print $2, $3, $1}' | sort -k1,1V -k2,2n >$SUBSAMPLE_BINLEN


