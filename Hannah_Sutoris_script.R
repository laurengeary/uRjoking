#Hannah Sutoris

library(ggplot2)
library(tidyverse)

#1. A dat variable containing the scales dataset.
dat <- read.csv("scales.csv")

#2. A line of code which reports the class of each column in the dataset.
sapply(dat,class)

#3. A line of code which reports the dimensions of the dataset.
dim(dat) #see how large the data set is
#head(dat) reveals first few lines of data

#4. Code that produces a summary of the number of scales punctured for each species.
dat %>%
  group_by(species) %>%
  summarise(n = n()) #group by species
species.n<- dat %>%
  group_by(species) %>%
  summarise(n = n())
species.n #save the results to a variable

#5. Code that produces a summary of the number of specimens sampled for each species
dat %>% 
  count(species,specimen) %>%
  print() %>%
  count(species,name = "n.specimens")

#6. Code that produces a PDF file containing 6 figures, one for each species that includes a boxplot of puncture force verus quadrant.
for(i in species){
  p <- dat %>%
    filter(species==i)%>%
    ggplot()+geom_boxplot(aes(x=quadrant,y=N))+ggtitle(i)
  print(p)
} #make a boxplot
#save a pdf file
pdf("species_quadrant.pdf")
for(i in species){
  p <- dat %>%
    filter(species==i)%>%
    ggplot()+geom_boxplot(aes(x=quadrant,y=N))+ggtitle(i)
  print(p)
}
dev.off()
list.files(pattern=".pdf")

