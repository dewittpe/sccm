#' Testing for anti-clockwise ordering of points of a convex hull.
#'
#' Given a polygon, test if the polygon is a convex hull and if it is, if the
#' vertices are listed in an anti-clockwise order.
#'
#' @seealso \code{\link{polygon}} \code{\link{convex_hull}}
#' \code{\link{is_convex_hull}}
#'
#' @param x \code{sccm_pg} object.
#'
#' @examples
#' square1 <- polygon(c(-1, 1, 1, -1), c(-1, -1, 1, 1))
#' square2 <- polygon(c(1, 1, -1, -1), c(-1, 1, 1, -1))
#' square3 <- polygon(c(-1, 1, 1, -1), c(1, 1, -1, -1))
#' 
#' is_anticlockwise(square1)
#' is_anticlockwise(square2)
#' is_anticlockwise(square3)
#' 
#' @export
is_anticlockwise <- function(x) { 
  UseMethod("is_anticlockwise")
}

#' @export
is_anticlockwise.sccm_ch <- function(x) { 
  # by construction of sccm_ch objects
  TRUE
}

#' @export
is_anticlockwise.sccm_pg <- function(x) { 

  if (!is_convex_hull(x)) { 
    warning("Polygon is not a convex hull")
    return(logical(0))
  } else {
    return(all(x$beta > 0))
  } 
}
