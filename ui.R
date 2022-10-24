# countercurrent extraction

library(shiny)
library(shinythemes)

ui = navbarPage("AC 3.0: Countercurrent Separation",
                theme = shinytheme("journal"),
                tags$head(
                  tags$link(rel = "stylesheet",
                            type = "text/css",
                            href = "style.css")
      ),
      tabPanel("Visualizing a Countercurrent Extraction",
       fluidRow(
         column(width = 6,
          wellPanel(
            includeHTML("introduction.html")
      )      
      ),
         column(width = 6,
                align = "center",
          splitLayout(
            sliderInput("d.a", "distribution ratio for solute A",
                        min = 0.1, max = 10, value = 0.5, step = 0.1,
                        width = "200px"),
            sliderInput("d.b", "distribution ratio for solute B",
                        min = 0.1, max = 10, value = 5, step = 0.1, 
                        width = "200px"),
            sliderInput("steps", "step number",
                        min = 1, max = 100, value = 1, step = 1,
                        width = "200px", 
                        animate = animationOptions(interval = 250))
      ),
      plotOutput("cce_plot", height = "400px"),
      img(src = "cce.png", width = "100%")
      )
      )
      )
         
      ) # close user interface
