# data for page 1, summary, & 2/3
seattle_data_small <- vroom("https://data.seattle.gov/resource/tazs-3rd5.csv")
seattle_data1 <- vroom("https://data.seattle.gov/api/views/tazs-3rd5/rows.csv")
seattle_data <- sample_n(seattle_data1, 100000)

# dataset manipulation page one



# page two and three
get_count <- seattle_data %>%
  mutate(count = 1)

# page three
get_hours <- get_count %>%
  mutate(hour_of_day = substr(`Offense Start DateTime`, 11, 13)) %>%
  filter(hour_of_day != "NA") %>%
  group_by(hour_of_day)


# summary