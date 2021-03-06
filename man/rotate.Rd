% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/rotate.R
\name{rotate}
\alias{rotate}
\title{Rotate}
\usage{
rotate(x, times = 1L)
}
\arguments{
\item{x}{a \code{sccm_ch} or \code{sccm_pg} object}

\item{times}{(integer, default = 1), number vertices to rotate through}
}
\description{
Rotate a polygon or convex hull.
}
\details{
The default call to \code{rotate} simply moves the first vertex to the last
row of the vertex matrix and moves all the other rows up one, i.e.,

\code{x$vertices <- x$vertices[c(2:nrow(x$vertices), 1), ]}.

For \code{times > 1L}, the above code line is evaluated \code{times} times.

The \code{vertices} and \code{beta} elements of \code{sccm_pg} objects are
updated.  \code{sccm_ch} objects have \code{vertices}, \code{beta}, and
\code{index} updated.
}
