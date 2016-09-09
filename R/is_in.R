#' Point in a Polygon
#'
#' Determine is a point (x, y) is inside, on an edge, or outside of a polygon.
#'
#' @param x x coordinate of the point.
#' @param y y coordinate of the point.
#' @param pg a \code{sccm_pg} or \code{sccm_ch} object
#' 
#' @return 
#' an integer with value of -1, 0, or 1.
#' \describe{
#' \item{-1}{(x, y) is on an edge of the polygon}
#' \item{0} {(x, y) is outside of the polygon}
#' \item{1} {(x, y) is inside of the polygon}
#' }
#'
#' @seealso \code{\link{polygon}} \code{link{convex_hull}}
#'
#' @export
is_in <- function(x, y, pg) { 
  is_in_cpp(x, y, pg$vertices)
}

