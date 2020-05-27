library(dplyr)

# A function that takes in a dataset and returns a list of info about it:
#SPECIAL FIELDS:
#safestNeighborhoods, badestNeighborhoods, MostCommonCrimes, LeastCommonCrimes
#all of these fields return a 5 value list of the top items
get_summary_info <- function(dataset) {
  #Create a list
  summary_info <- list()
  #Get some basic infor about the data
  summary_info$rows <- nrow(dataset)
  summary_info$columns <- ncol(dataset)
  #Get some counts about crime types
  summary_info$crime_against_types <- dataset %>%
    select("Crime Against Category") %>%
    unique() %>%
    nrow()
  summary_info$offense_parent_types <- dataset %>%
    select("Offense Parent Group") %>%
    unique() %>%
    nrow()
  summary_info$offense_types <- dataset %>%
    select(Offense) %>%
    unique() %>%
    nrow()
  #Let's figure out how long a "crime" takes to be stopped"
  summary_info$average_offense_time_days <- dataset %>%
    select(start = "Offense Start DateTime",
           end = "Offense End DateTime") %>%
    mutate(timediff = difftime(end, start, units = "days")) %>%
    summarise(avg = mean(timediff, na.rm = TRUE)) %>%
    as.numeric() %>%
    round(digits = 1)
  #Let's figure out the best and worst neighborhoods.
  #Count the amount of crimes in each neighborhood
  summary_info$avg_crimes_per_neighborhood <- dataset %>%
    group_by(MCPP) %>%
    summarise(count = n()) %>%
    summarise(avg = mean(count, na.rm = TRUE)) %>%
    as.numeric() %>%
    round(digits = 0)
  #Rank each neighborhood by crimes
  summary_info$safest_neighborhoods <- dataset %>%
    group_by(MCPP) %>%
    summarise(count = n()) %>%
    arrange(count) %>%
    head(5) %>%
    select(MCPP) %>%
    as.list()
  summary_info$badest_neighborhoods <- dataset %>%
    group_by(MCPP) %>%
    summarise(count = n()) %>%
    arrange(desc(count)) %>%
    head(5) %>%
    select(MCPP) %>%
    as.list()
  #Rank each crime by the amount it occurs
  summary_info$most_common_crimes <- dataset %>%
    group_by(Offense) %>%
    summarise(count = n()) %>%
    arrange(desc(count)) %>%
    head(5) %>%
    select(Offense) %>%
    as.list()
  summary_info$least_common_crimes <- dataset %>%
    group_by(Offense) %>%
    summarise(count = n()) %>%
    arrange(count) %>%
    head(5) %>%
    select(Offense) %>%
    as.list()
  return(summary_info)
}
