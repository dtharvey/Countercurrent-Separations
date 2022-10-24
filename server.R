# countercurrent extraction

library(shiny)
library(shinythemes)

# place for files and scripts
source("cce.R")

# set colors
palette("Okabe-Ito")

shinyServer(function(input, output, session){
  
  cce_results = reactive({
    cce(input$d.a, input$d.b, steps = 100)
  })
  
  output$cce_plot = renderPlot({
    cce.step(cce_results(), steps = input$steps)
  })
  
})
