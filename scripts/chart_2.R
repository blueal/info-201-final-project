library(tidyverse)
library(dplyr)
library(ggplot2)
library(knitr)
library(plotly)
library(stringr)
library(vroom)

crime_times <- function(df_https) {
  df_https <- vroom(df_https)
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

# The objective of this file is to find out which times of days crimes occured
# the most
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

crime_times("https://data.seattle.gov/resource/tazs-3rd5.csv")
