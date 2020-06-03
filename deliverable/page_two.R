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

crime_type_page <- tabPanel(
  "Criminal Activity Types and Frequency",
  p("In this section, we will be using the Seattle dataset
  to group crimes in diffent ways and show the frequency of the grouping."),
  sidebarPanel(
    x_input,
    y_input
  ),
  sidebarPanel(
    width = 8,
    h4("Description"),
    p("For this chart, we can answer the question what crime type is the 
    most popular. We decided to use a bar chart because it is the clearest 
    way to display comparison between counts of data. Therefore, we can
    easily trace each intersection and know that ", em("Larceny-Theft"),
    " is the most popular parent crime group in the Seattle area. 
    Also the color ledgend allow us to see two grouping at the same time.
    For example, the parent crime group, ", em("Larceny-Theft"),
    "'s most popular crime against catagory is of, ", em("PROPERTY"),
    ".")
  ),
  plotOutput("bar")
  
)

