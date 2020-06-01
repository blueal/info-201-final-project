# Creates a server for shiny application
server <- function (input, output) {
  
  # Creates basic leaflet interactive map
  output$map <- renderLeaflet({
    leaflet(location) %>%
      addTiles() %>%
      fitBounds(~min(Longitude), ~min(Latitude),
                ~max(Longitude), ~max(Latitude))

  })
  
  # Takes in user's input about the color
  # palette
  colorpal <- reactive ({
    colorFactor(input$colors, 
                 location$precinct)
  })
  
  # Changes the color palette of the map
  # according to user input
  observe({
    pal <- colorpal()
    leafletProxy("map", data = location) %>%
      clearShapes() %>%
      addCircles(
        lat = ~Latitude,
        lng = ~Longitude,
        color = ~pal(precinct),
        fillOpacity = 0.7
      )
  })
  
  # Responds to user's input about displaying the 
  # legend
  observe({
    proxy <- leafletProxy("map", data = location)
    proxy %>% clearControls()
    if (isTRUE(input$legend)) {
      pal <- colorpal()
      proxy %>% addLegend(
        position = "bottomright",
        pal = pal,
        values = ~precinct)
    } 
  })
}
