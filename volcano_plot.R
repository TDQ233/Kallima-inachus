library(ggpubr)
library(ggthemes)

deg.data <- read.table('C:/Users/dell/Desktop/manuscript/RNA-seq/volcano/DE_results/P3_H_I.DE_results',header = T, sep = "\t")
head(deg.data)

deg.data$logP <- -log10(deg.data$padj)

deg.data$Group = "3not-significant"

deg.data$Group[which( (deg.data$padj < 0.05) & (deg.data$log2FoldChange > 2) )] = "2vp-up-regulated"
deg.data$Group[which( (deg.data$padj < 0.05) & (deg.data$log2FoldChange < -2) )] = "1pp-up-regulated"

table(deg.data$Group)


deg.data$Label = ""
deg.data <- deg.data[order(deg.data$padj),]

up.genes <- head(deg.data$Symbol[which(deg.data$Group == "2vp-up-regulated")],5)
down.genes <- head(deg.data$Symbol[which(deg.data$Group == "1pp-up-regulated")],5)

deg.top10.genes <- c(as.character(up.genes),as.character(down.genes))
deg.data$Label[match(deg.top10.genes,deg.data$Symbol)] <-  deg.top10.genes

#palette = c("#2f5688","#CC0000","#BBBBBB")


ggscatter(deg.data,x = "log2FoldChange", y = "logP",
          color = "Group",
          palette = c("#CC0000","#BBBBBB","#BBBBBB"),
          size =1,
          label = deg.data$Label,
          font.label = 9,
          repel =T,
          xlab = "log2FoldChange",
          ylab = "-log10(Adjust P-value)") + theme_base() +
  geom_hline(yintercept = 1.30, linetype = "dashed") +
  geom_vline(xintercept = c(-2,2), linetype = "dashed") 
  
