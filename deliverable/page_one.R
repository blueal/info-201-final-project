# Creates leaflet map for Seattle dataset
seattle_data <- 
  vroom("https://data.seattle.gov/resource/tazs-3rd5.csv")

location <- seattle_data %>%
  select(
    crime_against_category,
    precinct,
    offense,
    `_100_block_address`,
    latitude,
    longitude,
  ) %>%
  filter(latitude != "0E-9") %>%
  mutate(
    Latitude = as.numeric(latitude),
    Longitude = as.numeric(longitude)
  )

description <- paste0(
  "<b>Address: </b>", seattle_data$`_100_block_address`,
  "<br/>",
  "<b>Crime Type: </b>", seattle_data$crime_against_category,
  "<br/>",
  "<b>Offense: </b>", seattle_data$offense
)

map_page <- tabPanel(
  "Mapping Criminal Activity",
  p("In this section, the Seattle dataset will be 
    used to map the locations of different incidents"),
  sidebarLayout(
    leafletOutput(
      outputId = "map"
    ),
    sidebarPanel(
      selectInput(
        "colors",
        "Color Scheme",
        rownames(subset(brewer.pal.info, category %in% c("seq", "div")))
      ),
      selectInput(
        "key",
        "Key",
        choices = colnames(location[1:2])
      ),
      checkboxInput(
        inputId = "legend",
        "Show Legend",
        TRUE
      )
    )
  )
)
