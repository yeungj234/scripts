#specify variables. 
binLen=500 #binLen=500 because we want divide the genome into 500bp bins
BAMFILE=/rugpfs/fs0/risc_lab/scratch/jyeung/HeLA/CUTnTag_output_hg38_aligned/HeLA_001.trim.st.all.blft.qft.rmdup.bam
BEDFILE=/rugpfs/fs0/risc_lab/scratch/jyeung/HeLA/CUTnTag_output_hg38_aligned/HeLA_bamtobed.bed
BINLENFILE=/rugpfs/fs0/risc_lab/scratch/jyeung/HeLA/CUTnTag_output_hg38_aligned/HeLA_bamtobed_binLen.bed

#convert bam file to bed file 
bedtools bamtobed -i $BAMFILE >$BEDFILE 

#ake the midpoint of each fragment and specify it to the genomic bin that it belongs to

#int((start+end)/2w) just finds the average of the fragment (so midpoint) and then puts it as a multiple of "w" so that whatever rounded integer value returns is essentially just the index of the genome bin where the peak is
#But an "index" doesn't carry any meaning in genomic coordinates so they multiply again by "w" to get back to actual coordinate values. This is just a clean way to ensure you segment all your peaks into "w" spaced bins throughout your genome
#The "+ w/2" is to make sure that you don't start your index at 0 ( I think). In this way, the first genomic coordinate (with "w" spaced binning) begins at w/2 and goes to 3w/2, instead of 0 to w. This is probably just for plotting purposes so that the peaks aren't mid-centered instead of left-centered. This is a technique people do a lot when they're making histograms
awk -v w=$binLen '{print $1,int (($2+$3)/(2*w))*w + w/2}' $BEDFILE |sort -k1,1V -k2,2n | uniq -c |awk -v OFS="\t" '{print $2, $3, $1}' | sort -k1,1V -k2,2n >$BINLENFILE


