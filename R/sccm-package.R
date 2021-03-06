#' @title sccm: Schwarz-Christoffel Conformal Maps
#'
#' @description 
#' 
#' Provide a conformal mapping of one 2D polygon to a rectangular region via the
#' Schwarz-Christoffel theorem.
#' 
#' Methods are provide to find a convex hull for an arbitrary set (x, y)
#' coordinates.  This hull, and the points within, are, via an (inverse)
#' Schwarz-Christoffel mapping, mapped to the unit disk.  A second
#' Schwarz-Christoffel mapping from the unit disk to an arbitrary rectangle is use
#' to finish the conformal mapping.
#' 
#' This package builds hulls via Andrew's monotone chain algorithm implemented in
#' C++. The Schwarz-Christoffel mappings are provided by the FORTRAN SCPACK by
#' Lloyd N. Trefethen.
#'
#' @section Acknowledgments:
#' This package is based on the work of two other packages:
#' \code{contoureR} by Nicholas Hamilton and 
#' \code{conformal} by Nick Ellis.  The former provided insight on
#' construction of the convex hulls, the later provided the insight into the
#' FORTRAN interface.  The \code{sccm} package provides a subset of the tools
#' provided by these two packages, and does so with a different API.
#'
#' @references
#' SCPACK: \url{http://www.netlib.org/conformal/}
#'
#' contoureR: \url{https://cran.r-project.org/web/packages/contoureR/index.html}
#'
#' conformal: \url{https://r-forge.r-project.org/R/?group_id=973}
#' 
#' Trefethen, Lloyd N. "Analysis and design of polygonal resistors by conformal mapping." Zeitschrift für angewandte Mathematik und Physik ZAMP 35.5 (1984): 692-704.
#'
#'
#' @author
#' Peter DeWitt
#'
#' @useDynLib sccm
#' @importFrom Rcpp sourceCpp
#' @importFrom graphics plot lines
#'
#' @docType package
#' @name sccm-package
NULL
