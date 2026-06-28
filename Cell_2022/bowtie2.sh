for i in H6 H8 H12 H13 H21 H29 H45
do

/usr/share/bowtie2-2.3.4.3-linux-x86_64/bowtie2 --very-sensitive-local -p 16 -x /home/bam2I/Kin_Nov_I -1 15_output_paired_${i}_R1.fq.gz -2 15_output_paired_${i}_R2.fq.gz -S ${i}_best.sam >> ${i}_sam.log 2>&1

samtools view -bST /home/bam2I/Kin_Nov_I.fasta -o ${i}_noRG.bam ${i}_best.sam

java -Xmx20g -XX:PermSize=15g -XX:MaxPermSize=15g -Djava.io.tmpdir=bla -jar /usr/share/picard-tools-1.96/AddOrReplaceReadGroups.jar INPUT=${i}_noRG.bam OUTPUT=${i}_std.bam SORT_ORDER=coordinate RGID=${i} RGLB=Nym RGPL=illumina RGSM=${i} RGPU=none VALIDATION_STRINGENCY=LENIENT >> addorreplacereadgoups_${i}.log 2>&1
java -Xmx20g -XX:PermSize=15g -XX:MaxPermSize=15g -Djava.io.tmpdir=bla -jar /usr/share/picard-tools-1.96/BuildBamIndex.jar INPUT=${i}_std.bam VALIDATION_STRINGENCY=LENIENT >> addorreplacereadgoups_buildindex_${i}.log 2>&1

java -Xmx20g -XX:PermSize=15g -XX:MaxPermSize=15g -Djava.io.tmpdir=bla -jar /usr/share/picard-tools-1.96/MarkDuplicates.jar INPUT=${i}_std.bam OUTPUT=${i}_std_noduplicates.bam METRICS_FILE=${i}_std.duplicate_matrics REMOVE_DUPLICATES=true ASSUME_SORTED=true VALIDATION_STRINGENCY=LENIENT >> markduplicates_${i}.log 2>&1
java -Xmx20g -XX:PermSize=15g -XX:MaxPermSize=15g -Djava.io.tmpdir=bla -jar /usr/share/picard-tools-1.96/BuildBamIndex.jar INPUT=${i}_std_noduplicates.bam VALIDATION_STRINGENCY=LENIENT >> markduplicates_buildindex_${i}.log 2>&1

java -Xmx20g -XX:PermSize=10g -XX:MaxPermSize=10g -Djava.io.tmpdir=bla -jar /usr/share/GenomeAnalysisTK-3.7/GenomeAnalysisTK.jar -T RealignerTargetCreator -nt 8 -I ${i}_std_noduplicates.bam -R /home/bam2I/Kin_Nov_I.fasta -o ${i}_forIndelAligner.intervals >> realignertargetcreator_index_${i}.log 2>&1
java -Xmx20g -XX:PermSize=10g -XX:MaxPermSize=10g -Djava.io.tmpdir=bla -jar /usr/share/GenomeAnalysisTK-3.7/GenomeAnalysisTK.jar -T IndelRealigner -I ${i}_std_noduplicates.bam -R /home/bam2I/Kin_Nov_I.fasta -targetIntervals ${i}_forIndelAligner.intervals -o ${i}_std_noduplicates.realign.bam -maxReads 100000 >> indelrealigner_index_${i}.log 2>&1

rm -rf ${i}_best.sam
rm -rf ${i}_noRG.bam
rm -rf ${i}_std.bam
rm -rf ${i}_std_noduplicates.bam
rm -rf ${i}_std.duplicate_matrics
rm -rf ${i}_noduplicates.bai
rm -rf ${i}_forIndelAligner.intervals
rm -rf ${i}_std.bai
rm -rf ${i}_std_noduplicates.bai


done


