# Creates leaflet map for Seattle dataset
seattle_data <- 
  vroom("https://data.seattle.gov/resource/tazs-3rd5.csv")

location <- seattle_data %>%
  select(
    latitude,
    longitude,
    precinct
  ) %>%
  filter(latitude != "0E-9") %>%
  mutate(
    Latitude = as.numeric(latitude),
    Longitude = as.numeric(longitude)
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
      checkboxInput(
        inputId = "legend",
        "Show Legend",
        TRUE
      )
    )
  )
)
