FastGA Kin_S_N.fasta LD8_V.fasta -s100 -i0.56 -1:Inter_Kin_S_N_LD8_V.1aln
FastGA Kin_V_N.fasta LD9_P.fasta -s100 -i0.56 -1:Inter_Kin_V_N_LD9_P.1aln

ALNchain Inter_Kin_S_N_LD8_V -s5000 -n2
ALNchain Inter_Kin_V_N_LD9_P -s5000 -n2

ALNtoPAF Inter_Kin_S_N_LD8_V.chain > Inter_Kin_S_N_LD8_V_Chain.paf
ALNtoPAF Inter_Kin_V_N_LD9_P.chain > Inter_Kin_V_N_LD9_P_Chain.paf

/data/software/NGenomeSyn/bin/GetTwoGenomeSyn.pl Paf2Link Inter_Kin_S_N_LD8_V_Chain.paf 100 Inter_Kin_S_N_LD8_V_Chain.link
/data/software/NGenomeSyn/bin/GetTwoGenomeSyn.pl Paf2Link Inter_Kin_V_N_LD9_P_Chain.paf 100 Inter_Kin_V_N_LD9_P_Chain.link

/data/software/NGenomeSyn/bin/NGenomeSyn -InConf inter_1.conf -OutPut inter_1
/data/software/NGenomeSyn/bin/NGenomeSyn -InConf inter_2.conf -OutPut inter_2