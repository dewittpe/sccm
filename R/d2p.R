#' Disk to Polygon
#'
#' Map the data within the unit disk to a polygon via Schwarz-Christoffel
#' conformal mapping.
#'
#' @param .data the (x, y) corrdnates of the data within the unit disk.
#' @param pg the polygon to map the data to.
#' @param ... additional arguments passed to \code{scmap}
#'
#' @seealso \code{\link{scmap}} \code{\link{p2p}} \code{\link{p2d}}
#'
#' 
#' @return a \code{sccm_d2p} object, a list with the following elements:
#' \describe{
#' \item{mapped}{a n by 2 matrix with the (x, y) coordinates of the mapped data.}
#' \item{polygon}{The polygon the data was mapped into}
#' \item{data}{The original data}
#' \item{mapping}{the Schwarz-Christoffel mapping used.}
#' }
#' 
#' @export
d2p <- function(.data, pg = sccm::polygon(x = c(-1, 1, 1, -1), y = c(-1, -1, 1, 1)), ...) { 
  UseMethod("d2p")
}

#' @export
#' @method d2p data.frame
d2p.data.frame <- function(.data, pg = sccm::polygon(x = c(-1, 1, 1, -1), y = c(-1, -1, 1, 1)), ...) { 
  if (ncol(.data) != 2) { 
    stop("expecting a two column data.frame")
  }

  x <- as.vector(t(as.matrix(.data, ncol = 2)))
  npred <- nrow(.data)

  mapping <- scmap(pg, ...)

  disk <- .C("d2p_", 
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

  plygn <- matrix(disk$ww, byrow = TRUE, ncol = 2)

  out <- list(mapped = plygn, 
              polygon = pg, 
              data = .data,
              mapping = mapping)

  class(out) <- c("sccm_d2p", class(out))
  out 
}

#' @export
plot.sccm_d2p <- function(x, ...) { 

  par(mfrow = c(1, 2))

  plot(x$data, asp = 1, xlim = c(-1, 1), 
       main = "Original",
       xlab = "", ylab = "", 
       ...) 
  # draw the circle
  theta <- seq(0, 2 * pi, length = 200) 
  lines(x = cos(theta), y = sin(theta))

  plot(x$mapped, 
       asp = 1, 
       main = "Mapped",
       xlim = range(x$polygon$vertices[, 1]),
       ylim = range(x$polygon$vertices[, 2]),
       xlab = "", ylab = "", 
       ...)
  points(x$polygon$vertices, col = "red", pch = 3)
  lines(x$polygon$vertices[c(1:nrow(x$polygon$vertices), 1), ], col = "red", pch = 3) 
}
