context("Generation permutation 2")  # Identify the set of tests

source("generation_permutation_2.R")  # pull in pre-requisite source code, modified from generation_permutation_1.R

build_test_matrix <- function()  # build the test matrix to compare to 
{
 test_matrix <- matrix(c(0,0,0,0,0,0,0,0,0,0,0,0,0),nrow=13,ncol=13)
 colnames(test_matrix) <- c("Child 1", "Child 2", "Child 3", "Child 4", "Couple 5", "Couple 6", "Couple 7", "Couple 8", "Couple 9", "Andestor 10", "Couple 11", "Andestor 12", "Child 13")
 rownames(test_matrix) <- c("Child 1", "Child 2", "Child 3", "Child 4", "Couple 5", "Couple 6", "Couple 7", "Couple 8", "Couple 9", "Andestor 10", "Couple 11", "Andestor 12", "Child 13")
 test_matrix[,5] <- c(2,0,1,0,0,0,0,0,0,0,0,0,1)
 test_matrix[,6] <- c(0,2,0,1,0,0,0,0,0,0,0,0,0)
 test_matrix[,7] <- c(0,1,2,0,0,0,0,0,0,0,0,0,0)
 test_matrix[,8] <- c(1,0,0,2,0,0,0,0,0,0,0,0,0)
 test_matrix[,9] <- c(0,0,0,0,2,0,0,1,0,0,0,0,0)
 test_matrix[,10] <- c(0,0,0,0,0,2,1,0,0,0,0,0,0)
 test_matrix[,11] <- c(0,0,0,0,0,1,0,2,0,0,0,0,0)
 test_matrix[,12] <- c(0,0,0,0,1,0,2,0,0,0,0,0,0)

 return(test_matrix)
}
test_that("Returns 13X13 matrix permuted as expected from seed",
{

 set.seed(123456)  # seed will be used for all pseudo-random operations (e.g., permute), producing deterministic results
 matrix <- generation.permutation(n1,v1,v2)   # matrix is the object under test; its arguments were built by the prerequisite sourced code

 test_m <- build_test_matrix() # build the test matrix to compare to

 expect_that(matrix, is_equivalent_to(test_m))  # is equivalent to compares the matrix values, but will ignore differences in attributes

})

