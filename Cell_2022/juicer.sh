srun python generate_site_positions.py MboI Kin_Y Kin_Y.fasta

bwa index Kin_Y.fasta

awk 'BEGIN{OFS="\t"}{print $1, $NF}'  Kin_Y_MboI.txt > Kin_Y.chrom.sizes


sbatch juicer.sh \-z /gpfs/user/luwei/juicedir/references/Kin_Nov.fasta \-p /gpfs/user/luwei/juicedir/restriction_sites/Kin_Nov.chrom.sizes \-y /gpfs/user/luwei/juicedir/restriction_sites/Kin_Nov_DpnII.txt \-d /gpfs/user/luwei/juicedir/work/Hi-Kim/ \-D /gpfs/user/luwei/software/juicer \-t 20


./juicer.sh \-z /home/luwei/tengdequn/HiC/juicedir/references/Kin_Y.fasta \-p /home/HiC/juicedir/restriction_sites/Kin_Y.chrom.sizes \-y /home/HiC/juicedir/restriction_sites/Kin_Y_MboI.txt \-d /home/HiC/juicedir/work/H6/ \-D /home/HiC/juicedir \-t 20  >> juicer_Y_H6.log 2>&1

java -jar juicer_tools.1.6.2_windows_jcuda.0.8.jar  hiccups --ignore_sparsity interI_30.hic C:\Users\TENG\Desktop\1

java -jar /home/HiC/juicedir/scripts/common/juicer_tools.1.7.6_jcuda.0.8.jar arrowhead -k KR -c HIC_SCAFFOLD_26 --ignore_sparsity /home/HiC/Kin_Nov_results/aligned/interI_30.hic /home/HiC/Kin_Nov_results/aligned/inter_30_contact_domains 

java -jar /home/HiC/juicedir/scripts/common/juicer_tools.1.7.6_jcuda.0.8.jar arrowhead -k NONE -c SEQUENCE -r 25000 --ignore_sparsity /home/HiC/juicedir/work/H6/aligned/inter_30.hic /home/HiC/juicedir/work/H6/aligned/inter_30_contact_domains 

java -jar /home/HiC/juicedir/scripts/common/juicer_tools.1.7.6_jcuda.0.8.jar arrowhead  -k VC -c SEQUENCE -r 5000 --ignore_sparsity /home/HiC/juicedir/work/H6/aligned/inter_30.hic /home/HiC/juicedir/work/H6/aligned/inter_30_contact_domains 



java -jar /home/HiC/juicedir/scripts/common/juicer_tools.1.7.6_jcuda.0.8.jar dump observed KR /home/HiC/Kin_Nov_results/aligned/interI_30.hic HIC_SCAFFOLD_26 HIC_SCAFFOLD_26 BP 10000 combined_10Kb.txt



java -jar /home/HiC/juicedir/scripts/common/juicer_tools.1.7.6_jcuda.0.8.jar pre -r 40000 -c SEQUENCE merged_nodups.txt 40k.hic Kin_Y.chrom.sizes




