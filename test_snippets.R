
# Libraries
library(ggplot2)
library(targets)
library(tibble)
library(dplyr)

# Functions
source("functions.R")

#
# Check without targets
#

# Make data and plot them   
df_test1 <- spirograph_points(2, 4)
plot_spirographs(points = df_test1)

# Make data and plot them. other input   
df_test2 <- spirograph_points(3, 1)
plot_spirographs(points = df_test2)

# This also works
plot_spirographs(points = bind_rows(df_test1, df_test2))

# Make df_test  
#   Doesn't work
df_test <- spirograph_points(c(2,3), c(4,1))
#   Works
df_test <- purrr::map2(c(2,3), c(4,1), spirograph_points)

# Plot
#   Doesn't work
plots <- plot_spirographs(df_test)
#   Works
plots <- plot_spirographs(bind_rows(df_test))
plots

#   Alternative that works
plots <- purrr::map(df_test, plot_spirographs)  # returns list
cowplot::plot_grid(plotlist = plots)

#
# Using targets
#
# Note that this example uses *map* in the tar_target
# Also other possibilities, see https://books.ropensci.org/targets/dynamic.html#patterns 

# show pipeline  
tar_visnetwork()

# inspect pipeline
tar_manifest()

# run pipeline
tar_make()
tar_visnetwork()  # show pipeline again    

# show result
tar_read(cycling_radius)
tar_read(fixed_radius)
df_test <- tar_read(points)
str(df_test, 1)    # note: this is just one data frame, not a list
df_test %>% count(fixed_radius, cycling_radius)

single <- tar_read(single_plot)
str(single, 1)     # note: this is a list

comb <- tar_read(combined_plot)
comb

# Check just branches:
tar_read(points, branches = 1)
tar_read(points, branches = 2)
tar_read(single_plot, branches = 1)
tar_read(single_plot, branches = 2)


