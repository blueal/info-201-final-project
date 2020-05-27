library(dplyr)
library(ggplot2)
library(evaluate)

# Create a function to see which crimes are most popular
most_pop_crime <- function(info) {
  # load and filtter data
  seattle <- info
  types_of_crime <- seattle %>%
    mutate(count = 1) %>%
    group_by(offense_parent_group) %>%
    summarise(total_by_type = sum(count))

  crime_frequency <- ggplot(types_of_crime) +
    # set the x-axis and y-axis of the graph
    geom_col(mapping = aes(
      x = offense_parent_group,
      y = total_by_type
    )) +
    # set white background
    theme_bw() +
    # make text smaller and clearer(not overlap with the x-axis title)
    theme(axis.text.x = element_text(angle = 60, hjust = 1, size = 6)) +
    # add plot tile
    ggtitle("Which Crime Type is Most Popular?") +
    # remove ledgend
    theme(legend.position = "none") +
    # set y-axis title
    ylab("Number of Occurrences") +
    # set x-axis title
    xlab("Type of Crime") +
    # set margin
    theme(axis.title.x = element_text(margin = margin(t = 20)))

  return(crime_frequency)
}
