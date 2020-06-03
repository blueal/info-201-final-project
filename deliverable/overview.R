side_bar <- sidebarPanel(
  h3("Why Seattle Crime?"),
  p("Since strict gun regulations do not exist in the United States, safety
  for the public is of ", em("utmost"), " concern. Non-stop UW Alerts
  reporting ", strong("robbery"), ", ", strong("gun violence"), ", ",
  strong("assault"), ", etc. push safety into the forefront of UW students'
  minds."),
  p("Therefore, as a team, we decided to tie our Info 201 Final Project to
  our daily lives by analyzing crime patterns within our community - ",
  strong("Seattle")),
)

main <- mainPanel(
  h1("Overview"),
  img(src = "seattle.jpg"),
  h2("Purpose"),
  p("Give some more context & questions that we wanted to answer"),
  h2("Data"),
  p("I will explain our data & provide links"),
  h2("References"),
  p("I will include some references")
)

overview <- tabPanel(
  "Overview",
  sidebarLayout(
    side_bar,
    main,
    position = "right"
  )
)  

  #"We will be using [SPD Crime Data](https://data.seattle.gov/Public-Safety/SPD-Crime-Data-2008-Present/tazs-3rd5) 
  #as it provides crime data using the standardized crime classifications. However, due to the extreme size of the dataset,
  #we've decided to take a portion of the orginal dataset and examine those data. In our analysis, we will be using
  # columns such as offense start time, latitude & longitude, offense type, call-in resolution, etc.,
  # to help us answer these following questions:"
  #   
  # "* What areas have the highest density of crime? 
  # * What types of crime? And in what areas?
  # * What is the time of year or day for the offense, length of offense, report date?
  # * What is the relationship between call-ins and arrests (i.e. resolution of call-ins)?"
  #   
  # #### Addtional Sources for the Future
  #   
  # "* [King County Sheriff's Office - Incident Dataset](https://data.kingcounty.gov/Law-Enforcement-Safety/King-County-Sheriff-s-Office-Incident-Dataset/rzfs-wyvy): This dataset contains instances of crime reported by King Country Sherrif office and another policing agency, e.g. SPD.
  # * [911 Seattle Call Data](https://data.seattle.gov/Public-Safety/Call-Data/33kz-ixgy): 
  # 911 call data is from the Data Analytics Platform (DAP) and is logged with the Seattle Police Department (SPD)
  # Communications Center. It contains calls of police officers and observations of the
  # field from within the community and is updated(upload) daily before a full refresh twice a year.
  # Although the dataset is quite huge with 4.34 Million rows of data, we acknowledge our constraint as 
  # this dataset only includes records with police responses to the 911 call."