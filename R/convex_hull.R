#' Convex Hull
#'
#' return the convex hull for a set of (x, y) points
#'
#' @param x a numeric vector of x coordinates, a n by 2 matrix, or anything that
#' can be coerced to a matrix via \code{as.matrix}.
#' @param y a numeric vector of y coordinates, only needed if x is a numeric
#' vector
#' 
#' @return a list
#'
#' @examples
#' ## Example 1
#' # Default, x and y numeric vectors
#' x <- rnorm(150)
#' y <- rnorm(150)
#' 
#' hull <- convex_hull(x, y)
#' 
#' # plot the data and the hull
#' plot(x, y) 
#' lines(hull)
#' 
#' # show interior points in red
#' points(x[-attr(hull, "indices")], 
#'        y[-attr(hull, "indices")], 
#'        col = "red", pch = 16) 
#' 
#' ## Example 2
#' # With a matrix
#' mat <- matrix(rnorm(500), nrow = 250)
#' hull2 <- convex_hull(mat)
#' 
#' plot(mat)
#' lines(hull2)
#' 
#' # show interior points in red
#' points(mat[-attr(hull2, "indices"), ], col = "red", pch = 16)
#'
#' ## Example 3
#' # Two columns from the mtcars data set
#' hull3 <- convex_hull(mtcars[, c("wt", "mpg")])
#' 
#' plot(mtcars[, c("wt", "mpg")])
#' lines(hull3)
#' points(mtcars[-attr(hull3, "indices"), c("wt", "mpg")], col = "red", pch = 16)
#' 
#' @export
convex_hull <- function(x, y) { 
  UseMethod("convex_hull")
}

#' @export
convex_hull.default <- function(x, y) { 
  x <- as.matrix(x)
  .Call('sccm_convex_hull_cpp', PACKAGE = 'sccm', x[, 1], x[, 2])
}

#' @export
convex_hull.numeric <- function(x, y) { 
  .Call('sccm_convex_hull_cpp', PACKAGE = 'sccm', x, y)
}

#' @export
convex_hull.matrix <- function(x, y) { 
  .Call('sccm_convex_hull_cpp', PACKAGE = 'sccm', x[, 1], x[, 2])
}

