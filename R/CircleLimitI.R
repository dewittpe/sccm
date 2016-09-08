#' Circle Limit I by Mc Esher
#'
#' A dataset containing (x, y) coordinates (pixels) and shading level for
#' MC Escher's Circle Limit I
#'
#' @format A data frame
#' \describe{
#'   \item{pixel_x}{x coordinate}
#'   \item{pixel_y}{y coordinate}
#'   \item{value}{shading value}
#'   \item{x}{x coordinate scaled for the unit disk}
#'   \item{y}{y coordinate scaled for the unit disk}
#' }
#' @source \url{http://uploads4.wikiart.org/images/m-c-escher/circle-limit-i.jpg!PinterestSmall.jpg}
#'
#' @examples
#' data("CircleLimitI", package = "sccm")
#' summary(CircleLimitI)
#' 
#' \dontrun{
#' ggplot2::ggplot(CircleLimitI) + 
#' ggplot2::aes(x = x, y = y, fill = value) + 
#' ggplot2::geom_tile() + 
#' ggplot2::theme_bw() + 
#' ggplot2::theme(legend.position = "none") + 
#' ggplot2::coord_equal(ratio = 1)
#' }
#' 
"CircleLimitI"
