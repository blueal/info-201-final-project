source("datasets.R")

time_page <- tabPanel(
  "Time of Criminal Activity",
  h2("Number of Crimes per Hour"),
  p("To begin select a crime of your choice in the drop down menu below."),
  mainPanel(
    plotOutput(outputId = "barchart")
  ),
  sidebarPanel(
    selectInput(inputId = "type_of_crime",
              label = "Type of Crime",
              choices = c(get_hours$`Offense Parent Group`))
  ),
  tags$hr(),
  sidebarPanel(
    h2("Insights"),
    width = 8,
    p("In this section, the Seattle Dataset will be used to identify and show
    what crimes occur at certain times of the day"),
  )
)
