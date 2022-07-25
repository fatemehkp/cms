setwd('/scratch/fatemehkp/Utah/Data_Center')

library("dplyr")
library("klaR")

#DeadRC <- read.csv("enrollee65_dead_rc.csv")
#save(DeadRC, file= "DeadRC.RDa")
load("DeadRC.RDa")

DeadRC %>% 
  group_by(BENE_SEX_IDENT_CD) %>% 
  summarize(n=n()) 

DeadRC %>% 
  group_by(BENE_RACE_CD) %>% 
  summarize(n=n())

dim(DeadRC)
names(DeadRC)
str(DeadRC)
head(DeadRC)

DeadRC.e <- DeadRC
DeadRC.e$year <- DeadRC.e$BENE_ID <- DeadRC.e$MONTH <- NULL
DeadRC.e$acc <- DeadRC.e$uri <- DeadRC.e$ards <- NULL
DeadRC.e$ZIP_CODE <- DeadRC.e$ENROLLEE_AGE <- NULL

DeadRC.Female <- DeadRC.e %>%
  filter(BENE_SEX_IDENT_CD=="1")
DeadRC.Female$BENE_SEX_IDENT_CD <- DeadRC.Female$BENE_RACE_CD <- NULL

DeadRC.Male <- DeadRC.e %>%
  filter(BENE_SEX_IDENT_CD=="2")
DeadRC.Male$BENE_SEX_IDENT_CD <- DeadRC.Male$BENE_RACE_CD <- NULL

DeadRC.White <- DeadRC.e %>%
  filter(BENE_RACE_CD=="1")
DeadRC.White$BENE_SEX_IDENT_CD <- DeadRC.White$BENE_RACE_CD <- NULL

DeadRC.Black <- DeadRC.e %>%
  filter(BENE_RACE_CD=="2")
DeadRC.Black$BENE_SEX_IDENT_CD <- DeadRC.Black$BENE_RACE_CD <- NULL

DeadRC.Asian <- DeadRC.e %>%
  filter(BENE_RACE_CD=="4")
DeadRC.Asian$BENE_SEX_IDENT_CD <- DeadRC.Asian$BENE_RACE_CD <- NULL

DeadRC.Hispanic <- DeadRC.e %>%
  filter(BENE_RACE_CD=="5")
DeadRC.Hispanic$BENE_SEX_IDENT_CD <- DeadRC.Hispanic$BENE_RACE_CD <- NULL



cls <- vector("list", 1)
cls[[1]] <- kmodes(DeadRC.e, 2)
cluster2 <- as.data.frame(simplify2array(lapply(cls, `[`, "cluster")))
colnames(cluster2) <- c("cluster2")

cls <- vector("list", 1)
cls[[1]] <- kmodes(DeadRC.e, 3)
cluster3 <- as.data.frame(simplify2array(lapply(cls, `[`, "cluster")))
colnames(cluster3) <- c("cluster3")

cls <- vector("list", 1)
cls[[1]] <- kmodes(DeadRC.e, 4)
cluster4 <- as.data.frame(simplify2array(lapply(cls, `[`, "cluster")))
colnames(cluster4) <- c("cluster4")

cls <- vector("list", 1)
cls[[1]] <- kmodes(DeadRC.e, 5)
cluster5 <- as.data.frame(simplify2array(lapply(cls, `[`, "cluster")))
colnames(cluster5) <- c("cluster5")

cls <- vector("list", 1)
cls[[1]] <- kmodes(DeadRC.e, 6)
cluster6 <- as.data.frame(simplify2array(lapply(cls, `[`, "cluster")))
colnames(cluster6) <- c("cluster6")

cls <- vector("list", 1)
cls[[1]] <- kmodes(DeadRC.e, 7)
cluster7 <- as.data.frame(simplify2array(lapply(cls, `[`, "cluster")))
colnames(cluster7) <- c("cluster7")

cls <- vector("list", 1)
cls[[1]] <- kmodes(DeadRC.e, 8)
cluster8 <- as.data.frame(simplify2array(lapply(cls, `[`, "cluster")))
colnames(cluster8) <- c("cluster8")

cls <- vector("list", 1)
cls[[1]] <- kmodes(DeadRC.e, 9)
cluster9 <- as.data.frame(simplify2array(lapply(cls, `[`, "cluster")))
colnames(cluster9) <- c("cluster9")

cls <- vector("list", 1)
cls[[1]] <- kmodes(DeadRC.e, 10)
cluster10 <- as.data.frame(simplify2array(lapply(cls, `[`, "cluster")))
colnames(cluster10) <- c("cluster10")


DeadRC.Clusters <- bind_cols(DeadRC,cluster2,cluster3,cluster4,cluster5,cluster6,cluster7,cluster8,cluster9,cluster10)

save(DeadRC.Clusters, file= "DeadRC.Clusters.RDa")
write.csv(DeadRC.Clusters , "DeadRC.Clusters.csv")
#end

DeadRC.Clusters.dt <- DeadRC.Clusters
DeadRC.Clusters.dt$year <- DeadRC.Clusters.dt$BENE_ID <- DeadRC.Clusters.dt$MONTH <- NULL
DeadRC.Clusters.dt$acc <- DeadRC.Clusters.dt$uri <- DeadRC.Clusters.dt$ards <- NULL

save(DeadRC.Clusters.dt, file= "DeadRC.Clusters.dt.RDa")




cls <- vector("list", 1)
cls[[1]] <- kmodes(DeadRC.Female, 4)
cluster4 <- as.data.frame(simplify2array(lapply(cls, `[`, "cluster")))
colnames(cluster4) <- c("cluster4")
Female.Clus4 <- bind_cols(DeadRC.Female,cluster4)

Table4.Female <- Female.Clus4 %>%
  gather(observation, Val, ihd:kidn) %>% 
  group_by(cluster4,observation, Val) %>% 
  summarise(n= n()) %>%
  ungroup() %>%
  spread(Val, n, fill=0)
write.csv(Table4.Female,"Table4.Female.csv")


cls <- vector("list", 1)
cls[[1]] <- kmodes(DeadRC.Female, 6)
cluster6 <- as.data.frame(simplify2array(lapply(cls, `[`, "cluster")))
colnames(cluster6) <- c("cluster6")
Female.Clus6 <- bind_cols(DeadRC.Female,cluster6)

Table6.Female <- Female.Clus6 %>%
  gather(observation, Val, ihd:kidn) %>% 
  group_by(cluster6,observation, Val) %>% 
  summarise(n= n()) %>%
  ungroup() %>%
  spread(Val, n, fill=0)
write.csv(Table6.Female,"Table6.Female.csv")




cls <- vector("list", 5) # 5 different clustering - size 4 to 8
for (i in 1:5){
  j <- i+3 # 4 to 8 Clusters 
  cls[[i]] <- kmodes(DeadRC, j)
}

clusters <- as.data.frame(simplify2array(lapply(cls, `[`, "cluster")))
colnames(clusters) <- c("cluster4", "cluster5", "cluster6", "cluster7", "cluster8")
DeadRC.Clusters.4to8 <- bind_cols(DeadRC,clusters)
save(DeadRC.Clusters.4to8, file= "DeadRC.Clusters.4to8.RDa")
#end




