library(imager)
library(dplyr)
library(tidyr)

HexagonalFish <- 
  imager::load.image(file = "data-raw/hexagonal-fish.jpg") %>%
  as.data.frame  %>%
  dplyr::select(-cc) %>%
  dplyr::rename(pixel_x = x, pixel_y = y) %>%
  dplyr::filter(value < 0.75) %>%
  dplyr::select(-value)

devtools::use_data(HexagonalFish, overwrite = TRUE) 
