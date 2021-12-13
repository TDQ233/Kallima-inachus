#!/bin/bash                         
#SBATCH -J trim                   
#SBATCH -o trim.out               
#SBATCH -N 1                            
#SBATCH --cpus-per-task=20

for i in P3-I4-F P3-I4-H P3-Y6-F P3-Y6-H PP-Y4-F PP-Y4-H PP-Y7-F PP-Y7-H;
do

trimmomatic PE -threads 20 -phred33 ${i}-R1.clean.fq.gz ${i}-R2.clean.fq.gz 15_output_paired_${i}_R1.fq.gz 15_output_unpaired_${i}_R1.fq.gz 15_output_paired_${i}_R2.fq.gz 15_output_unpaired_${i}_R2.fq.gz LEADING:3 TRAILING:3 SLIDINGWINDOW:90:10 MINLEN:36 HEADCROP:15 >> trim.log 2>&1;

done

