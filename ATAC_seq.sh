for i in Sample1 Sample2 Sample3
do

bowtie2 --very-sensitive -p 20 -X 2000 \
  -x /data/reference/ATAC-seq/Kin_P_index/Kin_P \
  -1 /data/ATAC-seq/fq/${i}_1.fq.gz \
  -2 /data/ATAC-seq/fq/${i}_2.fq.gz \
  2> bowtie2_${i}.log | samtools sort -@ 16 -O bam -o ${i}.sorted.bam

samtools index -@ 16 ${i}.sorted.bam
samtools flagstat ${i}.sorted.bam > ${i}.sorted.stat

picard MarkDuplicates\
  QUIET=true INPUT=${i}.sorted.bam OUTPUT=${i}.marked.bam METRICS_FILE=${i}.sorted.metrics \
  REMOVE_DUPLICATES=false CREATE_INDEX=true VALIDATION_STRINGENCY=LENIENT TMP_DIR=/tmp

samtools view -h -b -F 1028 -q 30 ${i}.marked.bam > ${i}.rmDup.bam

samtools index ${i}.rmDup.bam
samtools flagstat ${i}.rmDup.bam > ${i}.rmDup.stat

samtools view -@ 16 -h ${i}.rmDup.bam | grep -v HiC_scaffold_432 | samtools sort -@ 16 -O bam -o ${i}.rmChrM.bam
samtools index ${i}.rmChrM.bam
samtools flagstat ${i}.rmChrM.bam > ${i}.rmChrM.stat

rm -rf ${i}_unpaired_1.fq.gz
rm -rf ${i}_unpaired_2.fq.gz
rm -rf ${i}.marked.bam
rm -rf ${i}.marked.bai
rm -rf ${i}.sorted.bam
rm -rf ${i}.sorted.bam.bai
rm -rf ${i}.rmDup.bam
rm -rf ${i}.rmDup.bam.bai

done