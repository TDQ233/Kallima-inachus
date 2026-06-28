for i in Sample1 Sample2 Sample3
do

/data/software/subread-2.0.6-Linux-x86_64/bin/featureCounts -a /data/reference/annotation/Kin_P.gtf -t exon -p --countReadPairs -T 50 -o ${i}_matrix.txt /data/RNA-seq/STAR_P/${i}/STAR_${i}_Aligned.sortedByCoord.out.bam

cut -f 1,6,7 ${i}_matrix.txt | grep -v '^#' > ${i}_featureCounts.txt

total_rpk=$(awk 'NR>1 {if ($2>0) {rpk=$3/($2/1000); total += rpk}} END {print total}' ${i}_featureCounts.txt)

awk -v total_rpk="$total_rpk" -v sample="$i" '
  BEGIN {OFS="\t"}
  NR==1 {print $1, sample}
  NR>1 {
    if ($2 > 0) {
      tpm = ($3/($2/1000)) / total_rpk * 1e6;
      printf "%s\t%.2f\n", $1, tpm
    } else {
      print $1, "0"
    }
  }' ${i}_featureCounts.txt > ${i}_tpm.txt

rm -rf ${i}_matrix.txt ${i}_matrix.txt.summary ${i}_featureCounts.txt

done








