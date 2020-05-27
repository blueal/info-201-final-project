library(tidyverse)
library(dplyr)
library(ggplot2)
library(knitr)
library(plotly)
library(stringr)
library(vroom)

#create a function to see how many crimes occur at different times of the day
crime_times <- function(info) {
  df_https <- info
  get_count <- df_https %>%
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

  return(num_crimes_per_hour)
}

