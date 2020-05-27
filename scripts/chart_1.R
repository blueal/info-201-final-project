library(tidyverse)
library(dplyr)
library(usmap)
library(rworldmap)
library(ggplot2)
library(knitr)
library(evaluate)
library(mapproj)
library(plotly)
library(stringr)
library(vroom)

seattle_data <- 
  vroom("https://data.seattle.gov/resource/tazs-3rd5.csv")


#take a look at what types of crimes there are in the data set
unique(seattle_data$offense_parent_group)

#choose a random part of the data set large enough to represent entire sample
#data <- sample_n(seattle_data, size=1500)

#check out how many of each crime was commited throught the years
types_of_crime <- seattle_data %>% 
  mutate(count = 1) %>% 
  group_by(offense_parent_group) %>%
  summarise(total_by_type = sum(count))

#create a chart tompare each crime categorys frequency
#this graph is meant to highlight the offense parent groups that stand out
#or in other words the most frequently occuring crimes
crime_frequency <- ggplot(types_of_crime) +
  geom_col(mapping = aes(x = offense_parent_group, y = total_by_type)) +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 60, hjust = 1)) +
  ggtitle("Which Crime Type is Most Popular?") +
  theme(legend.position = "none")

crime_frequency
