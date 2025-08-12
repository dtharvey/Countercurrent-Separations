# global.R file for countercurrent extraction

# load packages
library(shiny)
library(shinythemes)

# place for files and scripts
# source("cce_functions.R")

# set colors
palette("Okabe-Ito")

# create plot vectors for showing tubes and steps
xleft = rep(seq(1,11,2),6)
xright = xleft + 2
ybottom = c(rep(18,6),rep(15,6),rep(12,6),rep(9,6),rep(6,6),rep(3,6))
ytop = ybottom - 2
text_x = rep(seq(2,12,2),6)
text_y = c(rep(17,6),rep(14,6),rep(11,6), rep(8,6),rep(5,6),rep(2,6))
tube_x = c(2,4,6,8,10,12)
tube_y = rep(19,6)
step_x = rep(0,6)
step_y = c(2,5,8,11,14,17)
