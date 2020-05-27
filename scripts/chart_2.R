library(dplyr)
library(ggplot2)

# create a function to see how many crimes occur at different times of the day
# uses hours 0-23
crime_times <- function(info) {
  # load data
  df_https <- info

  # filter data
  get_count <- df_https %>%
    mutate(count = 1)
  get_hours <- get_count %>%
    mutate(hour_of_day = substr(offense_start_datetime, 11, 13)) %>%
    filter(hour_of_day != "NA") %>%
    group_by(hour_of_day) %>%
    summarise(total_offences_per_hour = sum(count))

  num_crimes_per_hour <- ggplot(get_hours) +
    # set points
    geom_point(mapping = aes(x = hour_of_day, y = total_offences_per_hour)) +
    # add plot title
    ggtitle("Number of Crimes per Hour") +
    # set white background
    theme_bw() +
    # set y-axis title
    ylab("Number of Offences") +
    # set x-axis title
    xlab("Hour of Day")

  return(num_crimes_per_hour)
}
