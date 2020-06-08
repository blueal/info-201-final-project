# data for page 1, summary, & 2/3
seattle_data_small <- vroom("https://data.seattle.gov/resource/tazs-3rd5.csv")
seattle_data1 <- vroom("https://data.seattle.gov/api/views/tazs-3rd5/rows.csv")
seattle_data <- sample_n(seattle_data1, 100000)

# dataset manipulation page one
location <- seattle_data_small %>%
  mutate(
    Latitude = as.numeric(latitude),
    Longitude = as.numeric(longitude),
    Crime = crime_against_category,
    Precinct = precinct
  ) %>%
  select(
    Crime,
    Precinct,
    offense,
    `_100_block_address`,
    offense_parent_group,
    Latitude,
    Longitude
  ) %>%
  filter(Latitude != 0.00000)


# page two and three
get_count <- seattle_data %>%
  mutate(count = 1)

# page three
get_hours <- get_count %>%
  mutate(hour_of_day = substr(`Offense Start DateTime`, 11, 13)) %>%
  filter(hour_of_day != "NA") %>%
  group_by(hour_of_day)

# summary
get_summary_info <- function(dataset) {
  summary_info <- list()
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
