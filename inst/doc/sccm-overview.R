## ---- include = FALSE----------------------------------------------------
library(sccm)
knitr::opts_chunk$set(collapse = TRUE)

## ------------------------------------------------------------------------
set.seed(42)

# Required packages to re-create the following examples
library(sccm)

## ------------------------------------------------------------------------
# return the Cartesian coordinates of the point on the unit circle with and
# angle of 2 pi/ 3
cart <- polar2cartesian(r = 1, theta = 2 * pi / 3)
cart
all.equal(cart, matrix(c(-0.5, sqrt(3) / 2), nrow = 1)
)

# Return a disk of a given radius, or a radii of a
disk3 <- polar2cartesian(r = 3, theta = seq(0, 2 * pi, length = 500L))
disk4 <- polar2cartesian(r = 4, theta = seq(0, 2 * pi, length = 500L))
radii <- polar2cartesian(r = seq(0, 4, length = 100L), theta = 0.75 * pi)

plot(disk4, col = "black", asp = 1, xlab = "", ylab = "")
points(disk3, col = "red")
points(radii, col = "blue")

## ------------------------------------------------------------------------
cartesian2polar(-0.5, sqrt(3)/2)
all.equal(cartesian2polar(-0.5, sqrt(3)/2), 
          matrix(c(1, 2 * pi / 3), nrow = 1))

## ------------------------------------------------------------------------
pg <- polygon(x = c( 1, 1, 2,  3), 
              y = c(-1, 0, 2, -2))

pg

class(pg)

str(pg)

plot(pg)

## ------------------------------------------------------------------------
star <- 
  rbind(polar2cartesian(1.0, seq(0, 1.6, by = 0.4) * pi),
        polar2cartesian(0.5, seq(0.2, 1.8, by = 0.4) * pi)) 

plot(polygon(star))

## ------------------------------------------------------------------------
star <- star[rep(1:5, each = 2) + rep(c(0, 5), times = 5), ]
star_pg <- polygon(star)
plot(star_pg)

## ------------------------------------------------------------------------
xvec = runif(150)
yvec = 2 * xvec + rnorm(150)

ch <- convex_hull(xvec, yvec)

ch

class(ch)

str(ch)

plot(ch)

## ------------------------------------------------------------------------
plot(convex_hull(mtcars[, c("mpg", "wt")]))
title(xlab = "MT Cars: MPG", ylab = "MT Cars: Weight")

## ------------------------------------------------------------------------
is_convex_hull(ch)
is_convex_hull(polygon(c(-1, -1, 1, 1), c(-1, 1, 1, -1)))  # clockwise square
is_convex_hull(polygon(c(-1, -1, 1, 1), c(1, -1, -1, 1)))  # anti-clockwise square
is_convex_hull(star_pg)

## ------------------------------------------------------------------------
is_anticlockwise(ch)
is_anticlockwise(polygon(c(-1, -1, 1, 1), c(-1, 1, 1, -1)))  # clockwise square
is_anticlockwise(polygon(c(-1, -1, 1, 1), c(1, -1, -1, 1)))  # anti-clockwise square
is_anticlockwise(star_pg)

## ------------------------------------------------------------------------
# a point on an edge
xx <- 0.75
yy <- (diff(star_pg$vertices[1:2, 2]) / diff(star_pg$vertices[1:2, 1])) * (xx - star_pg$vertices[1, 1]) + star_pg$vertices[1, 2]

is_in(-0.4, 0.1, star_pg) # inside
is_in(0.5, -0.6, star_pg) # outside
is_in(0.5, yy, star_pg)   # on an edge

# send a set of points to is_in
xcoords <- c(-0.4, 0.5, 0.5)
ycoords <- c(0.1, -0.6, yy)
is_in(xcoords, ycoords, star_pg)
summary(is_in(xcoords, ycoords, star_pg))

plot(star_pg, asp = 1)
points(-0.4, 0.1, pch = 16, col = "black") # inside
points(0.5, -0.6, pch = 16, col = "blue")  # outside
points(xx, yy,    pch = 16, col = "red")   # on an edge 

## ------------------------------------------------------------------------
# d2p(

## ------------------------------------------------------------------------
# p2d(

## ---- fig.width = 9, fig.height = 6--------------------------------------
square_fish <- p2p(HexagonalFish[, 1:2])
plot(square_fish, col = cut(HexagonalFish[, 3], breaks = 2))

## ---- fig.width = 9, fig.height = 6--------------------------------------
star_fish <- p2p(HexagonalFish[, 1:2], pg2 = star_pg)
plot(star_fish, col = cut(HexagonalFish[, 3], breaks = 2))

