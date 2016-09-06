#' Schwarz-Christoffel Mapping (Disk to Polygon)
#'
#' Generates the Schwarz-Christoffel mapping from the unit disk to the provided
#' 2D polygon.
#'
#' @param x \code{sccm_ch} or \code{sccm_pg}, object.
#' @param wc the center of the polygon, i.e., where the origin will be mapped
#' to.  The default is c(mean(x), mean(y))
#' @param nptsq the number of points per subinterval used in Gauss-Jacobi
#' quadrature.
#' 
#' @return an object
#'
#' 
#' @export
scmap <- function(x, wc, nptsq = 12) { 
  UseMethod("scmap")
}

#' @export
scmap.sccm_ch <- function(x, wc = colMeans(x$hull), nptsq = 12) { 
  n <- nrow(x$hull) # number of vertices
  w <- as.vector(t(x$hull)) # vertices as a vector (x1, y1, x2, y2, ...)

  .C("scmap_",
     n      = as.integer(n),
     w      = as.double(w),
     wc     = as.double(wc),
     betam  = as.double(-x$beta / pi),
     nptsq  = as.integer(nptsq),
     tol    = double(1),
     errest = double(1),
     c      = double(2),
     z      = double(2 * n),
     qwork  = double(nptsq * (2 * n + 3)))
}

#' @export
scmap.sccm_pg <- function(x, wc = colMeans(x$polygon), nptsq = 12) { 
  n <- nrow(x$polygon) # number of vertices
  w <- as.vector(t(x$polygon)) # vertices as a vector (x1, y1, x2, y2, ...)

  .C("scmap_",
     n      = as.integer(n),
     w      = as.double(w),
     wc     = as.double(wc),
     betam  = as.double(-x$beta / pi),
     nptsq  = as.integer(nptsq),
     tol    = double(1),
     errest = double(1),
     c      = double(2),
     z      = double(2 * n),
     qwork  = double(nptsq * (2 * n + 3)))
}

