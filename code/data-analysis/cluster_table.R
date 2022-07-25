
library(ggplot2)
library(dplyr)
library(tidyr)
library(knitr)

Table2 <- DeadRC.Clusters.dt %>%
  gather(observation, Val, ihd:kidn) %>% 
  group_by(cluster2,observation, Val) %>% 
  summarise(n= n()) %>%
  ungroup() %>%
  spread(Val, n, fill=0)
write.csv(Table2,"Table2.csv")

Table3 <- DeadRC.Clusters.dt %>%
  gather(observation, Val, ihd:kidn) %>% 
  group_by(cluster3,observation, Val) %>% 
  summarise(n= n()) %>%
  ungroup() %>%
  spread(Val, n, fill=0)
write.csv(Table3,"Table3.csv")

Table4 <- DeadRC.Clusters.dt %>%
  gather(observation, Val, ihd:kidn) %>% 
  group_by(cluster4,observation, Val) %>% 
  summarise(n= n()) %>%
  ungroup() %>%
  spread(Val, n, fill=0)
write.csv(Table4,"Table4.csv")


Table5 <- DeadRC.Clusters.dt %>%
  gather(observation, Val, ihd:kidn) %>% 
  group_by(cluster5,observation, Val) %>% 
  summarise(n= n()) %>%
  ungroup() %>%
  spread(Val, n, fill=0)
write.csv(Table5,"Table5.csv")

Table6 <- DeadRC.Clusters.dt %>%
  gather(observation, Val, ihd:kidn) %>% 
  group_by(cluster6,observation, Val) %>% 
  summarise(n= n()) %>%
  ungroup() %>%
  spread(Val, n, fill=0)
write.csv(Table6,"Table6.csv")

Table7 <- DeadRC.Clusters.dt %>%
  gather(observation, Val, ihd:kidn) %>% 
  group_by(cluster7,observation, Val) %>% 
  summarise(n= n()) %>%
  ungroup() %>%
  spread(Val, n, fill=0)
write.csv(Table7,"Table7.csv")


Table8 <- DeadRC.Clusters.dt %>%
  gather(observation, Val, ihd:kidn) %>% 
  group_by(cluster8,observation, Val) %>% 
  summarise(n= n()) %>%
  ungroup() %>%
  spread(Val, n, fill=0)
write.csv(Table8,"Table8.csv")


Table2t <- DeadRC.Clusters.dt %>% 
  group_by(cluster2) %>% 
  summarize(n=n()) 
write.csv(Table2t,"Table2t.csv")

Table2 <- DeadRC.Clusters.dt %>% 
  group_by(cluster2) %>%
 levels() 
write.csv(Table2,"Table2.csv")


Table3t <- DeadRC.Clusters.dt %>% 
  group_by(cluster3) %>% 
  summarize(n=n()) 
write.csv(Table3t,"Table3t.csv")

Table3 <- DeadRC.Clusters.dt %>% 
  group_by(cluster3) %>%
  summarise_all(sum) 
write.csv(Table3,"Table3.csv")



Table4t <- DeadRC.clusters %>% 
  group_by(cluster4) %>% 
  summarize(n=n()) 
write.csv(Table4t,"Table4t.csv")

Table4 <- DeadRC.clusters %>% 
  group_by(cluster4) %>%
  summarise_all(sum) 
write.csv(Table4,"Table4.csv")



Table5t <- DeadRC.clusters %>% 
  group_by(cluster5) %>% 
  summarize(n=n()) 
write.csv(Table5t,"Table5t.csv")

Table5 <- DeadRC.clusters %>% 
 group_by(cluster5) %>%
  summarise_all(sum) 
write.csv(Table5,"Table5.csv")




Table6t <- DeadRC.clusters %>% 
  group_by(cluster6) %>% 
  summarize(n=n()) 
write.csv(Table6t,"Table6t.csv")

Table6 <- DeadRC.clusters %>% 
  group_by(cluster6) %>%
  summarise_all(sum) 
write.csv(Table6,"Table6.csv")






Table7t <- DeadRC7.clusters %>% 
  group_by(cluster7) %>% 
  summarize(n=n()) 
write.csv(Table7t,"Table7t.csv")

Table7 <- DeadRC7.clusters %>% 
  group_by(cluster7) %>%
  summarise_all(sum) 
write.csv(Table7,"Table7.csv")






Table8t <- DeadRC8.clusters %>% 
  group_by(cluster8) %>% 
  summarize(n=n()) 
write.csv(Table8t,"Table8t.csv")

Table8 <- DeadRC8.clusters %>% 
  group_by(cluster8) %>%
  summarise_all(sum) 
write.csv(Table8,"Table8.csv")




Table9t <- DeadRC9.clusters %>% 
  group_by(cluster9) %>% 
  summarize(n=n()) 
write.csv(Table9t,"Table9t.csv")

Table9 <- DeadRC9.clusters %>% 
  group_by(cluster9) %>%
  summarise_all(sum) 
write.csv(Table9,"Table9.csv")



names(data1)


data2 <- data1 %>%
  mutate(Demn=VaD+AD+NeD+UsD, Diabt=diabt1+diabt2)
data2$Demn <- ifelse(data2$Demn>=1,1,0)
data2$Diabt <- ifelse(data2$Diabt>=1,1,0)

summary(data2$Demn)
summary(data2$Diabt)

data2$VaD <- data2$AD <- data2$NeD <- data2$UsD <- NULL
data2$diabt1 <- data2$diabt2 <- NULL
data2$uri <- data2$ards <- NULL
summary(data2)

DeadRC.R <- data2
save(DeadRC.R, file= "DeadRC.R.RDa")

names(DeadRC.R)
DeadRC.R$acc <- NULL
save(DeadRC.R, file= "DeadRC.R2.RDa")
