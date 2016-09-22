test_that("Points are in, out, on", 
          {
            star <- rbind(polar2cartesian(1.0, seq(0, 1.6, by = 0.4) * pi),
                          polar2cartesian(0.5, seq(0.2, 1.8, by = 0.4) * pi)) 
            star <- star[rep(1:5, each = 2) + rep(c(0, 5), times = 5), ]
            star_pg <- polygon(star)

            xx <- 0.75
            yy <- (diff(star_pg$vertices[1:2, 2]) / diff(star_pg$vertices[1:2, 1])) * (xx - star_pg$vertices[1, 1]) + star_pg$vertices[1, 2]

            expect_equivalent(as.integer(is_in(-0.4, 0.1, star_pg)), 1) # inside
            expect_equivalent(as.integer(is_in(0.5, -0.6, star_pg)), 0) # outside
            expect_equivalent(as.integer(is_in(xx, yy, star_pg)), -1)   # on an edge

            xcoords <- c(-0.4, 0.5, xx)
            ycoords <- c(0.1, -0.6, yy)

            expect_equal(summary(is_in(xcoords, ycoords, star_pg)),
                         structure(list(x = c(-0.4, 0.5, 0.75), y = c(0.1, -0.6, 0.123382376053299), is_in = structure(c(1L, 0L, -1L), x = c(-0.4, 0.5, 0.75), y = structure(c(0.1, -0.6, 0.123382376053299), .Names = c("", "", "x")), class = c("sccm_is_in", "integer")), label = c("Inside", "Outside", "On an Edge")), .Names = c("x", "y", "is_in", "label"), row.names = c(NA, -3L), class = "data.frame")
                         )

          })

