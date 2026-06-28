for i in Sample1 Sample2 Sample3
do

STAR --runThreadN 16 --genomeDir /data/reference/Kin_P_index --readFilesCommand zcat --readFilesIn /data/RNA-seq/fq/${i}_1.fq.gz /data/RNA-seq/fq/${i}_2.fq.gz --outFileNamePrefix /data/RNA-seq/STAR_P/${i}/STAR_${i}_ --outSAMtype BAM SortedByCoordinate --outBAMsortingThreadN 11 --quantMode TranscriptomeSAM GeneCounts

samtools index -b /data/RNA-seq/STAR_P/${i}/STAR_${i}_Aligned.sortedByCoord.out.bam

/data/software/subread-2.0.6-Linux-x86_64/bin/featureCounts -a /data/reference/annotation/Kin_P.gtf -t exon -p --countReadPairs -T 50 -o ${i}_matrix.txt /data/RNA-seq/STAR_P/${i}/STAR_${i}_Aligned.sortedByCoord.out.bam

cut -f 1,7 ${i}_matrix.txt |grep -v '^#' > ${i}_P_featureCounts.txt
rm -rf ${i}_matrix.txt
rm -rf ${i}_matrix.txt.summary

done
