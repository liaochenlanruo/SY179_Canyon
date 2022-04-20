setwd("E:/Researches/Xiaqian/NGS/CleanData/宏基因组数据/Result/MCycDB/MCycDB-main")

data <- read.table("MCyc.PathWay.txt",header = TRUE, sep = "\t", quote = "")

library(ggplot2)
library(reshape)
data_melt <- melt(data)
names(data_melt) = c("Genes", "Annotation", "Pathways", "Samples", "Abundances")
data_melt <-as.data.frame(data_melt)
bubble <- ggplot(data_melt[which(data_melt$Abundances>0),], aes(x = Samples, y = Genes, size = Abundances, color = Samples)) + theme_bw()+ labs(x = "Sediment layers", y = "Methane cycling genes")+ theme(axis.text.x = element_text(angle = 0, colour = "black", vjust = 1, hjust = 1, size = 10), axis.text.y = element_text(size = 10)) +
    theme(panel.grid = element_blank(), panel.border = element_blank()) +
    theme(panel.spacing = unit(.1, "lines")) + 
    theme(plot.margin=unit(c(1, 0, 0, 1), "cm"))+ geom_point()+ facet_grid(Pathways ~ ., drop=TRUE, scale="free",space="free", switch = "y") +
    theme(strip.background = element_rect(fill = "grey95", colour = "white"), strip.text.y.left = element_text(angle=360), strip.text=element_text(size=10))
