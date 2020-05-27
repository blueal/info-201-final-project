my_data <- 
  vroom("https://data.seattle.gov/api/views/tazs-3rd5/rows.csv")

# A function that takes in a dataset and returns a list of info about it:
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
  summary_info$safestNeighborhood = dataset %>%
    group_by(MCPP) %>%
    summarise(count = n()) %>%
    arrange(count) %>%
    head(1) %>%
    select(MCPP) %>%
    toString()
  summary_info$badestNeighborhood = dataset %>%
    group_by(MCPP) %>%
    summarise(count = n()) %>%
    arrange(desc(count)) %>%
    head(1) %>%
    select(MCPP) %>%
    toString()
  
  return(summary_info)
}

testsummary <- get_summary_info(my_data)
