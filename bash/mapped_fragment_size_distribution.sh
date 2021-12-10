BAMFILE= /rugpfs/fs0/risc_lab/scratch/jyeung/HeLA/ENCODE_ENCSR000AQ0/hg38_bam_files/ENCFF183EDU.bam
FRAGMENTLENFILE= /rugpfs/fs0/risc_lab/scratch/jyeung/HeLA/ENCODE_ENCSR000AQ0/hg38_bam_files/ENCFF183EDU_fragmentLen.txt

samtools view -F 0x04 $BAMFILE |awk -F'\t' 'function abs(x){return ((x < 0.0) ? -x : x)} {print abs($9)}' | sort | uniq -c | awk -v OFS="\t" '{print $2, $1/2}' >$FRAGMENTLENFILE