python generate_site_positions.py MboI Kin_P /data/reference/Kin_P.fasta

bwa index /data/reference/Kin_P.fasta

awk 'BEGIN{OFS="\t"}{print $1, $NF}'  Kin_P_MboI.txt > Kin_P_MboI.chrom.sizes

./juicer.sh \-z /data/reference/Kin_P.fasta \-p /data/Hi-C/restriction_sites/Kin_P_MboI.chrom.sizes \-y /data/Hi-C/restriction_sites/Kin_P_MboI.txt \-d /data/Hi-C/juicer-main/work/Kin_P \-D /data/Hi-C/juicer-main \-t 20 --qc --in-situ >> Kin_P.log 2>&1