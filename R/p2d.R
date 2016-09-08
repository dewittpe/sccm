#' Polygon to Disk
#'
#' Map the data within a polygon to the unit disk via Schwarz-Christoffel
#' conformal mapping.
#'
#' @param .data the data set to map to the disk
#' @param pg the polygon containing the data, the default is the convex
#' hull about \code{.data}.
#' @param ... additional arguments passed to \code{scmap}
#'
#' @seealso \code{\link{scmap}} \code{\link{d2p}} \code{\link{p2p}}
#'
#' 
#' @return a \code{sccm_p2d} object, a list with the following elements:
#' \describe{
#' \item{mapped}{a n by 2 matrix with the (x, y) coordinates of the mapped data.}
#' \item{polygon}{The polygon the .data was contained in}
#' \item{data}{The original data}
#' \item{mapping}{the Schwarz-Christoffel mapping used.}
#' }
#' 
#' @export
p2d <- function(.data, pg = sccm::convex_hull(.data), ...) {
  UseMethod("p2d")
}

#' @export
#' @method p2d data.frame
p2d.data.frame <- function(.data, pg = sccm::convex_hull(.data), ...) { 
  if (ncol(.data) != 2) { 
    stop("expecting a two column data.frame")
  }

  x <- as.vector(t(as.matrix(.data, ncol = 2)))
  npred <- nrow(.data)

  mapping <- scmap(pg, ...)

  disk <- .C("p2d_", 
             n     = as.integer(mapping$n),
             c     = as.double(mapping$c),
             z     = as.double(mapping$z),
             wc    = as.double(mapping$wc),
             w     = as.double(mapping$w),
             betam = as.double(mapping$betam),
             nptsq = as.integer(mapping$nptsq),
             qwork = as.double(mapping$qwork),
             ww    = as.double(x),
             npred = as.integer(npred),
             zz    = double(2 * npred))

  disk <- matrix(disk$zz, byrow = TRUE, ncol = 2)

  out <- list(mapped = disk,
              polygon = pg, 
              data = .data,
              mapping = mapping)

  class(out) <- c("sccm_p2d", class(out))
  out 
}

#' @export
p2d.matrix <- function(.data, pg = sccm::convex_hull(.data), ...) { 
  if (ncol(.data) != 2) { 
    stop("expecting a two column matrix")
  }

  x <- as.vector(t(.data))
  npred <- nrow(.data)

  mapping <- scmap(pg, ...)

  disk <- .C("p2d_", 
             n     = as.integer(mapping$n),
             c     = as.double(mapping$c),
             z     = as.double(mapping$z),
             wc    = as.double(mapping$wc),
             w     = as.double(mapping$w),
             betam = as.double(mapping$betam),
             nptsq = as.integer(mapping$nptsq),
             qwork = as.double(mapping$qwork),
             ww    = as.double(x),
             npred = as.integer(npred),
             zz    = double(2 * npred))

  disk <- matrix(disk$zz, byrow = TRUE, ncol = 2)

  out <- list(mapped = disk,
              polygon = pg, 
              data = .data,
              mapping = mapping)

  class(out) <- c("sccm_p2d", class(out))
  out 
}

#' @export
plot.sccm_p2d <- function(x, ...) { 

  graphics::par(mfrow = c(1, 2))

  graphics::plot(x$data)
  graphics::points(x$polygon$hull, col = "red", pch = 3)
  graphics::lines(x$polygon$hull[c(1:nrow(x$polygon$hull), 1), ], col = "red", pch = 3)

  graphics::plot(x$disk, asp = 1, xlim = c(-1, 1))
  graphics::points(x$disk[x$polygon$indices, ], col = "red", pch = 3)

  # draw the circle
  theta <- seq(0, 2 * pi, length = 200) 
  graphics::lines(x = cos(theta), y = sin(theta))

}
