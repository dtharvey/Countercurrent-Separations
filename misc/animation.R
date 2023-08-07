# code to create gif animation of cce separation

# load animation package
library(animation)

# create file using cce.R for cce separation
images = cce(steps = 100)

# animateCCE function to create gif file
animateCCE = function(filename, out_type = "gif", out_name = "aniCCE"){
  # adjust ani.options
  old.ani = animation::ani.options(interval = 1, loop = 1)
  # create and save files
    animation::saveGIF({
      for (i in 1:filename$steps) {
        cce.step(filename, steps = i)
        }}, movie.name = paste0(out_name,".gif")
    )
  # reset the original values for ani.options
  animation::ani.options(old.ani)
}

# use animateCCE to create file
animateCCE(filename = images)

# use an on-line file converter to create mp4 file for use in shiny app
