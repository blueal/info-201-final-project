library(tidyr)
library(dplyr)
library(ggplot2)
library(vroom)
library(leaflet)
library()

seattle_data <- 
  vroom("https://data.seattle.gov/resource/tazs-3rd5.csv")

seattle_data_filter <- seattle_data %>%
  select(crime_against_category, offense, `_100_block_address`, latitude, longitude) %>%
  filter(latitude != "0E-9") %>%
  mutate(latitude = as.numeric(latitude), longitude = as.numeric(longitude))

seattle_map <- leaflet(seattle_data_filter) %>%
  addTiles() %>%
  addCircles(
    lng = ~longitude,
    lat = ~latitude,
    fillColor = ~offense
  )
addCircle
