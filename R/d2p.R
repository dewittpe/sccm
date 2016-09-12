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
#' @examples
#' 
#' # Examples using MC Escher's Circle Limit I
#' data("CircleLimitI", package = "sccm")
#' 
#' # map to a square
#' mce <- sccm::d2p(CircleLimitI[, c("x", "y")])
#' plot(mce, col = cut(CircleLimitI$value, breaks = 2), pch = ".", cex = 3)
#' 
#' # map to a star
#' star <- 
#'   rbind(sccm::polar2cartesian(r = 1.0, theta = seq(0, 1.6, by = 0.4) * pi),
#'         sccm::polar2cartesian(r = 0.6, theta = seq(0.2, 1.8, by = 0.4) * pi))
#' star <- star[rep(1:5, each = 2) + rep(c(0, 5), times = 5), ]
#' 
#' mce_star <- 
#'   sccm::d2p(
#'             CircleLimitI[, c("x", "y")],
#'             pg = sccm::polygon(star[, 1:2]),
#'             wc = c(0, 0)
#'             )
#' plot(mce_star, col = cut(CircleLimitI$value, breaks = 2), pch = 16)
#' 
#' # Examples based on a color disk
#' color_disk <- 
#'   Reduce(rbind,
#'     c(
#'       mapply(function(r, theta) {cbind(sccm::polar2cartesian(r, theta), r)},
#'            r = seq(0.1, 0.9, by = 0.1), 
#'            MoreArgs = list(theta = seq(0, 2 * pi, length = 100L)),
#'            SIMPLIFY = FALSE),
#'       mapply(function(r, theta) {cbind(sccm::polar2cartesian(r, theta), r)},
#'              theta = seq(0, 2, by = 0.25) * pi,
#'              MoreArgs = list(r = seq(0, 0.99, length = 20L)),
#'              SIMPLIFY = FALSE)
#'       ))
#' 
#' color_disk_squared <- sccm::d2p(color_disk[, 1:2])
#' plot(color_disk_squared, col = cut(color_disk[, 3], breaks = 6))
#' 
#' color_disk_squared <- sccm::d2p(color_disk[, 1:2],
#'                                 pg = sccm::polygon(star))
#' plot(color_disk_squared, col = cut(color_disk[, 3], breaks = 6))
#' 
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
d2p.matrix <- function(.data, pg = sccm::polygon(x = c(-1, 1, 1, -1), y = c(-1, -1, 1, 1)), ...) { 
  if (ncol(.data) != 2) { 
    stop("expecting a two column matrix")
  }

  x <- as.vector(t(.data))
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

  graphics::par(mfrow = c(1, 2))

  graphics::plot(x$data, asp = 1, xlim = c(-1, 1), 
                 main = "Original",
                 xlab = "", ylab = "", 
                 asp = 1,
                 ...) 
  # draw the circle
  theta <- seq(0, 2 * pi, length = 200) 
  graphics::lines(x = cos(theta), y = sin(theta))

  graphics::plot(x$mapped, 
                 asp = 1, 
                 main = "Mapped",
                 xlim = range(x$polygon$vertices[, 1]),
                 ylim = range(x$polygon$vertices[, 2]),
                 xlab = "", ylab = "", 
                 ...)
  graphics::points(x$polygon$vertices, col = "red", pch = 3)
  graphics::lines(x$polygon$vertices[c(1:nrow(x$polygon$vertices), 1), ], col = "red", pch = 3) 

  graphics::par(mfrow = c(1, 1)) 
}
