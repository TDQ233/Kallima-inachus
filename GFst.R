YI<-read.csv('C:/Users/dell/Desktop/csv/FST/M_YI_50k.csv',header=T,na.strings='nan')

YI$MEAN_FST = ifelse(YI$MEAN_FST < 0, 0.2*YI$MEAN_FST, YI$MEAN_FST)

library(ggplot2)
p1<-ggplot(data=YI, aes(x=MID,y=MEAN_FST))+
  geom_point(size = 8,colour = "#FFD92F")+ theme(panel.grid.major =element_blank(), panel.grid.minor = element_blank(),
                                          panel.background = element_blank(),axis.line = element_line(colour = "black"),
                                          axis.title.x = element_blank(),axis.line.x = element_blank(),axis.text.x = element_blank(),
                                          axis.title.y = element_blank())+ylim(-0.02,1)

p1+annotate("rect", xmin = 0, xmax = 19170001, ymin = -0.02, ymax = 1, fill="gray70", colour="transparent", alpha=0.1)+
  annotate("rect", xmin = 19170001, xmax = 40890001, ymin = -0.02, ymax = 1, fill="gray90", colour="transparent", alpha=0.1)+
  annotate("rect", xmin = 40890001, xmax = 48740001, ymin = -0.02, ymax = 1, fill="gray70", colour="transparent", alpha=0.1)+
  annotate("rect", xmin = 48740001, xmax = 59770001, ymin = -0.02, ymax = 1, fill="gray90", colour="transparent", alpha=0.1)+
  annotate("rect", xmin = 59770001, xmax = 75470001, ymin = -0.02, ymax = 1, fill="gray70", colour="transparent", alpha=0.1)+
  annotate("rect", xmin = 75470001, xmax = 92250001, ymin = -0.02, ymax = 1, fill="gray90", colour="transparent", alpha=0.1)+
  annotate("rect", xmin = 92250001, xmax = 111100001, ymin = -0.02, ymax = 1, fill="gray70", colour="transparent", alpha=0.1)+
  annotate("rect", xmin = 111100001, xmax = 129560001, ymin = -0.02, ymax = 1, fill="gray90", colour="transparent", alpha=0.1)+
  annotate("rect", xmin = 129560001, xmax = 141630001, ymin = -0.02, ymax = 1, fill="gray70", colour="transparent", alpha=0.1)+
  annotate("rect", xmin = 141630001, xmax = 155770001, ymin = -0.02, ymax = 1, fill="gray90", colour="transparent", alpha=0.1)+
  annotate("rect", xmin = 155770001, xmax = 175260001, ymin = -0.02, ymax = 1, fill="gray70", colour="transparent", alpha=0.1)+
  annotate("rect", xmin = 175260001, xmax = 193140001, ymin = -0.02, ymax = 1, fill="gray90", colour="transparent", alpha=0.1)+
  annotate("rect", xmin = 193140001, xmax = 214940001, ymin = -0.02, ymax = 1, fill="gray70", colour="transparent", alpha=0.1)+
  annotate("rect", xmin = 214940001, xmax = 233450001, ymin = -0.02, ymax = 1, fill="gray90", colour="transparent", alpha=0.1)+
  annotate("rect", xmin = 233450001, xmax = 256060001, ymin = -0.02, ymax = 1, fill="gray70", colour="transparent", alpha=0.1)+
  annotate("rect", xmin = 256060001, xmax = 274380001, ymin = -0.02, ymax = 1, fill="gray90", colour="transparent", alpha=0.1)+
  annotate("rect", xmin = 274380001, xmax = 297460001, ymin = -0.02, ymax = 1, fill="gray70", colour="transparent", alpha=0.1)+
  annotate("rect", xmin = 297460001, xmax = 306830001, ymin = -0.02, ymax = 1, fill="gray90", colour="transparent", alpha=0.1)+
  annotate("rect", xmin = 306830001, xmax = 316630001, ymin = -0.02, ymax = 1, fill="gray70", colour="transparent", alpha=0.1)+
  annotate("rect", xmin = 316630001, xmax = 332600001, ymin = -0.02, ymax = 1, fill="gray90", colour="transparent", alpha=0.1)+
  annotate("rect", xmin = 332600001, xmax = 348560001, ymin = -0.02, ymax = 1, fill="gray70", colour="transparent", alpha=0.1)+
  annotate("rect", xmin = 348560001, xmax = 373190001, ymin = -0.02, ymax = 1, fill="gray90", colour="transparent", alpha=0.1)+
  annotate("rect", xmin = 373190001, xmax = 397300001, ymin = -0.02, ymax = 1, fill="gray70", colour="transparent", alpha=0.1)+
  annotate("rect", xmin = 397300001, xmax = 417410001, ymin = -0.02, ymax = 1, fill="gray90", colour="transparent", alpha=0.1)+
  annotate("rect", xmin = 417410001, xmax = 438140001, ymin = -0.02, ymax = 1, fill="gray70", colour="transparent", alpha=0.1)+
  annotate("rect", xmin = 438140001, xmax = 458190001, ymin = -0.02, ymax = 1, fill="gray90", colour="transparent", alpha=0.1)+
  annotate("rect", xmin = 458190001, xmax = 480040001, ymin = -0.02, ymax = 1, fill="gray70", colour="transparent", alpha=0.1)+
  annotate("rect", xmin = 480040001, xmax = 499680001, ymin = -0.02, ymax = 1, fill="gray90", colour="transparent", alpha=0.1)+
  annotate("rect", xmin = 499680001, xmax = 511450001, ymin = -0.02, ymax = 1, fill="gray70", colour="transparent", alpha=0.1)+
  annotate("rect", xmin = 511450001, xmax = 525800001, ymin = -0.02, ymax = 1, fill="gray90", colour="transparent", alpha=0.1)+
  annotate("rect", xmin = 525800001, xmax = 546560001, ymin = -0.02, ymax = 1, fill="gray70", colour="transparent", alpha=0.1)



