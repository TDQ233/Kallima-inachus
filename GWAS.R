library(qqman)
library(ggplot2)
library(dplyr)
data(package='qqman')
SNP1<-read.csv('C:/Users/dell/Desktop/3_5M_Y_H.csv')

p <- ggplot(SNP1, aes(x=BP, y=-log10(P))) +
  #设置点的大小，透明度
  geom_point( aes(color="#E78AC3"), alpha=0.8, size=8) +
  #设置颜色
  scale_color_manual(values = rep(c("#E78AC3"), 31 )) +
  #设定X轴
  scale_x_continuous(expand = c(0, 0),limits=c(3000000,4500000) ) +
  #去除绘图区和X轴之间的gap
  scale_y_continuous(expand = c(0, 0),limits=c(0,12)  ) +
  
  geom_vline(xintercept = 3910000,col = "gray", lwd = 3, lty = 2, alpha=0.8)+

  
  #设置主题
  theme_bw() +
  theme(
    legend.position="none",
    panel.border = element_blank(),
    axis.line.y = element_line(),
    panel.grid.major.x = element_blank(),
    panel.grid.minor.x = element_blank(),
    panel.grid.major.y = element_blank(),
    panel.grid.minor.y = element_blank(),
    axis.title.x = element_blank(),axis.line.x = element_blank(),
    axis.text.x = element_blank(),axis.ticks.x = element_blank(),

  )

p