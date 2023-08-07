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
cce.step = function(x, steps = 1){
  plot(x$fractionA[, steps], 
       ylim = c(0, max(c(x$fractionA[ , steps], 
                         x$fractionB[, steps]), na.rm = TRUE)), 
       xlab = "tube number", ylab = "fraction", 
       type = "h", col = 3, lwd = 6,
       main = paste("Step Number: ", steps)) 
  points(x = 0, y = 1 - sum(x$fractionA[, steps]), 
         type = "h", col = 3, lwd = 6)
  points(x$fractionB[, steps], type = "h", col = 7, lwd = 3)
  points(x = 0, y = 1 - sum(x$fractionB[, steps]), 
         type = "h", col = 7, lwd = 3)
  legend(x = "topright", legend = c("A", "B"), 
         lwd = c(6,3), col = c(3, 7), bty = "n")
  grid()
}

# function to draw distribution of both solutes at end of separation
# cce.final = function(x){
#   plot(x$fractionA[, x$steps], 
#        ylim = c(0, max(c(x$fractionA[ , x$steps], 
#                          x$fractionB[, x$steps], 1 - sum(x$fractionA[, x$steps]), 1 - sum(x$fractionB[, x$steps])), na.rm = TRUE)), 
#        xlab = "tube number", ylab = "fraction", 
#        type = "h", col = "blue", lwd = 6)
#   points(x = 0, y = 1 - sum(x$fractionA[, x$steps]), 
#          type = "h", col = "blue", lwd = 6)
#   points(x$fractionB[, x$steps], type = "h", col = "green", lwd = 2)
#   points(x = 0, y = 1 - sum(x$fractionB[, x$steps]), 
#          type = "h", col = "green", lwd = 2)
#   legend(x = "topright", legend = c("A", "B"), 
#          lwd = c(6, 2), col = c("blue", "green"), bty = "n")
# }

# function to animate the separation across all steps
# cce.animate = function(x){
#   for (i in 1:x$steps) {
#     plot(x$fractionA[, i], xlim = c(1, x$steps), 
#          ylim = c(0, 1), xlab = "tube number", 
#          ylab = "fraction", type = "h", col = "blue", lwd = 6)
#     points(x = 0, y = 1 - sum(x$fractionA[, x$steps]), 
#            type = "h", col = "blue", lwd = 6)
#     points(x$fractionB[, i], type = "h", col = "green", lwd = 2)
#     points(x = 0, y = 1 - sum(x$fractionB[, x$steps]), 
#            type = "h", col = "green", lwd = 2)
#     legend(x = "topright", legend = c("A", "B"), 
#            lwd = 3, col = c("blue", "green"), bty = "n")
#     Sys.sleep(0.1)
#   }
# }

# separation of two weak acids
cce.ab = function(kd.a = 9, pka.a = 5, kd.b = 9, pka.b = 8, pH = 7, steps = 50){
  d.a = 10^-pH * kd.a/(10^-pH + 10^-pka.a)
  d.b = 10^-pH * kd.b/(10^-pH + 10^-pka.b)
  q.a = 1/(d.a + 1)
  q.b = 1/(d.b + 1)
  p.a = 1 - q.a
  p.b = 1 - q.b
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

# separation of two amino acids with same kd
cce.aa = function(pH = 7, steps = 50){
  h = 10^-pH
  kd = 5
  ka1.a = 1e-5
  ka2.a = 1e-9
  ka1.b = 1e-3
  ka2.b = 1e-7
  f.a = ka1.a * h/(h^2 + ka1.a * h + ka1.a * ka2.a)
  f.b = ka1.b * h/(h^2 + ka1.b * h + ka1.b * ka2.b)
  d.a = kd * f.a
  d.b = kd * f.b
  q.a = 1/(d.a + 1)
  q.b = 1/(d.b + 1)
  p.a = 1 - q.a
  p.b = 1 - q.b
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

