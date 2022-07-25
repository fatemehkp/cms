
# Set working directory
#setwd("C:\\Users\\fkazem01\\Box\\Utah\\Data Library\\cluster")
setwd('/scratch/fatemehkp/Utah/Data_Center')

library("dplyr")
library("klaR")

DeadRC <- read.csv("eheadnrollee65_dead_rc.csv")
save(DeadRC, file= "DeadRC.RDa")
load("DeadRC.RDa")

death_icd_or_rc <- as.data.frame(colSums(DeadRC))
write.csv(death_icd_or_rc , "death_icd_or_rc.csv")

data2 <- read.csv("testrc.csv")
save(data2, file= "testRC.RDa")
load("testRC.RDa")

cls <- vector("list", 2)
for (i in 1:2){
  j <- i+3
## run algorithm on DeadRC:
cls[[i]] <- kmodes(data2, j)
  #cls[[i]][2]<-i # Assign regions
}

cls.t <- do.call(rbind, cls)
lapply(cls, function(x) x[[1]])
x <- as.data.frame(simplify2array(lapply(cls, `[`, "cluster")))

colnames(x) <- c("cluster4","cluster5")
data3 <- bind_cols(data2,x)


cl2['modes']
cl2['size']
g <- as.data.frame(cl2['cluster'])
data3 <- bind_cols(data2,g)


data4 <- data3 %>% group_by(cluster) %>%
  summarise_each(funs(sum)) 




## Sample Code

# NOT RUN {
### a 5-dimensional toy-example:

## generate data set with two groups of data:
set.seed(1)
x <- rbind(matrix(rbinom(250, 2, 0.25), ncol = 5),
           matrix(rbinom(250, 2, 0.75), ncol = 5))
colnames(x) <- c("a", "b", "c", "d", "e")
library("klaR")
## run algorithm on x:
(cl <- kmodes(x, 2))

## and visualize with some jitter:
plot(jitter(x), col = cl$cluster)
points(cl$modes, col = 1:5, pch = 8)
# }

ff <- cl2[1]
data3 <- do.call(rbind,ff)
data2 <- data.matrix(DeadRC, rownames.force = NA)
str(x)
str(data2)

dev.off()

## and visualize with some jitter:
plot(jitter(data2), col = cl2$cluster, main="cluster=4")
points(cl2$modes, col = 1:5, pch = 8)
# }


