srun abundance_estimates_to_matrix.pl  --est_method RSEM --quant_files sample.txt --out_prefix Trinity_trans --gene_trans_map none

analyze_diff_expr.pl --matrix Trinity_trans.isoform.counts.matrix.cond_FH_vs_cond_O.edgeR.count_matrix -P 1e-3 -C 2

sed '1,1d' Trinity_trans.isoform.counts.matrix.cond_FH_vs_cond_O.edgeR.DE_results | awk '{ if ($5 <= 0.05) print;}' | wc -l