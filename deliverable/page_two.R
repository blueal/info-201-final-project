# Shiny app page consisting of interactive plot

source("datasets.R")

# create named-list of allows user choices
names_of_filter <- c("Category" = "Crime Against Category",
                    "Offense Parent Group" = "Offense Parent Group",
                    "Offense Type" = "Offense")

# Add a selectInput that allows choice of grouping
x_input <- selectInput(
  "x_var",
  inputId = "x_var",
  label = "Count by",
  choices = names_of_filter
)

# Add a selectInput that allows choice of coloring
y_input <- selectInput(
  "y_group",
  inputId = "y_group",
  label = "Color by",
  choices = names_of_filter
)

# Create tab
crime_type_page <- tabPanel(
  "Frequency of Criminal Activity",
  h2("Seattle Data Crime Types Exploration"),
  p("To begin, choose which category occurances will be counted & which will
    be differentiated by color."),
  # Format displayment
  sidebarLayout(
    mainPanel(
      plotOutput("bar"),
      h2("Insights"),
      sidebarPanel(
        # edit sidebarPanel size to line up with the plot size
        width = 12,
        p("This chart can answer the question: what crime type is the
        most popular? Because a bar chart is the clearest way to display
        comparison between counts of data, we can easily determine that",
          em("Larceny-Theft"), " is the most popular parent crime
        group in the Seattle area by intersecting offense type with its parent
        group, Property.")
      ),
    ),
    sidebarPanel(
      x_input,
      y_input,
      uiOutput("excluded_groups")
    )
  )
)
