library(ggplot2)
library(reshape)
setwd("E:/Researches/Xiaqian/NGS/CleanData/ALL/细菌V6V8-1/Analysis_20210624/microeco/taxa_abund")
data <- read.table("Kingdom_abund.txt", header = TRUE, sep = "\t")
data <- t(data)
colnames(data) <- data[1,] # 将第一行作为列名
data <- data[-1,] # 删除第一行
rownames(data) <- data[,4]
data <- data[,-4]
data_melt <- melt(data)
windowsFonts(Arial=windowsFont("Arial")) #加载Windows字体
names(data_melt) = c("Layers", "Domain", "Abundances")
data_melt[,1] = as.character(data_melt[,1])
data_melt[,3] = as.numeric(data_melt[,3])

p<- ggplot(data_melt,aes(x = Layers,y = Abundances))+
     geom_boxplot(aes(fill = Domain)) +
     theme_classic()+ 
     theme(text=element_text(family="Arial",size=12,face = "plain"), #设置文字的字体字号
           axis.text.x = element_text(size=10)) + # 设置X轴文字大小
           scale_fill_manual(values=c("#1f77b4","#2ca02c","#17becf"))  # 设置填充颜色

p +
#  geom_jitter(aes(fill=Domain),width =0.2,shape = 21,size=1)+       ##添加散点分布
  theme(panel.background = element_blank(),axis.line = element_line())+   ##去默认灰色背景颜色
#  stat_compare_means(comparisons=data_melt,label="p.signif")+              ##显著性分析
#  stat_boxplot(geom = "errorbar",width=0.5)+                              ##添加误差线
  theme(legend.position = "bottom")
