library(dplyr)
library(vroom)

seattle_data <- vroom("https://data.seattle.gov/resource/tazs-3rd5.csv")

# function that returns table to relate avg report delay (hrs) to each
# type of offense
by_offense <- function(data) {
  by_offense <- data %>%
    mutate(time_difference = difftime(report_datetime,
                                      offense_start_datetime,
                                      units = "hours")) %>%
    group_by(offense) %>%
    summarise(occurences = n(),
              report_delay =
                round(mean(time_difference, na.rm = TRUE), digits = 2)) %>%
    arrange(-report_delay)
  return(by_offense)
}

# function that returns table to relate avg report delay (hrs) to
# each neighborhood
by_neighborhood <- function(data) {
  by_neighborhood <- data %>%
    mutate(time_difference = difftime(report_datetime,
                                      offense_start_datetime,
                                      units = "hours")) %>%
    group_by(mcpp, offense) %>%
    summarise(occurences = n(),
              report_delay =
                round(mean(time_difference, na.rm = TRUE), digits = 2)) %>%
    arrange(-report_delay)
  return(by_neighborhood)
}

# renders tables & relevant info
neighborhood_info <- by_neighborhood(seattle_data)
# max_n <- neighborhood_info %>%
# filter(report_delay == max(report_delay, na.rm = TRUE))
# min_n <- neighborhood_info %>%
# filter(report_delay == min(report_delay, na.rm = TRUE))
# max_time_n <- pull(max_n, report_delay) / 24 # in days
# min_time_n <- pull(min_n, report_delay) # in hours
# max_neighborhood <- pull(max_n, mcpp) # area with largest delay
# min_neighborhood <- pull(min_n, mcpp) # area with smallest delay

offense_info <- by_offense(seattle_data)
# max_o <- offense_info %>%
# filter(report_delay == max(report_delay, na.rm = TRUE))
# min_o <- offense_info %>%
# filter(report_delay == min(report_delay, na.rm = TRUE))
# max_time_o <- pull(max_o, report_delay) / 24 # in days
# min_time_o <- pull(min_o, report_delay) # in hours
# max_offense <- pull(max_o, mcpp) # offense with largest delay
# min_offense <- pull(min_o, mcpp) # offense with smallest delay

# total average report delay in days
avg_report_delay <- offense_info %>%
  mutate(total_time = report_delay * occurences) %>%
  summarise(avg_report_delay = round((sum(total_time)
                                      / sum(occurences)) / 24, digits = 2)) %>%
  pull()
