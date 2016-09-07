#' Convex Hull
#'
#' Return the convex hull for a set of (x, y) points
#'
#' The \code{convex_hull} function returns the vertices, in an anti-clockwise
#' order, of the convex hull encompassing the provided data.  This differs from
#' the \code{polygon} function as convex hull is generated automatically via
#' Andrew's Monotone algorithm and the \code{polygon} function only provides the
#' needed angles between edges of a given set of points.
#'
#' @seealso \code{\link{polygon}} \code{\link{p2d}} \code{\link{d2p}}
#' \code{\link{p2p}}
#'
#' @param x a numeric vector of x coordinates, a n by 2 matrix, or anything that
#' can be coerced to a matrix via \code{as.matrix}.
#' @param y a numeric vector of y coordinates, only needed if x is a numeric
#' vector
#' 
#' @return A \code{sccm_ch} object.  This is a \code{list} with the following
#' elements:
#' \describe{
#' \item{vertices}{a n by 2 matrix of the vertices defining the convex
#' hull.}
#' \item{data}{a matrix of the data provided}
#' \item{beta}{a numeric vector of the exterior angles for each of the
#' vertices.}
#' \item{indices}{a numeric vector of the row indices from \code{x}
#' corresponding to the data values found to be the vertices of the convex
#' hull.}
#' }
#' 
#' @examples
#'
#' set.seed(42)
#' dat <- data.frame(x = rnorm(100), y = rexp(100))
#' ch <- convex_hull(dat)
#' ch
#' plot(ch) 
#' 
#' @export
convex_hull <- function(x, y) { 
  UseMethod("convex_hull")
}

#' @export
convex_hull.default <- function(x, y) { 
  x <- as.matrix(x)
  out <- .Call('sccm_convex_hull_cpp', PACKAGE = 'sccm', x[, 1], x[, 2])
  class(out) <- c("sccm_ch", class(out))
  out
}

#' @export
convex_hull.numeric <- function(x, y) { 
  out <- .Call('sccm_convex_hull_cpp', PACKAGE = 'sccm', x, y)
  class(out) <- c("sccm_ch", class(out))
  out
}

#' @export
convex_hull.matrix <- function(x, y) { 
  out <- .Call('sccm_convex_hull_cpp', PACKAGE = 'sccm', x[, 1], x[, 2])
  class(out) <- c("sccm_ch", class(out))
  out
}

#' @export
print.sccm_ch <- function(x, ...) {
  cat("A convex hull with", length(x$indices), "vertices.\n")
  print(x$vertices)
}

#' @export
plot.sccm_ch <- function(x, ...) { 
  graphics::plot(x$data, xlab = "", ylab = "", ...)
  graphics::points(x$data[x$indices, ], col = "red", pch = 3)
  graphics::lines(x$vertices[c(seq(1L, nrow(x$vertices), by = 1), 1L), ] , col = "red")
} 
