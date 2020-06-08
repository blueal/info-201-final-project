side_bar <- sidebarPanel(
  h3("Why Seattle Crime?"),
  p("Due to the lack of strict gun regulations in United States along
  with a myriad of other unaddressed community issues, safety
  for the public is of ", em("utmost"), " concern. Non-stop UW Alerts
  reporting ", strong("robbery"), ", ", strong("gun violence"), ", ",
  strong("assault"), ", etc. push safety into the forefront of UW students'
  minds."),
  HTML('<center><img id="uw-alert" src="alert.png" width = 200 height = 200></center>'),
  p("Therefore, as a team, we decided to tie our Info 201 Final Project to
  our daily lives by analyzing crime patterns within our ", strong("Seattle"),
  "community."),
  p(strong("To see how this report was developed: "),
    a("GitHub Repository",
      href = "https://github.com/info-201a-sp20/final-project-blueal"))
)

main <- mainPanel(
  h1("Overview"),
  img(src = "seattle.jpg"),

  # purpose section
  h2("Purpose"),
  p("To develop a better understanding of crime rates in the Seattle area,
    our team put together guiding questions that drove our analysis:",
    tags$li("What areas have the highest density of crime?"),
    tags$li("What types of crime? And in what areas?"),
    tags$li("What is the time of year or day for the offense, length of
            offense, report date?")),
  p("With these in mind, we were able to disclose general information
    regarding Seattle's crime & which types, times, & areas UW students
    should be most wary of. However, it must be acknowledged that we are
    mapping crime rates based on what ", em("has been reported"), ". This
    means that areas police patrol more often will ultimately have higher
    crime rates - ", strong("skewing"), " the data."),
  tags$hr(),

  # Dataset Information
  h2("Data"),
  p("As a team, we primarily used ",
    a("Seattle Police Department Crime Data",
      href = paste("https://data.seattle.gov/Public-Safety",
      "/SPD-Crime-Data-2008-Present/tazs-3rd5")),
    "which relies on the National Incident-Based Reporting System (NIBRS)
    to collect & standardized crime classifications. The data is updated every
    ", strong("24"), " hours with reports dating back to ", strong("2008"),
    ". Besides offense type, this dataset provides information regarding each
    incident's time, location, resolution, report time, etc."),
  p("Due to the enormity of this dataset -", strong("800,000+"), "rows - our
    team was forced to reduce its size in order to render our Offense Map &
    Time Barchart. We accomplished this by randomly selecting 100,000 rows of
    the original dataset, hoping for a representative sample population.
    Additionally, data displayed on the map only includes reports since the
    beginning of 2020."),

  # datasets to use for the future
  h4("Data for Future Analysis"),
  p("For more throrough analysis of Greater Seattle Area crime, analysis of the
    datasets below should be considered",
  tags$li(a("King County Sheriff's Office - Incident Dataset",
          href = paste("https://data.kingcounty.gov/Law-Enforcement-Safety",
          "/King-County-Sheriff-s-Office-Incident-Dataset/rzfs-wyvy"))),
  tags$li(a("911 Seattle Call Data", href = paste("https://data.seattle.gov/P",
                                         "ublic-Safety/Call-Data/33kz-ixgy"))),
  ),
  p("The ", em("King County"), " dataset contains instances of crime reported
    by King Country Sherrif office and SPD. The dataset is not nearly as large
    as the SPD Crime dataset - 24,000 rows. However, it does contain similar
    crime data of the surrounding area. "),
  p(em("911 Call Data"), " is from the Data Analytics Platform (DAP) and is
    logged with the Seattle Police Department (SPD) Communications Center.
    It contains calls of police officers and observations of the field from
    within the community and is updated daily before a full refresh twice a
    year. Although the dataset contains", strong("4.34 Million"), " rows of
    data, we acknowledge its constraint: the dataset only includes records
    with police responses to the 911 call."),
  tags$hr(),

  # additional resrouces
  h2("Resources"),
  p("Additional resources to unveil the process of crime data collection."),
  tags$ol(
    tags$li("An intersting perspective on the ",
            a("validity", href = "https://www.nap.edu/read/10581/chapter/2#2"),
            " of crime data collection & its implications"),
    tags$li("National Incident-Based Reporting System",
            a("(NIBRS)", href = "https://www.fbi.gov/services/cjis/ucr/nibrs")),
    tags$li("Seattle Police Department", a("911 Call Center", href =
    "https://www.seattle.gov/police/about-us/about-policing/9-1-1-center"))
  )
)

overview <- tabPanel(
  "Overview",
  sidebarLayout(
    side_bar,
    main,
    position = "right"
  )
)
