# A function that takes in a dataset and returns a list of info about it:
#SPECIAL FIELDS:
#safestNeighborhoods, badestNeighborhoods, MostCommonCrimes, LeastCommonCrimes
#all of these fields return a 5 value list of the top items
get_summary_info <- function(dataset){
  summary_info <- list()
  
  summary_info$rows = nrow(dataset)
  summary_info$columns = ncol(dataset)
  summary_info$crimeAgainstTypes = dataset %>%
    select('Crime Against Category') %>%
    unique() %>%
    nrow()
  summary_info$OffenseParentTypes = dataset %>%
    select('Offense Parent Group') %>%
    unique() %>%
    nrow()
  summary_info$OffenseTypes = dataset %>%
    select(Offense) %>%
    unique() %>%
    nrow()
  summary_info$AverageOffenseTimeDays = dataset %>%
    select(start = 'Offense Start DateTime',
           end = 'Offense End DateTime') %>%
    mutate(timediff = difftime(end, start, units = "days")) %>%
    summarise(avg = mean(timediff, na.rm = TRUE)) %>%
    as.numeric() %>%
    round(digits = 2)
  summary_info$AvgCrimesPerNeighborhood = dataset %>%
    group_by(MCPP) %>%
    summarise(count = n()) %>%
    summarise(avg = mean(count, na.rm = TRUE)) %>%
    as.numeric() %>%
    round(digits = 0)
  summary_info$safestNeighborhoods = dataset %>%
    group_by(MCPP) %>%
    summarise(count = n()) %>%
    arrange(count) %>%
    head(5) %>%
    select(MCPP) %>%
    as.list()
  summary_info$badestNeighborhoods = dataset %>%
    group_by(MCPP) %>%
    summarise(count = n()) %>%
    arrange(desc(count)) %>%
    head(5) %>%
    select(MCPP) %>%
    as.list()
  summary_info$MostCommonCrimes = dataset %>%
    group_by(Offense) %>%
    summarise(count = n()) %>%
    arrange(desc(count)) %>%
    head(5) %>%
    select(Offense) %>%
    as.list()
  summary_info$LeastCommonCrimes = dataset %>%
    group_by(Offense) %>%
    summarise(count = n()) %>%
    arrange(count) %>%
    head(5) %>%
    select(Offense) %>%
    as.list()
  
  return(summary_info)
}
