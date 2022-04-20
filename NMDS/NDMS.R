#setwd("E:/Researches/Xiaqian/NGS/CleanData/ALL/细菌V6V8-1/Analysis_20210624/NMDS")
library("vegan")

# 读取数据，一份otu.table文件和一份分组信息文件
otu <- read.table("feature-table.tsv",row.names=1, header=T,sep="\t",check.names=F)
design <- read.table("sample-metadata.tsv",header=T,sep="\t",row.names=1,check.names=F)

#数据调整为列名是OTU，行名是样本名
otu=t(otu)

#标准化，当然method有很多，可以通过?decostand查看其它method
vare.hel<-decostand(otu,method="hellinger")

#计算Bray-curtis距离矩阵
vare.dis <- vegdist(vare.hel,method="bray")

#使用NMDS的方法
vare.mds <- metaMDS(vare.hel,distance = "bray")

#首先提取前两轴坐标
point = scores(vare.mds)

#将分组文件和得分文件合并
index = merge(design, point,by="row.names",all=F)

#查看Stress值
#Stress值是反映模型合适程度的指标，NMDS会多次打乱数据计算Stress值，直到找到最合适的模型，也就是最低的Stress值；理想状况下，Stress值为0，一般Stress值低于0.1较为合理。
vare.mds
# Stress:     0.08814714 

#显着性检验；anosim本质是基于排名的算法更加适合NMDS
anosim.result<-anosim(vare.dis, design$Depth,permutations =999)
summary(anosim.result)

# ANOSIM statistic R: 0.2373 
#       Significance: 0.001
#tiff输出图形，适合大部分出版刊物，入门级别分辩率300,18*14的长宽；
#tiff(file="beta_bray_NMDS.tiff", res = 300, compression ="none", width=180,height=140,units= "mm")
pdf(file="beta_bray_NMDS.pdf", width=180,height=140)
#开始出图，将上面得到的三个指标在图中更换stress，R，p，不多说，代码如下：
library("ggplot2")

p = ggplot(index, aes(x=NMDS1, y=NMDS2, color=as.factor(Depth))) +
      geom_point(size=0) +
     scale_colour_manual(values = c("red","blue", "green", "#9900FF", "#336633", "#996600")) +
     labs(x=paste("NMDS1"), y=paste("NMDS2"), title="")

#置信区间当然要加上，有三种方式，线条类型也可以更改

p+stat_ellipse(type = "t", linetype = 2, level = 0.95, show.legend = TRUE)+
    annotate("text",x=-2.5,y=-1.25,parse=TRUE,size=4,label="'R: '*0.2373",family="serif",fontface="italic",colour="darkred",hjust = 0)+
    annotate("text",x=-2.5,y=-1.35,parse=TRUE,size=4,label="'p: '*0.001",family="serif",fontface="italic",colour="darkred",hjust = 0)+
    annotate("text",x=-2.5,y=-1.45,parse=TRUE,size=4,label="'Stress: '*0.088",family="serif",fontface="italic",colour="darkred",hjust = 0) + geom_point(aes(x=NMDS1, y=NMDS2, shape=Site), size=2)+
	scale_shape_manual(values = c(15, 19, 17, 18, 7, 8, 13))+
    theme_classic()

dev.off()