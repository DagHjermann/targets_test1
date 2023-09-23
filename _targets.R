# _targets.R

library(ggplot2)
library(targets)
library(tibble)
library(dplyr)

source("functions.R")

list(
  tar_target(fixed_radius, sample.int(n = 10, size = 2)),
  tar_target(cycling_radius, sample.int(n = 10, size = 2)),
  tar_target(
    points,
    spirograph_points(fixed_radius, cycling_radius),  # note: 'spirograph_points' only accepts two single values  
    pattern = map(fixed_radius, cycling_radius)       # need this as 'fixed_radius' and 'cycling_radius' has more than one value  
  ),                                                  #   returns a single data frame (not a list)  
  tar_target(
    single_plot,
    plot_spirographs(points),                         
    pattern = map(points),                            # as above, but returns a list of two ggplot objects    
    iteration = "list"
  ),
  tar_target(combined_plot, plot_spirographs(points))  # takes the 'single_plot' list and makes a combined plot  
)
