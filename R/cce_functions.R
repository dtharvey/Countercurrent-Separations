# need to generalize not on aqueous/organic but mobile/stationary; thus
# q is fraction extracted into or remaining in stationary phase
# p is fraction extracted into or remaining in mobile phase
# d is distribution ratio from mobile phase moving to stationary phase
# n is indexed value for a step
# r is indexed value for a tube

# function to calculate fraction of solutes in each phase at each step
cce = function(p.a = 0.2, p.b = 0.8, steps = 50){
  # q.a = 1/(d.a + 1)
  # q.b = 1/(d.b + 1)
  q.a = 1 - p.a
  q.b = 1 - p.b
  f.a = matrix(0, steps, steps)
  f.b = matrix(0, steps, steps)
  for (n in 1:steps){
    for (r in 1:n){
      f.a[r, n] = 
        (factorial(n)/(factorial(n-r)*factorial(r)))*p.a^r*q.a^(n - r)
      f.b[r, n] = 
        (factorial(n)/(factorial(n-r)*factorial(r)))*p.b^r*q.b^(n - r)
    }
  }
  out = list("fractionA" = f.a, "fractionB" = f.b, "steps" = steps)
}

# function to draw distribution of solutes at any single step
cce.step = function(x, steps){
  plot(x$fractionA[, steps], 
       ylim = c(0, max(c(x$fractionA[ , steps], 
                         x$fractionB[, steps]), na.rm = TRUE)), 
       xlab = "tube number", ylab = "fraction", 
       type = "h", col = 6, lwd = 6,
       main = paste("Step Number: ", steps)) 
  points(x = 0, y = 1 - sum(x$fractionA[, steps]), 
         type = "h", col = 6, lwd = 6)
  points(x$fractionB[, steps], type = "h", col = 7, lwd = 3)
  points(x = 0, y = 1 - sum(x$fractionB[, steps]), 
         type = "h", col = 7, lwd = 3)
  legend(x = "topright", legend = c("A","B"), 
         lwd = c(6,3), col = c(6, 7), bty = "n")
  grid()
  
}


