library(tidyr)
library(dplyr)
library(ggplot2)
library(vroom)
library(leaflet)

# Function to create interactive map
# Filters the dataset for specific columns
seattle_map <- function(info) {
  filter_data <- info %>%
    select(
      crime_against_category,
      precinct,
      offense,
      `_100_block_address`,
      latitude,
      longitude) %>%
    filter(latitude != 0) %>%
    mutate(
      latitude = as.numeric(latitude),
      longitude = as.numeric(longitude)
      )
# Creates a description for the points on the map
  description <- paste0(
    "<b>Address: </b>", filter_data$`_100_block_address`,
    "<br/>",
    "<b>Crime Type: </b>", filter_data$crime_against_category,
    "<br/>",
    "<b>Offense: </b>", filter_data$offense
  )
# Creates a color palette based on the "precinct" column
  pal <- colorFactor(
    palette = "Spectral",
    domain = filter_data$precinct
  )
# Creates interactive map using variables listed above
  seattle <- leaflet(filter_data) %>%
    addTiles() %>%
    addCircles(
      lng = ~longitude,
      lat = ~latitude,
      popup = ~description,
      color = ~pal(precinct),
      radius = 25,
      opacity = 50
    ) %>%
    addLegend(
      "bottomright",
      pal = pal,
      values = ~precinct,
      title = "Precinct of Crimes"
    )
  return(seattle) #Returns the map
}
