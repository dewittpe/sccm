test_that("is_anticlockwise", 
          {
            ch <- convex_hull(mtcars[, c("mpg", "wt")])
            star <- rbind(polar2cartesian(1.0, seq(0, 1.6, by = 0.4) * pi),
                          polar2cartesian(0.5, seq(0.2, 1.8, by = 0.4) * pi)) 
            star <- star[rep(1:5, each = 2) + rep(c(0, 5), times = 5), ]
            star_pg <- polygon(star)

            expect_true(is_anticlockwise(ch))
            expect_false(is_anticlockwise(polygon(c(-1, -1, 1, 1), c(-1, 1, 1, -1))))  # clockwise square
            expect_true(is_anticlockwise(polygon(c(-1, -1, 1, 1), c(1, -1, -1, 1))))  # anti-clockwise square
            expect_equal(is_anticlockwise(star_pg), logical(0))
            expect_warning(is_anticlockwise(star_pg), "Polygon is not a convex hull")
          })
