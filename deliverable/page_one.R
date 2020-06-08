# Map page of shiny application

source("datasets.R")

# Information/Insights to be displayed in the map
description <- paste0(
  "<b>Address: </b>", seattle_data_small$`_100_block_address`,
  "<br/>",
  "<b>Crime Label: </b>", seattle_data_small$offense_parent_group,
  "<br/>",
  "<b>Crime Type: </b>", seattle_data_small$crime_against_category,
  "<br/>",
  "<b>Offense: </b>", seattle_data_small$offense
)

# Structuring the layout of the first page of the 
# shiny application
map_page <- tabPanel(
  "Mapping Criminal Activity",
  h2("Seattle Map of Reported Criminal Offense"),
  sidebarLayout(
    mainPanel(
      leafletOutput(
        outputId = "map"
      )
    ),
    # Three radio buttons to change the display
    # of the interactive map
    sidebarPanel(
      selectInput("colors", "Color Scheme",
                  rownames(subset(brewer.pal.info,
                                  category %in% c("seq", "div")))
      ),
      selectInput("offense", "Offense",
                  choices = c(location$offense)
      ),
      selectInput("key", "Key", choices = names(location[1:2])
      ),
      checkboxInput(inputId = "legend", "Show Legend", TRUE
      )
    )
  ),
  h2("Insights"),
  sidebarPanel(
    width = 8,
    p("This interactive map displays not only the relative location of
    each, but also the", strong("address"), ", ", strong("crime label"),
    ", ", strong("crime type"), ", and ", strong("offense"), ". Looking
    at the crime type, the majority of the criminal incidents were offenses
    to 'PROPERTY'. What this means is that incidents that are catgeorized as
    damage/destruction to 'PROPERTY' occur more frequently than those
    categorized as damage/destruction to 'SOCIETY'. Likewise, each point
    on the map appears to group around First Hill and Belltown, which are
    precincts W and E. An interesting insight that we found was that
    one of the least occurring offenses were", strong("wire fraud"), " and",
    strong("embezzlement"), ", where there were no more than 3 incidents
    for each offense.")
  )
)
