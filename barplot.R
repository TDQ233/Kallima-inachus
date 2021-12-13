library(ggsignif)
library(ggplot2)
library(plyr)
test <- read.csv('C:/Users/dell/Desktop/manuscript/RNA-seq/othergenes/engrailed.csv',header = T)


geom_signif(mapping = NULL, data = NULL, stat = "signif",
            position = "identity", na.rm = FALSE, show.legend = NA,
            inherit.aes = TRUE, comparisons = NULL, test = "wilcox.test",
            test.args = NULL, annotations = NULL, map_signif_level = FALSE,
            y_position = NULL, xmin = NULL, xmax = NULL, margin_top = 0.05,
            step_increase = 0, tip_length = 0.03, size = 0.5, textsize = 3.88,
            family = "", vjust = 0)

compaired <- list(c("prepupa","5th instar"),c("5th instar","pupa d1"),c("5th instar", "pupa d3"))


data_summary <- function(data, varname, groupnames){
  require(plyr)
  summary_func <- function(x, col){
    c(mean = mean(x[[col]], na.rm=TRUE),
      sd = sd(x[[col]], na.rm=TRUE),
      n = length(x[[col]]))
  }
  data_sum<-ddply(data, groupnames, .fun=summary_func,
                  varname)
  data_sum <- rename(data_sum, c("mean" = varname))
  return(data_sum)
}


df2 <- data_summary(test, varname="exp", 
                    groupnames=c("group"))
# Convert dose to a factor variable
df2$group=as.factor(df2$group)
head(df2)

ggplot(df2,aes(group,exp,fill=group)) +
  geom_bar(stat="identity", color="black", width=.4, position=position_dodge()) +
  geom_errorbar(aes(ymin=exp-sd/sqrt(n), ymax=exp+sd/sqrt(n)), width=.2, position=position_dodge(.9)) +
  scale_y_continuous(expand = c(0,0)) +
  theme(plot.title=element_text(size = 25),
        legend.position="none",
        panel.background = element_blank(),
        axis.line = element_line(colour = "black"),
        axis.text.x=element_text(size=15,angle=0),
        axis.text.y=element_text(size=15),
        axis.title.x=element_text(size = 23),
        axis.title.y=element_text(size = 23))+
  labs(x='Stage', y= 'Expression')+
  geom_signif(comparisons = compaired,step_increase = 0.1,map_signif_level = F)

