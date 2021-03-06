source("overview.R")
source("page_one.R")
source("page_two.R")
source("page_three.R")
source("summary.R")
ui <- fluidPage(
  includeCSS("styles.css"),
  theme = shinythemes::shinytheme("superhero"),
  navbarPage(
    "Seattle Crime",
    overview,
    map_page,
    crime_type_page,
    time_page,
    summary_info
  )
)
