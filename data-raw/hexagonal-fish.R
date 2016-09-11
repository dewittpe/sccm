library(imager)
library(dplyr)
library(tidyr)
# library(sccm)
devtools::load_all("~/dissertation/sccm")

HexagonalFish <- 
  imager::load.image(file = "data-raw/hexagonal-fish.jpg") %>%
  as.data.frame  %>%
  dplyr::select(-cc) %>%
  dplyr::group_by(x, y) %>%
  dplyr::summarize(value = mean(value)) %>%
  dplyr::ungroup()

# plot(HexagonalFish[, 1:2], col = cut(HexagonalFish$value, breaks = 2))
bndry <- 
  rbind(
        c(28, 116),   # bottom left
        c(198, 16),   # bottom center
        c(366, 115),  # bottom right
        c(370, 309),  # top right
        c(201, 408),  # top center
        c(28, 313)    # top left 
        ) 
# points(bndry, pch = 16, col = 'blue')
bndry_pg <- sccm::polygon(bndry)
is_convex_hull(bndry_pg)
is_anticlockwise(bndry_pg)

### # Remove points outside of the bndry_pg
HexagonalFish <-
  dplyr::bind_rows(
                   dplyr::filter(HexagonalFish, is_in(x, y, bndry_pg) == 1) %>% dplyr::filter(x > 27),
                   dplyr::filter(HexagonalFish, x %in% bndry[1, 1],  y %in% bndry[1, 2]),
                   dplyr::filter(HexagonalFish, x %in% bndry[2, 1],  y %in% bndry[2, 2]),
                   dplyr::filter(HexagonalFish, x %in% bndry[3, 1],  y %in% bndry[3, 2]),
                   dplyr::filter(HexagonalFish, x %in% bndry[4, 1],  y %in% bndry[4, 2]),
                   dplyr::filter(HexagonalFish, x %in% bndry[5, 1],  y %in% bndry[5, 2]),
                   dplyr::filter(HexagonalFish, x %in% bndry[6, 1],  y %in% bndry[6, 2]))

ch <- convex_hull(HexagonalFish)
plot(ch, pch = ".", col = cut(HexagonalFish$value, breaks = 2))
points(bndry, pch = 16, col = 'blue')

class(HexagonalFish) <- "data.frame"

devtools::use_data(HexagonalFish, overwrite = TRUE) 
