# file: mcescher.R
#
# provide some M.C. Escher images for in the examples of the conformal mappings.
# The images used are considered "free use" from wikiart.org

library(imager)
library(dplyr)
library(tidyr)

# Circle Limit I
CircleLimitI <- 
  imager::load.image(file = "data-raw/circle-limit-i-small.jpg") %>%
  as.data.frame  %>%
  dplyr::select(-cc) %>%
  dplyr::rename(pixel_x = x, pixel_y = y) %>%
  dplyr::mutate(x = (pixel_x - 105)/106, y = (pixel_y - 103) / 104) %>% 
  dplyr::filter(x^2 + y^2 < 1)

devtools::use_data(CircleLimitI, overwrite = TRUE) 
