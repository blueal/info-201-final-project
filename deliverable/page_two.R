library(shiny)
library(ggplot2)
library(dplyr)
library(vroom)
seattle_data <- 
  vroom("https://data.seattle.gov/resource/tazs-3rd5.csv")

filter <- seattle_data %>% mutate(count = 1) %>%
  group_by(offense_parent_group) %>%
  summarise(total_by_type = sum(count))

x_input <- selectInput(
  "x_var",
  label = "X Variable",
  choices = c("Group" = "group_a_b",
              "Category" = "crime_against_category",
              "Parent Group" = "offense_parent_group",
              "Offense Type" = "offense"),
  selected = "group_a_b"
)

exploration_page <- tabPanel(
  "Criminal Activity Types and Frequency",
  p("In this section, we will be using the Seattle dataset
  to group crimes in diffent ways and show the frequency of them."),
  x_input,
  plotOutput("bar")
)

ui <- fluidPage(
  h1("Seattle's Criminal Activity"),
  navbarPage(
    exploration_page
  )
)

server <- function(input, output) { 
  reactive_data <- reactive({
    data <- seattle_data %>% mutate(count = 1) %>%
      group_by(input$x_var) %>%
      summarise(total_by_type = sum(count))
    data
  })
  output$bar <- renderPlot({
    p <- ggplot(data = reactive_data(), aes(x=input$x_var)) + 
      geom_col(aes(y=total_by_type, fill=input$x_var)) +
      theme(axis.text.x = element_text(angle = 60, hjust = 1, size = 6)) +
      # set y-axis title
      ylab("Count") +
      # set x-axis title
      xlab("Type of Crime") +
      # set margin
      theme(axis.title.x = element_text(margin = margin(t = 20)))
    p
  })
}

shinyApp(ui = ui, server = server)