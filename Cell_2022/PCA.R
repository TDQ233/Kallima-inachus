library(cpm)
library(DESeq2)
library(ggrepel)

data = read.table("C:/Users/dell/Desktop/manuscript/RNA-seq/PCA/output.matrix", header=T, row.names=1, com='')
conditions = read.csv("C:/Users/dell/Desktop/manuscript/RNA-seq/PCA/conditions.csv", header=T, row.names=1)

rnaseqMatrix = data
rnaseqMatrix = round(rnaseqMatrix)
rnaseqMatrix = rnaseqMatrix[rowSums(cpm(rnaseqMatrix) > 1) >= 2,]

#rownames(conditions) = colnames(rnaseqMatrix)
ddsFullCountTable <- DESeqDataSetFromMatrix(
  countData = rnaseqMatrix,
  colData = conditions,
  design = ~ conditions)
dds = DESeq(ddsFullCountTable)

vsd <- vst(object=dds,blind=T) 

library(ggplot2)

pcadata <- plotPCA(vsd,intgroup = c("conditions"), returnData=TRUE)

table(pcadata$condition)
percentVar <- round(100*attr(pcadata,"percentVar"),1)

pcadata$group <- gsub("L7", "", pcadata$group, fixed = TRUE)
pcadata$group <- gsub("PP", "", pcadata$group, fixed = TRUE)
pcadata$group <- gsub("P1", "", pcadata$group, fixed = TRUE)
pcadata$group <- gsub("P3", "", pcadata$group, fixed = TRUE)

pcadata$conditions <- gsub("forewing", "", pcadata$conditions, fixed = TRUE)
pcadata$conditions <- gsub("hindwing", "", pcadata$conditions, fixed = TRUE)
pcadata$conditions <- gsub("abdomen", "", pcadata$conditions, fixed = TRUE)

pcadata$conditions <- gsub("L7", "larva day7", pcadata$conditions, fixed = TRUE)
pcadata$conditions <- gsub("P1", "pupa day1", pcadata$conditions, fixed = TRUE)
pcadata$conditions <- gsub("P3", "pupa day3", pcadata$conditions, fixed = TRUE)
pcadata$conditions <- gsub("PP", "pre-pupa", pcadata$conditions, fixed = TRUE)

colnames(vsd)<- gsub(".genes.results", "", colnames(vsd), fixed = TRUE)

ggplot(pcadata, aes(PC1, PC2, color=conditions, shape=group)) + 
  geom_point(size=3) +
  xlab(paste0("PC1: ",percentVar[1],"% variance")) +
  ylab(paste0("PC2: ",percentVar[2],"% variance")) +
  geom_text_repel(aes(PC1, PC2,color=conditions,label=colnames(vsd)),size=3) +
  theme(panel.background = element_blank(),
        axis.line = element_line(colour = "black"))
