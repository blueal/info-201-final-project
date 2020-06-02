library("vroom")
#make an interactive plot that 
seattle_data <- 
  vroom("https://data.seattle.gov/resource/tazs-3rd5.csv")

get_count <- seattle_data %>%
  mutate(count = 1)
get_hours <- get_count %>%
  mutate(hour_of_day = substr(offense_start_datetime, 11, 13)) %>%
  filter(hour_of_day != "NA") %>%
  group_by(hour_of_day)# %>%
  #filter(datsetInput) %>% 
  #summarise(total_offences_per_hour = sum(count))

hours_at_crime <- seattle_data %>%
  mutate(hour_of_day = substr(offense_start_datetime, 11, 13)) %>%
  filter(hour_of_day != "NA") %>% 
  select(hour_of_day, offense_parent_group) %>% 
  group_by(hour_of_day) %>% 
  summarise(n_distinct(offense_parent_group))

time_page <- tabPanel(
  "When do crimes happen?",
  p("In this section, the Seattle Data set will be used to indentify and show
    how many crimes occure at different hours of the day"),
  sidebarPanel(
    selectInput(inputId = "type_of_crime",
              label = "Type of Crime",
              choices = c("LARCENY-THEFT", "DRIVING UNDER THE INFLUENCE", "FRAUD OFFENSES"))
  ),
  mainPanel(
    plotOutput(outputId = "barchart")
  )
)

num_crimes_per_hour <- ggplot(get_hours) +
  # set points
  geom_point(mapping = aes(x = hour_of_day, y = total_offences_per_hour)) +
  # add plot title
  ggtitle("Number of Crimes per Hour") +
  # set white background
  theme_bw() +
  # set y-axis title
  ylab("Number of Offences") +
  # set x-axis title
  xlab("Hour of Day")
get_hours <- get_count %>%
  mutate(hour_of_day = substr(offense_start_datetime, 11, 13)) %>%
  filter(hour_of_day != "NA") %>%
  group_by(hour_of_day) #%>%
 #filter() %>% 
 #summarise(total_offences_per_hour = sum(count))
