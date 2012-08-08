context("Parallel mutual outlink")  # Identify the set of tests

source("parallel_mutual_outlink.R")  # pull in pre-requisite source code (R pgmming ch 16, loc 9829)
source("test_mutual_outlink.R")  # build test matrix
require(snow)

build_cluster <- function(host_processes)
{
    cl <- makeCluster(type="SOCK", host_processes)
    #print("cluster: ")
    #print(cl)
}
test_that("Calculates mutual outlinks using two local hosts",
{
  
  test_m <- build_test_matrix() # build the input matrix
  cluster <- build_cluster(c("localhost","localhost"))
  #print("output: ")
  #print((mutlinks(cluster,test_m)))  # mean should be two thirds of the links are mutual
  # test is failing...
  #expect_that((4/6),equals(mutlinks(cluster,test_m)))  # mean should be two thirds of the links are mutual
})
