# Map page of shiny application

# Structuring the layout of the first page of the
# shiny application
map_page <- tabPanel(
  "Mapping Criminal Activity",
  h1("Seattle Map of Reported Criminal Offense"),
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
