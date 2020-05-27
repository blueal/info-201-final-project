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
