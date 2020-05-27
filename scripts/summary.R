library(dplyr)

# A function that takes in a dataset and returns a list of info about it:
# SPECIAL FIELDS:
# safestNeighborhoods, badestNeighborhoods, MostCommonCrimes, LeastCommonCrimes
# all of these fields return a 5 value list of the top items
get_summary_info <- function(dataset) {
  summary_info <- list()
  summary_info$rows <- nrow(dataset)
  summary_info$columns <- ncol(dataset)
  # number of unique Crime Against Catagory
  summary_info$crime_against_types <- dataset %>%
    select("Crime Against Category") %>%
    unique() %>%
    nrow()
  # number of unique offense parent group
  summary_info$offense_parent_types <- dataset %>%
    select("Offense Parent Group") %>%
    unique() %>%
    nrow()
  # number of unique offese type
  summary_info$offense_types <- dataset %>%
    select(Offense) %>%
    unique() %>%
    nrow()
  # number of average offense time
  summary_info$average_offense_time_days <- dataset %>%
    select(
      start = "Offense Start DateTime",
      end = "Offense End DateTime"
    ) %>%
    mutate(timediff = difftime(end, start, units = "days")) %>%
    summarise(avg = mean(timediff, na.rm = TRUE)) %>%
    as.numeric() %>%
    # round to first digit
    round(digits = 1)
  # number of average crimes per neighborhood
  summary_info$avg_crimes_per_neighborhood <- dataset %>%
    group_by(MCPP) %>%
    summarise(count = n()) %>%
    summarise(avg = mean(count, na.rm = TRUE)) %>%
    as.numeric() %>%
    round(digits = 0)
  # list of top 5 safest neighborhood
  summary_info$safest_neighborhoods <- dataset %>%
    group_by(MCPP) %>%
    summarise(count = n()) %>%
    arrange(count) %>%
    head(5) %>%
    select(MCPP) %>%
    as.list()
  # list of top 5 dangerous neighborhood
  summary_info$badest_neighborhoods <- dataset %>%
    group_by(MCPP) %>%
    summarise(count = n()) %>%
    arrange(desc(count)) %>%
    head(5) %>%
    select(MCPP) %>%
    as.list()
  # list of top 5 crime type
  summary_info$most_common_crimes <- dataset %>%
    group_by(Offense) %>%
    summarise(count = n()) %>%
    arrange(desc(count)) %>%
    head(5) %>%
    select(Offense) %>%
    as.list()
  # list of 5 least common crime type
  summary_info$least_common_crimes <- dataset %>%
    group_by(Offense) %>%
    summarise(count = n()) %>%
    arrange(count) %>%
    head(5) %>%
    select(Offense) %>%
    as.list()
  return(summary_info)
}
