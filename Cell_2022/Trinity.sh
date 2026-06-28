source  ~/.bashrc
conda activate Trinity
conda deactivate
srun Trinity --seqType fq --left 15_output_paired_NP1_2_F_R1.fq.gz 15_output_paired_NP1_3_F_R1.fq.gz 15_output_paired_NP1_4_F_R1.fq.gz 15_output_paired_NPP_1_F_R1.fq.gz 15_output_paired_NPP_2_F_R1.fq.gz 15_output_paired_NP1_2_H_R1.fq.gz 15_output_paired_NP1_3_H_R1.fq.gz 15_output_paired_NP1_4_H_R1.fq.gz 15_output_paired_NPP_1_H_R1.fq.gz 15_output_paired_NPP_2_H_R1.fq.gz --right 15_output_paired_NP1_2_F_R2.fq.gz 15_output_paired_NP1_3_F_R2.fq.gz 15_output_paired_NP1_4_F_R2.fq.gz 15_output_paired_NPP_1_F_R2.fq.gz 15_output_paired_NPP_2_F_R2.fq.gz 15_output_paired_NP1_2_H_R2.fq.gz 15_output_paired_NP1_3_H_R2.fq.gz 15_output_paired_NP1_4_H_R2.fq.gz 15_output_paired_NPP_1_H_R2.fq.gz 15_output_paired_NPP_2_H_R2.fq.gz --CPU 12 --max_memory 20G --no_version_check









