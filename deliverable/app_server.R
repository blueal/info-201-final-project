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
      colorFactor(input$colors, location[[input$key]])
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
          color = ~pal(location[[input$key]]),
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
        values = location[[input$key]],
        title = input$key
        )
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
  
  output$neghborhood_bar_chart <- renderPlot({
    bar_graph <- ggplot(neighborhood_crime,
                        aes(x=
                              reorder(
                                str_wrap(
                                  MCPP, 15),
                                -count),
                            y=count)
                        ) +
      geom_col() +
      theme(axis.text.x=element_text(angle=90,
                                     hjust=1,
                                     vjust=0.5)
            ) +
      labs(y= "Crime Count", x = "Offense Type")
    bar_graph
  })
  
  output$types_bar_chart <- renderPlot({
    bar_graph <- ggplot(types_of_crime,
                        aes(x=
                              reorder(
                                str_wrap(
                                  Offense, 15),
                                -count),
                            y=count)
    ) +
      geom_col() +
      theme(axis.text.x=element_text(angle=90,
                                     hjust=1,
                                     vjust=0.5)
      ) +
      labs(y= "Crime Count", x = "Neighborhood")
    bar_graph
  })
  
  output$bar <- renderPlot({
    p <- ggplot(data_with_count, aes(y=count,
                                     x=.data[[input$x_var]],
                                     fill=.data[[input$y_group]])) + 
      geom_bar(stat="identity") +
      scale_y_continuous(expand = c(0, 0)) +
      ylab("Count") +
      xlab("Group") 
    if (input$x_var == "offense_parent_group" | input$x_var == "offense"){
      p <- p + coord_flip()
    }
    p
  })
}
