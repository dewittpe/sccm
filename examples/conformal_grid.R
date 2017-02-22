# Build a star
star <- 
  rbind(polar2cartesian(1.0, seq(0, 1.6, by = 0.4) * pi),
        polar2cartesian(0.5, seq(0.2, 1.8, by = 0.4) * pi)) 
star <- star[rep(1:5, each = 2) + rep(c(0, 5), times = 5), ]


# generate, and plot, the grid, that would be orthogonal in the (u,v) space, in
# the (x,y) space of the star.
plot(conformal_grid(polygon(star), 15, 11))

# rotate the star
plot(conformal_grid(rotate(polygon(star), times = 3), 15, 11))
