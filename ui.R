# countercurrent extraction

library(shiny)
library(shinythemes)

ui = navbarPage("AC 3.0: Countercurrent Separation",
                theme = shinytheme("journal"),
                header = tags$head(
                  tags$link(rel = "stylesheet",
                            type = "text/css",
                            href = "style.css")
      ),
      tabPanel("Introduction",
       fluidRow(
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
                          includeHTML("text/tubes_steps.html")
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
                          includeHTML("text/model_cce.html")
                        )),
                 column(width = 6,
                        align = "center",
                        splitLayout(
                          sliderInput("p.a",
                                      "p for solute A",
                                      min = 0, max = 1, value = 0.2,
                                      step = 0.01, ticks = FALSE,
                                      width = "200px"
                                      ),
                          sliderInput("p.b",
                                      "p for solute B",
                                      min = 0, max = 1, value = 0.8,
                                      step = 0.01, ticks = FALSE,
                                      width = "200px"),
                          sliderInput("steps", 
                                      "step number",
                                      min = 1, max = 100, value = 100,
                                      step = 1, ticks = FALSE, 
                                      width = "200px")
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
                        tags$video(src = "aniCCE.mp4", 
                                   type = "video/mp4", 
                                   width = "100%", 
                                   controls = "controls")
                 )
               )
      )
         
      ) # close user interface
