# dataset manipulation page one


# page two
seattle_data <- 
  vroom("https://data.seattle.gov/resource/tazs-3rd5.csv")

data_with_count <- seattle_data %>%
  mutate(count = 1)

# page three


# summary