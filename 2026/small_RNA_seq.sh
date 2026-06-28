miRDeep2.pl /data/small-RNA-seq/Kin_merged_reads.fa /data/reference/Kin_P.fasta /data/small-RNA-seq/Kin_merged_reads.arf none /data/small-RNA-seq/miRBase/mature_Hme_Bmo_Dme.fasta none 2>report.log



for i in Sample1 Sample2 Sample3
do

trim_galore -q 25 --phred33 /data/small-RNA-seq/fq/${i}.fq.gz --gzip -o /data/small-RNA-seq/clean

cat /data/small-RNA-seq/clean/${i}.clean.fa | ./seqkit replace -p "\ " -r '' >> /data/small-RNA-seq/${i}.clean_nospace.fa

mapper.pl /data/small-RNA-seq/${i}.clean_nospace.fa -c -l 17 -m -q -p /data/reference/Kin_P_index -s /data/small-RNA-seq/${i}_reads.fa

quantifier.pl -p /data/small-RNA-seq/miRBase/Kin_precursors.fa -W -m /data/small-RNA-seq/miRBase/Kin_mature.fa -r /data/small-RNA-seq/${i}_reads.fa -j -y ${i}

done
