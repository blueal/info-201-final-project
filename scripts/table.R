library(dplyr)

# function that returns table to relate avg report delay (days) to each
# type of offense
by_offense <- function(data) {
  by_offense <- data %>%
    mutate(time_difference = difftime(`Report DateTime`,
                                      `Offense Start DateTime`,
                                      units = "days")) %>%
    group_by(`Offense`) %>%
    summarise(occurrences = n(),
              report_delay =
                round(mean(time_difference, na.rm = TRUE), digits = 2)) %>%
    arrange(-report_delay)
  return(by_offense)
}

# function that returns table to relate avg report delay (days) to
# each neighborhood
by_neighborhood <- function(data) {
  by_neighborhood <- data %>%
    mutate(time_difference = difftime(`Report DateTime`,
                                      `Offense Start DateTime`,
                                      units = "days")) %>%
    group_by(`MCPP`) %>%
    summarise(occurrences = n(),
              report_delay =
                round(mean(time_difference, na.rm = TRUE), digits = 2)) %>%
    arrange(-report_delay)
  return(by_neighborhood)
}

# total average report delay in days
avg_report_delay <- function(table) {
  info <- table %>%
    mutate(total_time = report_delay * occurrences) %>%
    summarise(avg_report_delay = round(sum(total_time) /
                                         sum(occurrences), digits = 2)) %>%
    pull()
  return(info)
}

# relevant info by neighborhood & offense

# max_n <- neighborhood_info %>%
#   filter(report_delay == max(report_delay, na.rm = TRUE))
# min_n <- neighborhood_info %>%
#   filter(report_delay == min(report_delay, na.rm = TRUE))
# max_time_n <- round(pull(max_n, report_delay), digits = 2) # in days
# min_time_n <- round(pull(min_n, report_delay), digits = 2) # in days
# max_neighborhood <- pull(max_n, `MCPP`) # area with largest delay
# min_neighborhood <- pull(min_n, `MCPP`) # area with smallest delay

# max_o <- offense_info %>%
#   filter(report_delay == max(report_delay, na.rm = TRUE))
# min_o <- offense_info %>%
#   filter(report_delay == min(report_delay, na.rm = TRUE))
# max_time_o <- round(pull(max_o, report_delay), digits = 2) # in days
# min_time_o <- round(pull(min_o, report_delay), digits = 2) # in days
# max_offense <- pull(max_o, `Offense`) # offense with largest delay
# min_offense <- pull(min_o, `Offense`) # offense with smallest delay