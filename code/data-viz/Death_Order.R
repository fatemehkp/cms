

setwd('C:/Users/fkazem01/Box/Utah/Output')
dir()

library(tidyverse)
library(readxl)
library(reshape2)
data<-read_excel("death_order.xlsx")


dataw <- reshape2::melt(data)
colnames(dataw)

dataw$index = factor(dataw$...1, levels=c("First","Second","Third",
                                           "Fourth", "Fifth"))
jpeg("Death_Order.jpeg", width = 6.5, height = 9, units = 'in', res = 300)
ggplot(data=dataw) +
  geom_point(mapping = aes(x=1,y=value),color="red")+
  facet_grid(variable~index,switch='y',)+
  xlab("")+
  ylab("")+
  theme(axis.ticks.y = element_blank(),
        axis.ticks.x = element_blank(),
        axis.text.y =element_blank(),
        axis.text.x  =element_blank(),
        strip.text.x = element_text(size=12, face='bold', color="black"),
        strip.text.y = element_text(size=12,face="bold", color="black", angle=180),
        strip.background = element_rect(fill="slategray2"))
dev.off()


cuz <- c("Diab", "Diabt1", "Diabt2") 
dataw0<-dataw[dataw$variable %in% cuz,]

jpeg("Diab_Order.jpeg", width = 6.5, height = 4.5, units = 'in', res = 300)
ggplot(data=dataw0) +
  geom_point(mapping = aes(x=1,y=value),color="red")+
  facet_grid(variable~index,switch='y',)+
  xlab("")+
  ylab("")+
  theme(axis.ticks.y = element_blank(),
        axis.ticks.x = element_blank(),
        axis.text.y =element_blank(),
        axis.text.x  =element_blank(),
        strip.text.x = element_text(size=12, face='bold', color="black"),
        strip.text.y = element_text(size=12,face="bold", color="black", angle=180),
        strip.background = element_rect(fill="slategray2"))
dev.off()

cuz <- c("Kidney", "Kidney lax") 
dataw0<-dataw[dataw$variable %in% cuz,]

jpeg("Kidney_Order.jpeg", width = 6.5, height = 3, units = 'in', res = 300)
ggplot(data=dataw0) +
  geom_point(mapping = aes(x=1,y=value),color="red")+
  facet_grid(variable~index,switch='y',)+
  xlab("")+
  ylab("")+
  theme(axis.ticks.y = element_blank(),
        axis.ticks.x = element_blank(),
        axis.text.y =element_blank(),
        axis.text.x  =element_blank(),
        strip.text.x = element_text(size=12, face='bold', color="black"),
        strip.text.y = element_text(size=12,face="bold", color="black", angle=180),
        strip.background = element_rect(fill="slategray2"))
dev.off()

