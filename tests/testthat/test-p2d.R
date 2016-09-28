test_that("p2d too many cols", 
          {
            expect_error(p2d(as.data.frame(mtcars)), "expecting a two column data.frame")
            expect_error(p2d(matrix(runif(99), ncol = 3)), "expecting a two column matrix")
            expect_error(p2d(matrix(runif(99), ncol = 1)), "expecting a two column matrix")
          })

test_that("p2d matrix", 
          {
            set.seed(42)
            dat <- matrix(runif(100), ncol = 2)
            # plot(convex_hull(dat))
            temp <- p2d(dat)

            # plot(temp)
            expect_equivalent(
                              temp$polygon$vertices,
                              structure(c(0.00394833879545331, 0.00733414688147604, 0.0374310328625143, 0.207658972823992, 0.390203467104584, 0.435771584976465, 0.836004259996116, 0.904031387297437, 0.988891728920862, 0.973539913771674, 0.719112251652405, 0.431751248892397, 0.117487361654639, 0.775823362637311, 0.233703398611397, 0.208569956943393, 0.0899805163498968, 0.00788473873399198, 0.000238896580412984, 0.00157055421732366, 0.0429887960199267, 0.21638541505672, 0.933034127345309, 0.982817197917029, 0.925644748611376, 0.828158485237509), .Dim = c(13L, 2L), .Dimnames = list(NULL, c("x", "y")))
                              )


          })
