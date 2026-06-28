hicConvertFormat -m Kin_P_chr26_5k.matrix -bf Kin_P_chr26_5k.bed --inputFormat hicpro --outputFormat h5 -o Kin_P_chr26_5k -r 5000

hicCorrectMatrix correct --matrix Kin_P_chr26_5k.h5 --correctionMethod KR -o Kin_P_chr26_5k_KR.h5

hicFindTADs --matrix Kin_P_chr26_5k_KR.h5 --outPrefix Kin_P_chr26_5k_KR --correctForMultipleTesting fdr

hicPlotTADs --tracks test.ini -o test.pdf --region chr26:3800000-4600000 --dpi 600

