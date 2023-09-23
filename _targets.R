# _targets.R

library(ggplot2)
library(targets)
library(tibble)
library(dplyr)

source("functions.R")

list(
  tar_target(fixed_radius, sample.int(n = 10, size = 2)),      # returns a vector of 2 numbers
  tar_target(cycling_radius, sample.int(n = 10, size = 2)),    # returns a vector of 2 numbers
  # Note (copied from example text):
  #   Because target points has iteration = "vector" in tar_target(), any reference to the whole target automatically 
  #   aggregates the branches using vctrs::vec_c(). For data frames, this just binds all the rows.
  tar_target(
    points,
    spirograph_points(fixed_radius, cycling_radius),   # note: 'spirograph_points' only accepts two single values  
    pattern = map(fixed_radius, cycling_radius),       # need this, as 'fixed_radius' and 'cycling_radius' has more than one value  
    iteration = "vector"                               # needs not to be written explicitely (seems to be default value)
  ),                                                   #   returns a single data frame (not a list)  
  tar_target(
    single_plot,
    plot_spirographs(points),                         
    pattern = map(points),                            # as above, but returns a list of two ggplot objects    
    iteration = "list"                                # this 
  ),
  tar_target(combined_plot, plot_spirographs(points))  # takes the 'single_plot' list and makes a combined plot  
)


