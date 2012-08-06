context("Mutual outlink")  # Identify the set of tests

source("mutual_outlink.R")  # pull in pre-requisite source code (R pgmming ch 16, loc 9829)

build_test_matrix <- function()  # build the test matrix to compare to 
{
 m <- matrix(nrow=4,ncol=4) # adjacency matrix 
 m[1,] = c(0,1,0,1)  # 1 shares link w 2 to 4; shares link w 3 & 4 to 2 = 3
 m[2,] = c(0,0,0,1)  # shares link w 1 to 4; already counted = 0
 m[3,] = c(1,1,0,0)  # shares link w 4 to 2; shared link w 1 to 2 already counted = 1
 m[4,] = c(0,1,0,0)  # shares link w 1 & 3 to 2; already counted = 0
 m
}
test_that("Calculates number of mutual outlinks from each of first 3 rows of adjacency matrix and all 3 together",
{
 test_m <- build_test_matrix() # build the input matrix

 expect_that(3,equals(mtl(c(1),test_m)))  # compare each of 1st 3 rows to remaining rows of the input matrix.
 expect_that(0,equals(mtl(c(2),test_m)))  # compare each of 1st 3 rows to remaining rows of the input matrix.
 expect_that(1,equals(mtl(c(3),test_m)))  # compare each of 1st 3 rows to remaining rows of the input matrix.
 expect_that(4,equals(mtl(c(1,2,3),test_m)))  # compare each of 1st 3 rows to remaining rows of the input matrix.
 expect_error(mtl(c(4),test_m),"subscript out of bounds")  #  
})
