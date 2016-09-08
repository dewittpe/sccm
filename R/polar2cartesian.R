#' Translate between Polar and Cartesian Coordinates.
#'
#' Given (x,y) return (r, theta), or visa-versa.
#'
#' @param x a numeric vector of x coordinates
#' @param y a numeric vector of y coordinates
#' 
#' @return A numeric matrix
#' 
#' @export
#' @rdname polar2cartesian
cartesian2polar <- function(x, y) { 
  .Call('sccm_cartesian2polar_cpp', PACKAGE = 'sccm', x, y)
}

#' @param r a numeric vector of radii
#' @param theta a numeric vector of angles (in radians)
#' @export
#' @rdname polar2cartesian
polar2cartesian <- function(r, theta) { 
  .Call('sccm_polar2cartesian_cpp', PACKAGE = 'sccm', r, theta)
}

