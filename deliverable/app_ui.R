source("page_one.R")
ui <- fluidPage(
  h1("Seattle's Criminal Activity"),
  navbarPage(
    "Tabs",
    map_page
  )
)
