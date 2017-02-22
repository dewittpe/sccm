#' Rotate
#'
#' Rotate a polygon or convex hull.
#'
#' The default call to \code{rotate} simply moves the first vertex to the last
#' row of the vertex matrix and moves all the other rows up one, i.e.,
#'
#' \code{x$vertices <- x$vertices[c(2:nrow(x$vertices), 1), ]}.
#'
#' For \code{times > 1L}, the above code line is evaluated \code{times} times.
#'
#' The \code{vertices} and \code{beta} elements of \code{sccm_pg} objects are
#' updated.  \code{sccm_ch} objects have \code{vertices}, \code{beta}, and
#' \code{index} updated.
#'
#' @param x a \code{sccm_ch} or \code{sccm_pg} object
#' @param times (integer, default = 1), number vertices to rotate through
#'
#' @export
rotate <- function(x, times = 1L) {
  UseMethod("rotate")
}

#' @export
rotate.sccm_pg <- function(x, times = 1L) {
  for( i in 1:times) {
    idx <- c(seq(2, nrow(x$vertices)), 1)
    x$vertices <- x$vertices[idx, ]
    x$beta     <- x$beta[idx]
  }
  x
}

#' @export
rotate.sccm_ch <- function(x, times = 1L) {
  for(i in 1:times) {
    idx <- c(seq(2, nrow(x$vertices)), 1)
    x$vertices <- x$vertices[idx, ]
    x$beta     <- x$beta[idx]
    x$indices  <- x$indices[idx]
  }
  x
}
