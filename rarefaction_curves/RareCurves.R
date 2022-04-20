setwd("E:/Researches/Xiaqian/NGS/CleanData/ALL/细菌V6V8-1/Analysis_20210624/rarefaction_curves")


library(picante)
library(ggplot2)
#rm(list = ls())
#file <- file.path

genes_abundance <- read.delim("feature-table.tsv",
                              row.names = 1, sep = '\t', 
                              stringsAsFactors = FALSE, 
                              check.names = FALSE)
# 去掉"#"注释开头,和物种注释结果
#genes_abundance <- genes_abundance[-c(1:4), ]
#genes_abundance <- genes_abundance[-ncol(genes_abundance)]

# 行列转换
otu <- t(genes_abundance)

# step 表示抽样步长
rare_otu <- rarecurve(otu, step = 500, label = FALSE)

names(rare_otu) <- rownames(otu)

plot_data <- mapply(FUN = function(x, y) {
  mydf <- as.data.frame(x)
  colnames(mydf) <- "value"
  mydf$sample_name <- y
  mydf$subsample <- attr(x, "Subsample")
  mydf
}, x = rare_otu, y = as.list(rownames(otu)), SIMPLIFY = FALSE)

xy <- do.call(rbind, plot_data)
rownames(xy) <- NULL  # pretty
head(xy)

ggplot(xy, aes(x = subsample, y = value, color = sample_name)) +
     theme_bw() +
     scale_color_discrete() + # turn legend on or off (guide = FALSE)
     geom_line() + geom_point(size=0.1)