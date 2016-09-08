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
#' @examples
#' set.seed(42)
#' n <- 2500L
#' dat <- data.frame(x = 1 + runif(n)) 
#' dat$y <- log(dat$x) + rnorm(n, sd = 0.2)
#' ch <- sccm::convex_hull(dat)
#' plot(ch)
#' 
#' trans <- sccm::p2p(dat)
#' plot(trans)
#' 
#' star <- 
#'    rbind(sccm::polar2cartesian(r = 1.0, theta = seq(0, 1.6, by = 0.4) * pi),
#'          sccm::polar2cartesian(r = 0.6, theta = seq(0.2, 1.8, by = 0.4) * pi))
#' star <- star[rep(1:5, each = 2) + rep(c(0, 5), times = 5), ]
#' 
#' trans <- sccm::p2p(dat, pg2 = sccm::polygon(star))
#' plot(trans)
#' 
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
  d2pmap <- d2p(.data = p2dmap$mapped, pg = pg2, ...)

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
p2p.matrix <- function(.data, 
                       pg1 = sccm::convex_hull(.data), 
                       pg2 = sccm::polygon(x = c(-1, 1, 1, -1), 
                                           y = c(-1, -1, 1, 1)),
                       ...) {

  p2dmap <- p2d(.data, pg = pg1, ...)
  d2pmap <- d2p(.data = p2dmap$mapped, pg = pg2, ...)


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
  graphics::par(mfrow = c(1, 3))
   
  # orig
  graphics::plot(x$data, 
                 main = "Original", 
                 xlab = "", ylab = "", 
                 ...)
  graphics::points(x$pg1$vertices, col = "red", pch = 3)
  graphics::lines(x$pg1$vertices[c(1:nrow(x$pg1$vertices), 1), ], col = "red", pch = 3)

  # the disk
  graphics::plot(x$disked, asp = 1, xlim = c(-1, 1), main = "Disk", xlab = "", ylab = "", ...)
  graphics::points(x$disked[x$pg1$indices, ], col = "red", pch = 3)

  # draw the circle
  theta <- seq(0, 2 * pi, length = 200) 
  graphics::lines(x = cos(theta), y = sin(theta))

  # the mapped
  graphics::plot(x$mapped, 
                 asp = 1, 
                 main = "Mapped",
                 xlim = range(x$pg2$vertices[, 1]),
                 ylim = range(x$pg2$vertices[, 2]),
                 xlab = "", ylab = "", 
                 ...)
  graphics::points(x$pg2$vertices, col = "red", pch = 3)
  graphics::lines(x$pg2$vertices[c(1:nrow(x$pg2$vertices), 1), ], col = "red", pch = 3) 

  graphics::par(mfrow = c(1, 1)) 
}
