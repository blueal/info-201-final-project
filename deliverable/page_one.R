# Creates leaflet map for Seattle dataset
seattle_data_small <- 
  vroom("https://data.seattle.gov/resource/tazs-3rd5.csv")

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

description <- paste0(
  "<b>Address: </b>", seattle_data_small$`_100_block_address`,
  "<br/>",
  "<b>Crime Label: </b>", seattle_data_small$offense_parent_group,
  "<br/>",
  "<b>Crime Type: </b>", seattle_data_small$crime_against_category,
  "<br/>",
  "<b>Offense: </b>", seattle_data_small$offense
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
        choices = names(location[1:2])
      ),
      checkboxInput(
        inputId = "legend",
        "Show Legend",
        TRUE
      )
    )
  )
)

