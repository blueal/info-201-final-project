# Creates a server for shiny application
server <- function(input, output) {

  # Creates basic leaflet interactive map
  output$map <- renderLeaflet({
    leaflet(location) %>%
      addTiles() %>%
      fitBounds(~min(Longitude), ~min(Latitude),
                ~max(Longitude), ~max(Latitude))

  })

  # Takes in user's input about the color
  # palette
  colorpal <- reactive({
      colorFactor(input$colors, location[[input$key]])
  })

  # Changes the color palette of the map
  # according to user input as well as the
  # point mapping.
  observe({
    offense_map <- location %>%
      filter(offense == input$offense)

    pal <- colorpal()
      leafletProxy("map", data = offense_map) %>%
        clearShapes() %>%
        addCircles(
          lat = ~Latitude,
          lng = ~Longitude,
          color = ~pal(offense_map[[input$key]]),
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

  # Creates a bar plot on the hour of day crimes
  # are committed
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

  # Creates a bar plot about the offense committed
  # and in which neighborhood
  output$neghborhood_bar_chart <- renderPlot({
    bar_graph <- ggplot(neighborhood_crime,
                        aes(x =
                              reorder(
                                str_wrap(
                                  MCPP, 15),
                                -count),
                            y = count)

                        ) +
      geom_bar(stat = "identity", fill = "#df691a") +
      theme(axis.text.x = element_text(angle = 90,
                                     hjust = 1,
                                     vjust = 0.5)
            ) +
      labs(y = "Crime Count", x = "Neighborhood")
    bar_graph
  })

  # Creates a bar plot to display the count
  # for each offense
  output$types_bar_chart <- renderPlot({
    bar_graph <- ggplot(types_of_crime,
                        aes(x =
                              reorder(
                                str_wrap(
                                  Offense, 15),
                                -count),
                            y = count)

    ) +
      geom_bar(stat = "identity", fill = "#df691a") +
      theme(axis.text.x = element_text(angle = 90,
                                     hjust = 1,
                                     vjust = 0.5)
      ) +
      labs(y = "Crime Count", x = "Offense Type")
    bar_graph
  })

  # Changes display of plot according to user input
  output$excluded_groups <- renderUI({
    # create checkboxes
    checkboxGroupInput(inputId = "x_exclude",
                       label = "Exclude counts of",
                       choices = unique(get_count[[input$x_var]])
    )
  })

  # Creates a bar plot that can be changed by the x-axis
  output$bar <- renderPlot({
    # load data
    current_dataset <- get_count
    # filter out checked checkboxes
    for (i in input$x_exclude) {
      current_dataset <- seattle_data1 %>% filter(.data[[input$x_var]] != i)
    }
    # create plot
    p <- ggplot(data = current_dataset, aes(y = count,
                                            x = .data[[input$x_var]],
                                            fill = .data[[input$y_group]])) +
      geom_bar(stat = "identity") +
      scale_y_continuous(expand = c(0, 0)) +
      ylab("Count") +
      xlab("Group")
    # flip x-y axis for better display
    if (input$x_var == "Offense Parent Group" | input$x_var == "Offense") {
      p <- p + coord_flip()
    }
    p
  })
}
