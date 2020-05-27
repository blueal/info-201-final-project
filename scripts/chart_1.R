library(tidyverse)
library(dplyr)
library(ggplot2)
library(knitr)
library(evaluate)
library(plotly)
library(stringr)
library(vroom)

#Creat a function to see which crimes are most popular
most_pop_crime <- function(info) {
  seattle <- info
  types_of_crime <- seattle %>%
    mutate(count = 1) %>%
    group_by(offense_parent_group) %>%
    summarise(total_by_type = sum(count))

  crime_frequency <- ggplot(types_of_crime) +
    geom_col(mapping = aes(
      x = offense_parent_group,
      y = total_by_type)) +
    theme_bw() +
    theme(axis.text.x = element_text(angle = 60, hjust = 1, size = 5)) +
    ggtitle("Which Crime Type is Most Popular?") +
    theme(legend.position = "none") +
    ylab("Number of Occurrences") +
    xlab("Type of Crime") +
    theme(axis.title.x = element_text(margin = margin(t = 20)))

  return(crime_frequency)
}
