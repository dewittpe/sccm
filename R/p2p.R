#' Polygon to Polygon
#'
#' Map the data within a polygon to another polygon  via Schwarz-Christoffel
#' conformal mapping.
#'
#' @param .data the data set to map 
#' @param pg1 the polygon containing the \code{.data}
#' @param pg2 the polygon to map \code{.data} to.
#' @param ... additional arguments passed to \code{scmap}
#'
#' @seealso \code{scmap}
#'
#' 
#' @return a list
#' 
#' @export
p2p <- function(.data, pg = sccm::convex_hull(.data), ...) {
  UseMethod("p2p")
}

#' @export
p2p.data.frame <- function(.data, 
                           pg1 = sccm::convex_hull(.data), 
                           pg2 = sccm::polygon(x = c(-1, 1, 1, -1), 
                                               y = c(-1, -1, 1, 1)),
                           ...) {

  p2dmap <- p2d(.data, pg = pg1, ...)
  d2pmap <- d2p(.data = as.data.frame(p2dmap$disk), pg = pg2, ...)


  out <- list(p2dmap = p2dmap, d2pmap = d2pmap)

  class(out) <- c("sccm_p2p", class(out))
  out 
}

#' @export
plot.sccm_p2p <- function(x, ...) { 
  stop("to do") 
}
