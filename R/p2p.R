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
#' @seealso \code{\link{scmap}} \code{\link{d2p}} \code{\link{p2d}}
#' 
#' @return a \code{sccm_p2d} object, a list with the following elements:
#' \describe{
#' \item{mapped}{a n by 2 matrix with the (x, y) coordinates of the mapped data
#' in the target polygon.}
#' \item{disked}{a n by 2 matrix with the (x, y) coordinates of the mapped data
#' in the unit disk.}
#' \item{data}{The original data}
#' \item{pg1}{The polygon the .data was contained in}
#' \item{pg2}{The polygon the .data was mapped into}
#' \item{p2d}{the Schwarz-Christoffel mapping between the unit disk and polygon1.}
#' \item{d2p}{the Schwarz-Christoffel mapping between the unit disk and polygon2.}
#' }
#' 
#' @export
p2p <- function(.data, 
                pg1 = sccm::convex_hull(.data), 
                pg2 = sccm::polygon(x = c(-1, 1, 1, -1), 
                                    y = c(-1, -1, 1, 1)),
                ...) {
  UseMethod("p2p")
}

#' @export
#' @method p2p data.frame
p2p.data.frame <- function(.data, 
                           pg1 = sccm::convex_hull(.data), 
                           pg2 = sccm::polygon(x = c(-1, 1, 1, -1), 
                                               y = c(-1, -1, 1, 1)),
                           ...) {

  p2dmap <- p2d(.data, pg = pg1, ...)
  d2pmap <- d2p(.data = as.data.frame(p2dmap$disk), pg = pg2, ...)


  out <- list(mapped = d2pmap$mapped, 
              disked = p2dmap$mapped,
              data   = .data,
              pg1    = pg1,
              pg2    = pg2,
              p2d    = p2dmap$mapping,
              d2p    = d2pmap$mapping)

  class(out) <- c("sccm_p2p", class(out))
  out 
}

#' @export
plot.sccm_p2p <- function(x, ...) { 
  stop("to do") 
}
