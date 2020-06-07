# data
#seattle_data <- 
  #vroom("https://data.seattle.gov/resource/tazs-3rd5.csv")
seattle_data1 <- vroom("https://data.seattle.gov/api/views/tazs-3rd5/rows.csv")
seattle_data <- sample_n(seattle_data1, 100000)

# dataset manipulation page one


# page two


data_with_count <- seattle_data %>%
  mutate(count = 1)

# page three


# summary