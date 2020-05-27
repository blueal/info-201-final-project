library(tidyr)
library(dplyr)
library(ggplot2)
library(vroom)
library(leaflet)

seattle_map <- function(data_frame) {
  filter_data <- data_frame %>%
    select(crime_against_category, offense, `_100_block_address`, latitude, longitude) %>%
    filter(latitude != "0E-9") %>%
    mutate(latitude = as.numeric(latitude), longitude = as.numeric(longitude))
  description <- paste0(
    "<b>Address: </b>", filter_data$`_100_block_address`,
    "<br/>",
    "<b>Crime Type: </b>", filter_data$crime_against_category,
    "<br/>",
    "<b>Offense: </b>", filter_data$offense
  )
  seattle <- leaflet(filter_data) %>%
    addTiles() %>%
    addCircles(
      lng = ~longitude,
      lat = ~latitude,
      popup = ~description
    )
  return(seattle)
}
