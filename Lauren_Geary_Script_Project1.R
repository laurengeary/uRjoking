#Lauren Geary

library(ggplot2)
library(tidyverse)
setwd("/Users/laurengeary/Desktop/uRjoking")

#1: A dat variable containing the scales dataset
dat<-read.csv("scales.csv")

#2: A line of code which reports the class of each column in the dataset
sapply(dat,class)

#3: A line of code which reports the dimensions of the dataset
dim(dat)

#4:Code that produces a summary of the number of scales punctured for each species 
dat$species <- as.factor(dat$species)
species <- levels(dat$species)
species
length(species)
dat$species==species[1]
dat$species[dat$species==species[1]]

A.rup<-length(dat$species[dat$species==species[1]])
L.gib<-length(dat$species[dat$species==species[2]])
L.mac<-length(dat$species[dat$species==species[3]])
M.sal<-length(dat$species[dat$species==species[4]])
M.sax<-length(dat$species[dat$species==species[5]])
P.fla<-length(dat$species[dat$species==species[6]])

#combine the results with species
species.obs <- data.frame(sp=species,n=c(A.rup,L.gib,L.mac,M.sal,M.sax,P.fla))
species.obs

dat %>%
  group_by(species) %>%
  summarise(n = n())

species.n<- dat %>%
  group_by(species) %>%
  summarise(n = n())
species.n 

#5:Code that produces a summary of the number of specimens sampled for each species
dat %>% 
  count(species,specimen) %>%
  print() %>%
  count(species,name = "n.specimens")

#6: Code that produces a PDF file containing 6 figures, one for each species that includes a boxplot of puncture force versus quadrant
#Loop when you can:
for(i in 1:10) print(i)
for(i in species){
  p <- dat %>%
    filter(species==i)%>%
    ggplot()+geom_boxplot(aes(x=quadrant,y=N))+ggtitle(i)
  print(p)
} 
pdf("species_quadrant.pdf")
for(i in species){
  p <- dat %>%
    filter(species==i)%>%
    ggplot()+geom_boxplot(aes(x=quadrant,y=N))+ggtitle(i)
  print(p)
}
dev.off()
list.files(pattern=".pdf")