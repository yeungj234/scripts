#code source: github.com/FredHutch/SEACR
#variables
SAMPLEBAM=/rugpfs/fs0/risc_lab/scratch/jyeung/HeLA/CUTnTag_output_hg38_aligned/IgG/CUTnTagPipeline/SRR12387746/SRR12387746_001.trim.st.all.blft.qft.rmdup.bam
SAMPLEBED=/rugpfs/fs0/risc_lab/scratch/jyeung/HeLA/CUTnTag_output_hg38_aligned/IgG/CUTnTagPipeline/SRR12387746/bed_files/SRR12387746.bed
SAMPLECLEANBED=/rugpfs/fs0/risc_lab/scratch/jyeung/HeLA/CUTnTag_output_hg38_aligned/IgG/CUTnTagPipeline/SRR12387746/bed_files/SRR12387746.clean.bed
SAMPLEFRAGMENTSBED=/rugpfs/fs0/risc_lab/scratch/jyeung/HeLA/CUTnTag_output_hg38_aligned/IgG/CUTnTagPipeline/SRR12387746/bed_files/SRR12387746.fragments.bed
SAMPLEFRAGMENTSBEDGRAPH=/rugpfs/fs0/risc_lab/scratch/jyeung/HeLA/CUTnTag_output_hg38_aligned/IgG/CUTnTagPipeline/SRR12387746/bed_files/SRR12387746.fragments.bedgraph

bedtools bamtobed -bedpe -i $SAMPLEBAM > $SAMPLEBED
awk '$1==$4 && $6-$2 < 1000 {print $0}' $SAMPLEBED >$SAMPLECLEANBED
cut -f 1,2,6 $SAMPLECLEANBED | sort -k1,1 -k2,2n -k3,3n > $SAMPLEFRAGMENTSBED
bedtools genomecov -bg -i $SAMPLEFRAGMENTSBED -g /rugpfs/fs0/risc_lab/store/risc_data/downloaded/hg38/genome/chrom.sizes > $SAMPLEFRAGMENTSBEDGRAPH
