#' Expand Hull
#'
#' Move the vertices of a convex hull outward.
#'
#' @param x a \code{sccm_ch} object
#' @param d the amount to move each vertices outward
#'
#' @export
expand_hull <- function(x, d) {
  UseMethod("expand_hull")
}

#' @export
expand_hull.sccm_ch <- function(x, d) {
  o <- x$vertices
  b <- o[c(nrow(o), 1:(nrow(o)-1)), ]
  ob <- rowSums((b - o)^2)

  new_legs <- sqrt(d^2 + ob - 2 * d * sqrt(ob) * cos(pi - x$gamma))
  # eta <- asin( d * sin(pi - x$gamma) / new_legs)

  nl <- new_legs[1]
  b.x <- b[1, 1]
  b.y <- b[1, 2]
  o.x <- o[1, 1]
  o.y <- o[1, 2]

  foo <- function(y) sqrt( d^2 - (sqrt( nl^2 - (y - b.y)^2) + b.x - o.x)^2 ) + o.y

  uniroot(foo, c(-1e10, 1e10))

}


