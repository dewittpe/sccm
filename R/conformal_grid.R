#' Conformal Grid
#'
#' Given a polygon, find the orthogonal grid from a square projected into the
#' polygon.
#'
#' Given a orthogonal grid in (u, v) space, \code{conformal_grid} finds and
#' allows one to plot the mapped grid into the polygon in (x, y) space.  The (u,
#' v) space is a square with vertices at (-1, -1), (1, -1), (1, 1), and (-1, 1).
#'
#' @param x a \code{sccm_pg} or \code{sccm_ch} object
#' @param ubreaks,vbreaks Either an integer value or numeric vector for the
#' location of the grid lines.  If an integer value is given,
#' then the dimension will have equidistant grid lines.  Else, specify specific
#' values in the u and/or v space between -1, and 1.
#' @param n number of data points to use on each margin of the grid.
#'
#' @export
conformal_grid <- function(x, ubreaks = 7, vbreaks = 7, n = 100) {
  UseMethod("conformal_grid")
}

#' @export
conformal_grid.sccm_pg <- function(x, ubreaks = 7, vbreaks = 7, n = 100) {
  if (length(ubreaks) > 1) {
    ubrksok <- all(ubreaks > -1 & ubreaks < 1)
  } else { 
    ubrksok <- ubreaks > 0
    ubreaks <- -1 + 2 * seq(1, ubreaks, by = 1) / (ubreaks + 1)
  }

  if (length(vbreaks) > 1) {
    vbrksok <- all(vbreaks > -1 & vbreaks < 1)
  } else { 
    vbrksok <- vbreaks > 0
    vbreaks <- -1 + 2 * seq(1, vbreaks, by = 1) / (vbreaks + 1)
  }

  if (!all(c(ubrksok, vbrksok))) {
    stop("ubreaks or vbreaks are nonsensical.")
  }

  .data <- rbind(dplyr::mutate_(expand.grid(u = ubreaks,
                                           v = seq(-0.999, 0.999, length = n)),
                                .dots = list("grp" ~ paste("u", u))),
                 dplyr::mutate_(expand.grid(u = seq(-0.999, 0.999, length = n),
                                           v = vbreaks),
                               .dots = list("grp" ~ paste("v", v))))

  mapping <- p2p(.data[, 1:2],
                 pg1 = polygon(c(-1, 1, 1, -1), c(-1, -1, 1, 1)),
                 pg2 = x) 

  plotting_data <-
    dplyr::mutate(.data,
                  x = mapping$mapped[, 1],
                  y = mapping$mapped[, 2],
                  dx = mapping$disked[, 1],
                  dy = mapping$disked[, 2])
  out <- list(mapping = mapping, plotting_data = plotting_data)


  class(out) <- c("sccm_cg", class(out))
  out
}

#' @export
plot.sccm_cg <- function(x, ...) { 
  plot(x$mapping$pg2, ...)
  for (grp in unique(x$plotting_data$grp)) {
    lines(x$plotting_data$x[x$plotting_data$grp == grp], x$plotting_data$y[x$plotting_data$grp == grp])
  }
}
