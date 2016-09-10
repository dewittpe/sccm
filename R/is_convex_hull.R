#' Is Convex Hull
#'
#' Test if a given set of vertices construct a convex hull.
#'
#' @seealso \code{\link{polygon}} \code{\link{convex_hull}}
#' \code{\link{is_anticlockwise}}
#'
#' @param x \code{sccm_pg} object.
#'
#' @examples
#' xvert <- c(0, 5, 6, 4, 2, 0)
#' yvert <- c(0, 0, 1, 3, 3, 2)
#' 
#' pg <- polygon(xvert, yvert)
#' is_convex_hull(pg)
#' 
#' # reverse the order of the vertices, still an convex hull.
#' is_convex_hull(polygon(pg$vertices[rev(1:nrow(pg$vertices)), ] ))
#' 
#' # order of the vertices is important
#' is_convex_hull(polygon(pg$vertices[c(2, 3, 1, 6, 4, 5), ] ))
#' 
#' star <- 
#'    rbind(sccm::polar2cartesian(r = 1.0, theta = seq(0, 1.6, by = 0.4) * pi),
#'          sccm::polar2cartesian(r = 0.6, theta = seq(0.2, 1.8, by = 0.4) * pi))
#' 
#' is_convex_hull(polygon(star))
#' 
#' @export
is_convex_hull <- function(x) { 
  UseMethod("is_convex_hull")
}

#' @export
is_convex_hull.sccm_pg <- function(x) { 
  ch <- convex_hull(x$vertices)

  if (length(x$beta) != length(ch$beta)) {
    return(FALSE)
  } else { 
    return (isTRUE(all.equal(sort(abs(x$beta)), sort(abs(ch$beta)))));
  } 
}

