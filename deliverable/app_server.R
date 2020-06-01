server <- function (input, output) {
  output$map <- renderLeaflet({
    leaflet(location) %>%
      addTiles() %>%
      fitBounds(~min(Longitude), ~min(Latitude),
                ~max(Longitude), ~max(Latitude))

  })
  
  colorpal <- reactive ({
    colorFactor(input$colors, 
                 location$precinct)
  })
  
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
