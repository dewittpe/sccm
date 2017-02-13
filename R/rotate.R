#' Rotate
#'
#' Rotate a polygon or convex hull
#'
#' @param x a \code{sccm_ch} or \code{sccm_pg} object
#' @param counter (logical, default = \code{TRUE}), rotate counter clockwise
#' @param times (integer, default = 1), number vertices to rotate through
#'
#' @export
rotate <- function(x, counter = TRUE, times = 1L) {
  UseMethod("rotate")
}

#' @export
rotate.sccm_pg <- function(x, counter = TRUE, times = 1L) {
  for( i in 1:times) {
    idx <- c(seq(2, nrow(x$vertices)), 1)
    x$vertices <- x$vertices[idx, ]
    x$beta     <- x$beta[idx]
  }
  x
}

#' @export
rotate.sccm_ch <- function(x, counter = TRUE, times = 1L) { 
  for(i in 1:times) {
    idx <- c(seq(2, nrow(x$vertices)), 1)
    x$vertices <- x$vertices[idx, ]
    x$beta     <- x$beta[idx]
    x$indices  <- x$indices[idx]
  }
  x
}
