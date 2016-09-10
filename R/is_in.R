#' Point in a Polygon
#'
#' Determine is a point (x, y) is inside, on an edge, or outside of a polygon.
#'
#' @param x x coordinate of the point.
#' @param y y coordinate of the point.
#' @param pg a \code{sccm_pg} or \code{sccm_ch} object
#'
#' @return
#' an integer with value of -1, 0, or 1.
#' \describe{
#' \item{-1}{(x, y) is on an edge of the polygon}
#' \item{0}{(x, y) is outside of the polygon}
#' \item{1}{(x, y) is inside of the polygon}
#' }
#'
#' @seealso \code{\link{polygon}} \code{link{convex_hull}}
#'
#' @examples
#'
#' xvert <- c(0, 5, 6, 4, 2, 0)
#' yvert <- c(0, 0, 1, 3, 3, 2)
#'
#' pg <- polygon(xvert, yvert)
#' plot(pg)
#'
#' points_to_test <-
#'   rbind(c(x = 0,   y = 1.1),
#'         c(x = 0.7, y = 2.1),
#'         c(x = 0.5, y = 2.8),
#'         c(x = 3.2, y = 1.2),
#'         c(x = 0.2, y = 0.01),
#'         c(x = 1,   y = 2.5),
#'         c(x = 5.5, y = 0.3),
#'         c(x = 4.5, y = 2.5),
#'         c(x = pi,  y = pi/3))
#'
#' is_in(0, 1.1, pg)
#' is_in(3.2, 1.1, pg)
#'
#' test_results <-
#'   is_in(points_to_test[, 1],
#'         points_to_test[, 2],
#'         pg)
#'
#' test_results
#'
#' summary(test_results)
#'
#' points(points_to_test,
#'        col = factor(summary(test_results)$label),
#'        pch = 16)
#' text(points_to_test, pos = 4)
#'
#' @export
is_in <- function(x, y, pg) {
  out <-
    mapply(is_in_cpp,
           x = x,
           y = y,
           MoreArgs = list(v = pg$vertices),
           SIMPLIFY = FALSE)
  out <- do.call(c, out)

  attr(out, "x") <- x
  attr(out, "y") <- y
  class(out) <- c("sccm_is_in", class(out))

  out
}

#' @export
print.sccm_is_in <- function(x, ...) {
  attributes(x) <- NULL
  print(x)
}

#' @export
summary.sccm_is_in <- function(object, ...) {
  data.frame(x = attr(object, "x"),
             y = attr(object, "y"),
             is_in = object,
             label = as.character(factor(object,
                                         levels = c(-1, 0, 1),
                                         labels = c("On an Edge",
                                                    "Outside",
                                                    "Inside"))))

}
