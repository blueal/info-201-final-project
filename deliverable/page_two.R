source("datasets.R")

names_of_filter <- c("Category" = "Crime Against Category",
                    "Offense Parent Group" = "Offense Parent Group",
                    "Offense Type" = "Offense")

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
    'popularity' in the Seattle region. With the color-based legend, the
    chart allows us to easily correlate two groupings at the same time.
    For example, when we group by the parent crime and color it by
    crime against catagory, we can observe that ", em("Larceny-Theft"),
    "'s most popular crime is against ", em("PROPERTY"), ". Additionally,
    Group A indicates ...while Group B is..."
    ),
    plotOutput("bar"),
    h2("Insights"),
    p("This chart can answer the question: what crime type is the
    most popular? Because a bar chart because is the clearest way to display
    comparison between counts of data, we can easily determine that",
    em("Larceny-Theft"), " is the most popular parent crime
    group in the Seattle area by intersecting offense type with its parent
    group.")
  ),
  sidebarPanel(
    x_input,
    y_input,
    uiOutput("excluded_groups")
  )
)
