#!/bin/bash                         
#SBATCH -J RSEM                   
#SBATCH -o RSEM.out               
#SBATCH -N 1                            
#SBATCH --cpus-per-task=20

for i in NL7-2F NL7-2H NL7-2O NL7-3H NL7-3O;
do

align_and_estimate_abundance.pl --thread_count 20 --transcripts 10indvs_Trinity.fasta --seqType fq --left 15_output_paired_${i}_R1.fq.gz --right 15_output_paired_${i}_R2.fq.gz --est_method RSEM --aln_method bowtie2 --trinity_mode --prep_reference --output_dir rsem2all_${i};


done

