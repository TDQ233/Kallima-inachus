source activate hicexplorer
conda activate domaincaller

srun hicConvertFormat --matrices inter_30.hic --outFileName out2 --inputFormat hic --outputFormat cool --chromosome Sequence --nproc 20

srun hic2cool convert 40k.hic out2 -p 20

srun cooler balance -p 10 out2.cool

srun cooler cload pairs Kin_Y.chrom.sizes:10000 merged_nodups.txt out -c1 HiC_scaffold_1 -c2 HiC_scaffold_1

srun pairtools parse --nproc-in 20 --nproc-out 20 -c Kin_Y.chrom.sizes -o parsed2.pairsam.gz --drop-sam output.bam

srun pairtools sort --nproc 20 -o sorted.pairsam.gz parsed.pairsam.gz