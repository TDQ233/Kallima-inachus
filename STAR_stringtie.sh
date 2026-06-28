for i in Sample1 Sample2 Sample3
do

STAR --runThreadN 20 --genomeDir /data/reference/Kin_P_index --readFilesIn --readFilesIn /data/RNA-seq/fq/${i}_1.fq.gz /data/RNA-seq/fq/${i}_2.fq.gz --outFileNamePrefix /data/RNA-seq/STAR_P/${i}_stringtie/STAR_stringtie_${i}_ --outSAMtype BAM SortedByCoordinate --outBAMsortingThreadN 11 --quantMode TranscriptomeSAM GeneCounts --outSAMstrandField intronMotif

stringtie /data/RNA-seq/STAR_P/${i}_stringtie/STAR_stringtie_${i}_Aligned.sortedByCoord.out.bam -o STAR_stringtie_${i}.gtf

done