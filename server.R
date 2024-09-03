# countercurrent extraction

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

shinyServer(function(input, output, session){
  
  output$prob_plot = renderPlot({
    par(mar = c(5,4,1,2))
    plot(x = -1, y = -2, xaxt = "n", xlim = c(0,14), xlab = "",
         yaxt = "n", ylim = c(0,20), ylab = "", bty = "n", asp = 1)
    counter = 1
    fraction = rep(0,36)
    for(step in 0:5){
      for(tube in 0:5){
        if(step-tube < 0){
          fraction[counter] = 0
        } else {
          fraction[counter] = factorial(step)/(factorial(step-tube)*factorial(tube)) * (input$prob^tube) * ((1-input$prob)^(step-tube))
        }
        counter = counter + 1
      }
    }
    
    rect(xleft,ybottom,xright,ytop,
         col = rgb(86/255,180/255,233/255,fraction,maxColorValue = 1))
    text(x = text_x, y = text_y, round(fraction, digits = 2), adj = c(0.5,0.5),cex = 1)
    text(tube_x,tube_y, c(0,1,2,3,4,5), adj = c(0.5,0.5),cex = 1)
    text(x = 7, y = 20, "tube number", adj = c(0.5,0.5), cex = 1)
    text(step_x,step_y, c(5,4,3,2,1,0), adj = c(0.5,0.5, cex= 1))
    text(x = -1, y = 9.5, "step number", adj = c(0.5,0.5), cex = 1, srt = 90)
    
  })
  
  cce_results = reactive({
    cce(input$p.a, input$p.b, steps = 100)
  })
  
  output$cce_plot = renderPlot({
    cce.step(cce_results(), steps = input$steps)

  })
  
  output$cce_grid = renderPlot({
    cce_vis_data = cce(p.a = 0.83, p.b = 0.33, steps = 100)
    old.par = par(mfrow = c(3,3))
    step_number = c(10,20,30,40,50,60,70,80,90)
    for (i in 1:9){
      plot(x = cce_vis_data$fractionA[, step_number[i]],
           xlab = "tube number", 
           ylim = c(0,0.35), ylab = "fraction",
           type = "h", col = 6, lwd = 3,
           main = paste("Step: ", step_number[i]))
      points(x = 0, y = 1 - sum(cce_vis_data$fractionA[, step_number[i]]),
             type = "h", col = 6, lwd = 3)
      points(cce_vis_data$fractionB[, step_number[i]],
             type = "h", col = 8, lwd = 3)
      points(x = 0, y = 1 - sum(cce_vis_data$fractionB[, step_number[i]]),
             type = "h", col = 8, lwd = 3)
      legend(x = "topright", legend = c("A","B"),
             lwd = 3, col = c(6,8), bty = "n")
      grid()
    }
  })
  
})
