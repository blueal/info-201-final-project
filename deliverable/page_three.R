library("vroom")
#make an interactive plot that 
seattle_data1 <- vroom("https://data.seattle.gov/api/views/tazs-3rd5/rows.csv")
 # vroom("https://data.seattle.gov/resource/tazs-3rd5.csv")
seattle_data <- sample_n(seattle_data1, 100000)
get_count <- seattle_data %>%
  mutate(count = 1)
get_hours <- get_count %>%
  mutate(hour_of_day = substr(`Offense Start DateTime`, 11, 13)) %>%
  filter(hour_of_day != "NA") %>%
  group_by(hour_of_day)

time_page <- tabPanel(
  "Crime Type vs. Time of Day Activity",
  h2("Plot Showing Crime Frequency per Hour"),
  p("In this section, the Seattle Data set will be used to indentify and show
    what crimes occurr at certain times of the day"),
  p("To begin select a crime of your choice in the drop down menu below"),
  sidebarPanel(
    selectInput(inputId = "type_of_crime",
              label = "Type of Crime",
              choices = c(get_hours$`Offense Parent Group`),
              selected = NULL)
  ),
  mainPanel(
    plotOutput(outputId = "barchart")
  ),
  h2("Insights"),
  p("This bar chart gives us the ability to understand when we are most likley to be a
    victim of a certain crime. We can see that driving under the influence follows
    a steady trend of rates increasing from early evening and tapering back down at 
    midnight. The plot allows us to analyize if other crimes also follow trends like
    this one.")
  
)
