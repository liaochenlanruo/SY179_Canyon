#!/use/bin/env R
# Author: Hualin Liu

if (!requireNamespace("devtools", quietly=TRUE))
    install.packages("devtools")
library(devtools)
if (!requireNamespace("amplicon", quietly=TRUE))
    install_github("liaochenlanruo/amplicon")
suppressWarnings(suppressMessages(library(amplicon)))


# 从文件读取元数据，特征表和物种注释
metadata=read.table("sample-metadata.tsv", header=T, row.names=1, sep="\t", comment.char="", stringsAsFactors=F)
taxonomy=read.table("taxonomy.tsv", header=T, row.names=1, sep="\t", comment.char="", stringsAsFactors=F)


#堆叠柱状图。以分组均值绘制，颜色采用ggplot2默认配色，展示丰度最高的x个门，其余归类为其他(Other)

# 门水平物种组成表和元数据作为输入，分组列名为Group，默认显示前x个分类，按丰度排序
otutab2=read.table("level-2.csv", header=T, row.names=1, sep=",", comment.char="", stringsAsFactors=F)
otutab2=t(otutab2)

#按照站位分组
ps=tax_stackplot(otutab2, metadata, groupID="Site", topN=20, style="sample", sorted="abundance")
ps2 = ps + scale_fill_manual(values = rev(c("#1f77b4", "#aec7e8", "#ff7f0e", "#ffbb78", "#2ca02c", "#98df8a", "#d62728", "#ff9896", "#9467bd", "#c5b0d5", "#8c564b", "#c49c94", "#e377c2", "#f7b6d2", "#7f7f7f", "#c7c7c7", "#bcbd22", "#dbdb8d", "#17becf", "#9edae5"))) + theme(axis.text.x = element_text(color="black", size=4, angle = 90, hjust = 0.5, vjust = 0.5)) + theme(axis.text.y = element_text(color="black", size=4)) + theme(legend.text=element_text(color="black", size=4)) + theme(legend.key.size = unit(7, "pt"))

#按照深度分组
pd=tax_stackplot(otutab2, metadata, groupID="Depth", topN=20, style="sample", sorted="abundance")
pd2 = pd + scale_fill_manual(values = rev(c("#1f77b4", "#aec7e8", "#ff7f0e", "#ffbb78", "#2ca02c", "#98df8a", "#d62728", "#ff9896", "#9467bd", "#c5b0d5", "#8c564b", "#c49c94", "#e377c2", "#f7b6d2", "#7f7f7f", "#c7c7c7", "#bcbd22", "#dbdb8d", "#17becf", "#9edae5"))) + theme(axis.text.x = element_text(color="black", size=4, angle = 90, hjust = 0.5, vjust = 0.5)) + theme(axis.text.y = element_text(color="black", size=4)) + theme(legend.text=element_text(color="black", size=4)) + theme(legend.key.size = unit(7, "pt"))

zoom=1.2 # 控制图片缩放比例
# 输出图片

#ggsave(paste0("L2.Site.jpg"), ps2, width=170*zoom, height=56*zoom, units="mm")
ggsave(paste0("L2.Site.pdf"), ps2, width=170*zoom, height=56*zoom, units="mm")

#ggsave(paste0("L2.Depth.jpg"), pd2, width=170*zoom, height=56*zoom, units="mm")
ggsave(paste0("L2.Depth.pdf"), pd2, width=170*zoom, height=56*zoom, units="mm")
