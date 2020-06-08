#Shiny app page consisting of hour od day of criminal activity

source("datasets.R")

# Creates a tab page consisting of a bar plot
# and an insightful description
time_page <- tabPanel(
  "Time of Criminal Activity",
  h2("Number of Crimes per Hour"),
  p("To begin select a crime of your choice in the drop down menu below."),
  sidebarLayout(
    mainPanel(plotOutput("barchart")),
    sidebarPanel(
      selectInput(inputId = "type_of_crime",
                label = "Type of Crime",
                choices = c(get_hours$`Offense Parent Group`))
    )
  ),
  h2("Insights"),
  sidebarPanel(
    width = 8,
    p("In this section, the Seattle Dataset will be used to identify and show
    what crimes occur at certain times of the day. An important insight that
    can be drawn from this plot is that for the majority of the offenses,
    most of the offenses occurred at the 0 hour, or midnight. Offenses may
    occur more at midnight than any other hour because it gets dark and
    many people are inactive at that time so it's less likely to be caught
    in the act (except for those counted in this dataset). Likewise, animal
    cruelty and gambling offenses had some of the least number of occurrences
    with six and four total occurrences respectively."),
  )
)
