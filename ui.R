# countercurrent extraction

library(shiny)
library(shinythemes)

ui = navbarPage("AC 3.0: Countercurrent Extraction",
                theme = shinytheme("journal"),
                header = tags$head(
                  tags$link(rel = "stylesheet",
                            type = "text/css",
                            href = "style.css")
      ),
      tabPanel("Introduction",
       fluidRow(
         withMathJax(),
         column(width = 6,
          wellPanel(
            includeHTML("text/introduction.html")
      )      
      ),
         column(width = 6,
                align = "center",
                br(),
                br(),
                br(),
                br(),
      img(src = "cce.png", width = "100%")
      )
      )
      ),
      tabPanel("Tubes and Steps",
               fluidRow(
                 column(width = 6,
                        wellPanel(
                          includeHTML("text/activity1.html")
                        )      
                 ),
                 column(width = 6,
                        align = "center",
                        splitLayout(
                          sliderInput("prob", "extraction probability (p)",
                                      min = 0, max = 1, value = 0.5, 
                                      step = 0.01, ticks = FALSE,
                                      width = "250px")
                        ),
                        plotOutput("prob_plot", height = "750px"),
                        ))),
      
      tabPanel("Visualizing a CCE",
               fluidRow(
                 column(width = 6,
                        wellPanel(
                          includeHTML("text/activity2.html")
                        )),
                 column(width = 6,
                        align = "center",
                        splitLayout(
                          sliderInput("p.a",
                                      "p for solute A",
                                      min = 0, max = 1, value = 0.83,
                                      step = 0.01, ticks = FALSE,
                                      width = "200px"
                                      ),
                          sliderInput("p.b",
                                      "p for solute B",
                                      min = 0, max = 1, value = 0.33,
                                      step = 0.01, ticks = FALSE,
                                      width = "200px"),
                          sliderInput("steps", 
                                      "step number",
                                      min = 1, max = 100, value = 50,
                                      step = 1, ticks = FALSE, 
                                      width = "200px",
                                      animate = TRUE,
                                      animationOptions(interval = 100))
                        ),
                        plotOutput("cce_plot", height = "600px")
               ))),
      
      tabPanel("Wrapping Up",
               fluidRow(
                 column(width = 6,
                        wellPanel(id = "wrapuppanel",
                                  style = "overflow-y:scroll; max-height:750px",
                                  includeHTML("text/wrapup.html")
                        )             
                 ),
                 column(width = 6,
                        align = "center",
                        plotOutput("cce_grid", height = "600px")    
                 )
               )
      )
         
      ) # close user interface
