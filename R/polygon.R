#' Polygon
#'
#' Return the polygon and external angles for a set of (x, y) points
#'
#' Providing a set of vertices, \code{polygon} provides the angles between
#' edges.
#'
#' It is expected that the vertices are provided in an anti-clockwise order.
#' The anti-clockwise order is needed when constructing the conformal mappings.
#'
#' @seealso \code{\link{convex_hull}} \code{\link{p2d}} \code{\link{d2p}}
#' \code{\link{p2p}}
#'
#' @param x a numeric vector of x coordinates, a n by 2 matrix, or anything that
#' can be coerced to a matrix via \code{as.matrix}.
#' @param y a numeric vector of y coordinates, only needed if x is a numeric
#' vector
#' 
#' @return A \code{sccm_pg} object.  This is a \code{list} with the following
#' elements:
#' \describe{
#' \item{vertices}{a n by 2 matrix of the vertices defining the convex
#' hull.}
#' \item{beta}{a numeric vector of the exterior angles for each of the
#' vertices.}
#' }
#'
#' @examples
#' xvec <- c(-1, -0.3, 1.2, 0.45, -2)
#' yvec <- c(-1, 1.2, -0.2, 1.8, 0.3)
#' pg <- sccm::polygon(xvec, yvec)
#' pg
#' pg$beta
#' plot(pg)
#'
#' # Build a star
#' # the following builds the set of vertices, but not in a anti-clockwise
#' # order.  This is visible in the plot as the result is an irregular polygon.
#' 
#' star <- 
#'   rbind(sccm::polar2cartesian(r = 1.0, theta = seq(0, 1.6, by = 0.4) * pi),
#'         sccm::polar2cartesian(r = 0.6, theta = seq(0.2, 1.8, by = 0.4) * pi))
#' 
#' plot(sccm::polygon(star))
#' 
#' # reorder the vertices 
#' star <- star[rep(1:5, each = 2) + rep(c(0, 5), times = 5), ]
#' plot(sccm::polygon(star))
#' 
#' @seealso \code{\link{polar2cartesian}} \code{link{convex_hull}}
#'
#' @export
polygon <- function(x, y) { 
  UseMethod("polygon")
}

#' @export
polygon.default <- function(x, y) { 
  x <- as.matrix(x)
  # out <- .Call('sccm_polygon_cpp', PACKAGE = 'sccm', x[, 1], x[, 2])
  out <- polygon_cpp(x[, 1], x[, 2])
  class(out) <- c("sccm_pg", class(out))
  out
}

#' @export
polygon.numeric <- function(x, y) { 
  # out <- .Call('sccm_polygon_cpp', PACKAGE = 'sccm', x, y)
  out <- polygon_cpp(x, y)
  class(out) <- c("sccm_pg", class(out))
  out
}

#' @export
polygon.matrix <- function(x, y) { 
  # out <- .Call('sccm_polygon_cpp', PACKAGE = 'sccm', x[, 1], x[, 2])
  out <- polygon_cpp(x[, 1], x[, 2])
  class(out) <- c("sccm_pg", class(out))
  out
}

#' @export
print.sccm_pg <- function(x, ...) {
  cat("A polygon with", nrow(x$vertices), "vertices.\n")
  print(x$vertices)
}

#' @export
plot.sccm_pg <- function(x, ...) { 
  graphics::plot(x$vertices, xlab = "", ylab = "", col = "red", pch = 3, ...)
  graphics::lines(x$vertices[c(seq(1L, nrow(x$vertices), by = 1), 1L), ] , col = "red")
} 

