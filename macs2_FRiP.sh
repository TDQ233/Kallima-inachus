for i in Sample1 Sample2 Sample3
do

mkdir /data/ATAC-seq/ATAC_P_peaks/${i}

bedtools bamtobed -i /data/ATAC-seq/ATAC_P/${i}.rmChrM.bam > /data/ATAC-seq/ATAC_P_peaks/${i}/${i}.rmChrM.bed

macs2 callpeak \
-t /data/ATAC-seq/ATAC_P_peaks/${i}/${i}.rmChrM.bed \
-g 569394429 \
--nomodel --shift -100 --extsize 200 \
--call-summits \
--keep-dup all \
-n ${i}.rmChrM \
-q 0.01 \
--outdir /data/ATAC-seq/ATAC_P_peaks/${i}

# FRiP
Reads=$(bedtools intersect -a "/data/ATAC-seq/ATAC_P_peaks/${i}/${i}.rmChrM.bed" \
         -b "/data/ATAC-seq/ATAC_P_peaks/${i}/${i}.rmChrM_peaks.narrowPeak" \
         -u | wc -l | awk '{print $1}')

totalReads=$(wc -l "/data/ATAC-seq/ATAC_P_peaks/${i}/${i}.rmChrM.bed" | awk '{print $1}')


# TotalRawReads and AlignmentRate
log="/data/ATAC-seq/ATAC_P/bowtie2_${i}.log"

TotalRawReads=$(grep "reads; of these:" "$log" | awk '{print $1}')
AlignmentRate=$(grep "overall alignment rate" "$log" | awk '{print $1}')


# output
echo -e "${i}\tReadNumber:${TotalRawReads}\tAlignmentRate:${AlignmentRate}\tFRiP:$(echo "scale=2;100*${Reads}/${totalReads}" | bc)%" \
  > "/data/ATAC-seq/ATAC_P_peaks/${i}/${i}.FRiP"

done

