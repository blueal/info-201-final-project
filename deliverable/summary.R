# A function that takes in a dataset and returns a list of info about it:
# SPECIAL FIELDS:
# safestNeighborhoods, badestNeighborhoods, MostCommonCrimes, LeastCommonCrimes
# all of these fields return a 5 value list of the top items

#Create summary of information based on data
summary_table <- get_summary_info(seattle_data1)

#Create the data for the first table
#Get the neighborhoods with the highest crime
neighborhood_crime <- seattle_data1 %>%
  group_by(MCPP) %>%
  summarise(count = n()) %>%
  arrange(desc(count)) %>%
  head(10)

#Create the data for the second table
#Get the top 10 most commmon offenses
types_of_crime <- seattle_data1 %>%
  group_by(Offense) %>%
  summarise(count = n()) %>%
  arrange(desc(count)) %>%
  head(10)

#Let's create our text!
crime_density <- mainPanel(
  h1("Summary of Analysis"),
  h2("Crime Density"),
  p("We've analyzed various neighborhoods crime data and found that",
    summary_table$badest_neighborhoods$MCPP[1] %>%
      str_to_title(locale = "en"),
    "had the most significant amount of crime. The surrounding neighboords also
    had noticable amounts of crime reports, including that of
    Capitol Hill which is easily accesible to the Central Buisness District.
    "),
  #Output our first plot
  plotOutput("neghborhood_bar_chart"),
  h2("Most Common Crimes"),
  p("When analyzing the different types of crime in our dataset we noticed that
    many of our findings were intuitive, such as",
    summary_table$most_common_crimes$Offense[1] %>%
      str_to_title(locale = "en"),
    "being the most common crime through the city. This is a crime many of us
    have heard throughout the news or between our friends. Note the difference
    between this crime, and the next one. We are able to conclude that this
    crime is of extraordinaty prevalence. Many neighborhoods report this as the
    most common crime."),
  #Second plot goes here
  plotOutput("types_bar_chart"),
  h2("Timing of crimes"),
  p("Many people beleive lots of crimes occur at night but the data shows that
    most crimes occur during the afternoon. The little hours of the night around
    4-5 am have the littliest amount of crime overall. You are statistically
    safer, and less likely to be the victim or witness of a crime at the very
    early morning hours. Just about around noon, we can see that crime jumps
    high in the sky."),
  p("Some crimes however had noted \"flat\" curves for time, and as such you
  might have a statistically higher chance of being the victim of that crime
    as opposed to others. An example of this would be, Kidnapping, Assault,
    and Arson.")
)

#Generate Summary Page
summary_info <- tabPanel(
  "Summary",
  crime_density
)
