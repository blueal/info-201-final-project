library(shiny)
library(ggplot2)
library(tidyr)
library(leaflet)
library(vroom)
library(dplyr)
library(styler)
library(RColorBrewer)
library(rsconnect)
library(stringr)

source("datasets.R")


names_of_filter <- c("Group" = "group_a_b",
                    "Category" = "crime_against_category",
                    "Offense Parent Group" = "offense_parent_group",
                    "Offense Type" = "offense")

x_input <- selectInput(
  "x_var",
  inputId = "x_var",
  label = "Count by",
  choices = names_of_filter
)

y_input <- selectInput(
  "y_group",
  inputId = "y_group",
  label = "Color by",
  choices = names_of_filter
)

#top_n_data <- sliderInput("obs", "Number of observations:",
 #             min = 1, max = data_with_count %>% group_by(x_input), value = 10)

crime_type_page <- tabPanel(
  "Frequency of Criminal Activity",
  h2("Seattle Data Crime Types Exploration"),
  sidebarPanel(
    width = 8,
    h4("Description"),
    p("The user can select the intersection of offense types and their
    'popularity' in the Seattle region. With the color-based ledgend, the
    chart allows us to easily correlate two groupings at the same time.
    For example, when we group by the parent crime and color it by
    crime against catagory, we can observe that ", em("Larceny-Theft"),
    "'s most popular crime is against ", em("PROPERTY"),". Additionally,
    Group A indicates ...while Group B is..."
    ),
    plotOutput("bar")
  ),
  sidebarPanel(
    x_input,
    y_input,
    uiOutput("excluded_groups")
  ),
  mainPanel(
    h2("Insights"),
    p("This chart can answer the question: what crime type is the
    most popular? Because a bar chart because is the clearest way to display
    comparison between counts of data, we can easilty determine that",
    em("Larceny-Theft"), " is the most popular parent crime
    group in the Seattle area by intersecting offense type with its parent
    group.")
  )
)

ui <- fluidPage(
  theme = shinythemes::shinytheme("superhero"),
  navbarPage(
    "Seattle Crime",
    crime_type_page
  )
)

server <- function(input, output) {
  output$excluded_groups <- renderUI({
    checkboxGroupInput(inputId = "x_exclude",
                       label = "Exclude groups",
                       choices = unique(data_with_count[[input$x_var]])
    )
  })
  
  output$bar <- renderPlot({
    current_dataset <- data_with_count
    for (i in input$x_exclude){
      current_dataset <- current_dataset %>% filter(.data[[input$x_var]] != i) 
    }
    p <- ggplot(data = current_dataset, aes(y=count,
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

shinyApp(ui = ui, server = server)
