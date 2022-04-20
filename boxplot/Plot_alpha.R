#!/usr/bin/env R
# 基于github安装包，需要devtools，检测是否存在，不存在则安装
if (!requireNamespace("devtools", quietly = TRUE))
    install.packages("devtools")

# 加载github包安装工具
library(devtools)

# 检测amplicon包是否安装，没有从源码安装
if (!requireNamespace("amplicon", quietly = TRUE))
    install_github("microbiota/amplicon")

# 提示升级，选择3 None不升级；升级会容易出现报错
# library加载包，suppress不显示消息和警告信息
suppressWarnings(suppressMessages(library(amplicon)))

#setwd("E:/Researches/Xiaqian/NGS/CleanData/ALL/细菌V6V8-1/Analysis_20210624/boxplot")
# 读取元数据，参数指定包括标题行(TRUE)，列名为1列，制表符分隔，无注释行，不转换为因子类型
metadata = read.table("sample-metadata.tsv", header=T, row.names=1, sep="\t", comment.char="", stringsAsFactors = F)

# 预览元数据前3行，注意分组列名
#head(metadata, n = 3)

# 读取vegan计算6种alpha多样性指数，计算方法见"分析流程 - 扩增子"部分
alpha_div = read.table("alpha.csv", header=T, row.names=1, sep=",", comment.char="")

# 预览多样性指数前3行，注释各指数列名
#head(alpha_div, n = 3)

# 绘制各组香农指数分布，外层()可对保存的图形同时预览
(p1 = alpha_boxplot(alpha_div, index = "Shannon", metadata, groupID = "Depth2"))

##物种丰富度 Richness 指数
(p2 = alpha_boxplot(alpha_div, index = "Richness", metadata, groupID = "Depth2"))

#Gini-Simpson 指数（我们平时常用的 Simpson 指数即为 Gini-Simpson 指数）
(p3 = alpha_boxplot(alpha_div, index = "Simpson", metadata, groupID = "Depth2"))

#Chao1 指数
(p4 = alpha_boxplot(alpha_div, index = "Chao1", metadata, groupID = "Depth2"))

#ACE 指数
(p5 = alpha_boxplot(alpha_div, index = "ACE", metadata, groupID = "Depth2"))

#Shannon 均匀度（Pielou 均匀度）
(p6 = alpha_boxplot(alpha_div, index = "Pielou", metadata, groupID = "Depth2"))

##谱系多样性
(p7 = alpha_boxplot(alpha_div, index = "PD_whole_tree", metadata, groupID = "Depth2"))


# 保存图片，指定图片为pdf格式方便后期修改，图片宽89毫米，高75毫米
ggsave(paste0("alpha_boxplot_shannon.pdf"), p1, width=89, height=75, units="mm")
ggsave(paste0("alpha_boxplot_Richness.pdf"), p2, width=89, height=75, units="mm")
ggsave(paste0("alpha_boxplot_Simpson.pdf"), p3, width=89, height=75, units="mm")
ggsave(paste0("alpha_boxplot_Chao1.pdf"), p4, width=89, height=75, units="mm")
ggsave(paste0("alpha_boxplot_ACE.pdf"), p5, width=89, height=75, units="mm")
ggsave(paste0("alpha_boxplot_Pielou.pdf"), p6, width=89, height=75, units="mm")
ggsave(paste0("alpha_boxplot_PD_whole_tree.pdf"), p7, width=89, height=75, units="mm")
