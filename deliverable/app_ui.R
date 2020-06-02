source("overview.R")
source("page_one.R")
source("page_two.R")
source("page_three.R")
source("summary.R")
ui <- fluidPage(
  h1("Seattle's Criminal Activity"),
  navbarPage(
    "Tabs",
    overview,
    map_page,
    time_page,
    summary_info
  )
)
