BAMFILE=/rugpfs/fs0/risc_lab/scratch/jyeung/HeLA/ENCODE_ENCSR000AQ0/ENCFF638EFN.bam
SUBSAMPLEBAM=/rugpfs/fs0/risc_lab/scratch/jyeung/HeLA/ENCODE_ENCSR000AQ0/ENCFF638EFN_subsampled.bam

# retrieve number of mapped reads in each chromosome and sum up the number of reads to get total reads. determine number of reads to get the percentage to subsample by 
frac=$(samtools idxstats $BAMFILE |cut -f3 |awk 'BEGIN {total=0} {total += $1} END {frac=8033744/total; if (frac >1) {print 1} else {print frac}}')

#downsample original bam file
samtools view -bs $frac $BAMFILE > $SUBSAMPLEBAM
