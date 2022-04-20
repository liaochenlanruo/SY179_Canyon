#!/usr/bin/env R
#定义函数
library(picante)       #picante 包加载时默认同时加载 vegan
 
alpha <- function(x, tree = NULL, base = exp(1)) {
        est <- estimateR(x)
        Richness <- est[1, ]
        Chao1 <- est[2, ]
        ACE <- est[4, ]
        Shannon <- diversity(x, index = 'shannon', base = base)
        Simpson <- diversity(x, index = 'simpson')    #Gini-Simpson 指数
        Pielou <- Shannon / log(Richness, base)
        goods_coverage <- 1 - rowSums(x == 1) / rowSums(x)
        
        result <- data.frame(Richness, Shannon, Simpson, Pielou, Chao1, ACE, goods_coverage)
        if (!is.null(tree)) {
                PD_whole_tree <- pd(x, tree, include.root = FALSE)[1]
                names(PD_whole_tree) <- 'PD_whole_tree'
                result <- cbind(result, PD_whole_tree)
        }
        result
}
 
#现在直接使用定义好的命令 alpha()，一步得到多种 Alpha 多样性指数
#加载 OTU 丰度表和进化树文件
otu <- read.delim('feature-table.tsv', row.names = 1, sep = '\t', stringsAsFactors = FALSE, check.names = FALSE)
otu <- t(otu)
tree <- read.tree('tree.nwk')
 
#不包含谱系多样性，无需指定进化树；Shannon 公式的 log 底数我们使用 2
##alpha_all <- alpha(otu, base = 2)
#包含谱系多样性时，指定进化树文件；Shannon 公式的 log 底数我们使用 2
alpha_all <- alpha(otu, tree, base = 2)
 
#输出保存在本地
write.csv(alpha_all, 'alpha.csv', quote = FALSE)
