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
library(ggmap)
library(maps)
library(mapdata)

seattle_data <- 
  vroom("https://data.seattle.gov/resource/tazs-3rd5.csv")


#The objective of this file is to find out which times of days crimes occured
#the most 
substr(seattle_data$offense_start_datetime, 11, 13)

get_count <- seattle_data %>% 
  mutate(count = 1) 
get_hours <- get_count %>% 
  mutate(hour_of_day = substr(offense_start_datetime, 11, 13)) %>% 
  group_by(hour_of_day) %>% 
  summarise(total_offences_per_hour = sum(count))

num_crimes_per_hour <- ggplot(get_hours) +
  geom_col(mapping = aes(x = hour_of_day, y = total_offences_per_hour)) +
  ggtitle("Number of Crimes per Hour") +
  theme_bw() +
  ylab("Number of Offences") +
  xlab("Hour of Day")
  
num_crimes_per_hour
  

