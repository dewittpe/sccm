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

