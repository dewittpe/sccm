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
#' @seealso \code{scmap}
#'
#' 
#' @return a list
#' 
#' @export
p2d <- function(.data, pg = sccm::convex_hull(.data), ...) {
  UseMethod("p2d")
}

#' @export
#' @method data.frame
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
             zz    = as.double(x),
             npred = as.integer(npred),
             ww    = double(2 * npred))

  disk <- matrix(disk$ww, byrow = TRUE, ncol = 2)

  out <- list(disk = disk,
              polygon = pg, 
              data = .data,
              mapping = mapping)

  class(out) <- c("sccm_p2d", class(out))
  out 
}

#' @export
plot.sccm_p2d <- function(x, ...) { 

  par(mfrow = c(1, 2))

  plot(x$data)
  points(x$polygon$hull, col = "red", pch = 3)
  lines(x$polygon$hull[c(1:nrow(x$polygon$hull), 1), ], col = "red", pch = 3)

  plot(x$disk, asp = 1, xlim = c(-1, 1))
  points(x$disk[x$polygon$indices, ], col = "red", pch = 3)

  # draw the circle
  theta <- seq(0, 2 * pi, length = 200) 
  lines(x = cos(theta), y = sin(theta))

}
