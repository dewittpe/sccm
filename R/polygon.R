#' Polygon
#'
#' return the polygon and external angles for a set of (x, y) points
#'
#' @param x a numeric vector of x coordinates, a n by 2 matrix, or anything that
#' can be coerced to a matrix via \code{as.matrix}.
#' @param y a numeric vector of y coordinates, only needed if x is a numeric
#' vector
#' 
#' @return A list
#'
#' 
#' @export
polygon <- function(x, y) { 
  UseMethod("polygon")
}

#' @export
polygon.default <- function(x, y) { 
  x <- as.matrix(x)
  out <- .Call('sccm_polygon_cpp', PACKAGE = 'sccm', x[, 1], x[, 2])
  class(out) <- c("sccm_pg", class(out))
  out
}

#' @export
polygon.numeric <- function(x, y) { 
  out <- .Call('sccm_polygon_cpp', PACKAGE = 'sccm', x, y)
  class(out) <- c("sccm_pg", class(out))
  out
}

#' @export
polygon.matrix <- function(x, y) { 
  out <- .Call('sccm_polygon_cpp', PACKAGE = 'sccm', x[, 1], x[, 2])
  class(out) <- c("sccm_pg", class(out))
  out
}

