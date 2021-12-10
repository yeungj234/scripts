# Description: using Deeptools package, calculate scores per genome region (e.g. genes) using ComputeMatrix function. This generate a matrix in which the plotHeatmap function uses as input to generate a heatmap over genomic regions. 
# specify variables
# BIGWIGFILE:file that contains reads or peaks to be plotted 
# BEDFILE: bed file that contains genomic regions to visualize/plot scores over
# OUTPUTMATRIX: name of matrix
# HEATMAP: name of heatmap. file extension is .png
 
BIGWIGFILE=
BEDFILE=
OUTPUTMATRIX=
HEATMAP=

# script
cores=8
computeMatrix scale-regions -S $BIGWIGFILE
 -R $BEDFILE \
--beforeRegionStartLength 3000 --regionBodyLength 5000 --afterRegionStartLength 3000 --skipZeros -o $OUTPUTMATRIX -p $cores

plotHeatmap -m $OUTPUTMATRIX -out $HEATMAP --sortUsing sum