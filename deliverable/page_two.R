library(shiny)
library(ggplot2)
library(plotly)
library(dplyr)
library(vroom)
seattle_data <- 
  vroom("https://data.seattle.gov/resource/tazs-3rd5.csv")

data_with_count <- seattle_data %>%
  mutate(count = 1)

names_of_filter <- c("Group" = "group_a_b",
                    "Category" = "crime_against_category",
                    "Parent Group" = "offense_parent_group",
                    "Offense Type" = "offense")

x_input <- selectInput(
  "x_var",
  inputId = "x_var",
  label = "Variable",
  choices = names_of_filter
)
y_input <- selectInput(
  "y_group",
  inputId = "y_group",
  label = "Group",
  choices = names_of_filter
)

crime_type_page <- tabPanel(
  "Criminal Activity Types and Frequency",
  p("In this section, we will be using the Seattle dataset
  to group crimes in diffent ways and show the frequency of them."),
  x_input,
  y_input,
  plotOutput("bar")
)
