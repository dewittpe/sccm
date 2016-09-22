test_that("cartesian2polar: ", 
          {
            expect_equal(cartesian2polar(0.5, sqrt(3)/2), matrix(c(1, pi/3), nrow = 1)) 

            expect_equal(cartesian2polar(0.5, c(sqrt(3)/2, -sqrt(3)/2)), 
                         matrix(c(1, 1, pi/3, -pi/3), nrow = 2)) 

            expect_equal(cartesian2polar(c(-0.5, 0.5), sqrt(3)/2), 
                         matrix(c(1, 1, 2*pi/3, pi/3), nrow = 2)) 

            expect_error(cartesian2polar(1:2, 1:3))

          })


test_that("polar2cartesian: ",
          {
            expect_equal(polar2cartesian(1, pi/3),
                         matrix(c(0.5, sqrt(3)/2), nrow = 1)) 

            expect_equal(polar2cartesian(1, c(pi/3, -pi/3)), 
                         matrix(c(0.5, 0.5, sqrt(3)/2, -sqrt(3)/2), nrow = 2)) 

            expect_equal(polar2cartesian(c(1, 2), pi/3),
                         matrix(c(0.5, 1.0, sqrt(3)/2, sqrt(3)), nrow = 2))

            expect_error(polar2cartesian(1:2, 1:3))
          })


