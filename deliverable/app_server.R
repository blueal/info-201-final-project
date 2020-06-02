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
        fillOpacity = 0.7,
        popup = ~description,
        radius = 25
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
  
  output$barchart <- renderPlot({
      get_hours %>%
      filter(`Offense Parent Group` == input$type_of_crime) %>% 
      summarise(total_offences_per_hour = sum(count)) %>% 
      ggplot() +
      # set points
      geom_col(mapping = aes(x = hour_of_day, y = total_offences_per_hour)) +
      # add plot title
      ggtitle("Number of Crimes per Hour") +
      # set white background
      theme_minimal() +
      # set y-axis title
      ylab("Number of Offences") +
      # set x-axis title
      xlab("Hour of Day")
  })
}
