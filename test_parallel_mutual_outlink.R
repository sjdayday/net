context("Parallel mutual outlink")  # Identify the set of tests

#source("parallel_mutual_outlink.R")  # pull in pre-requisite source code (R pgmming ch 16, loc 9829)
source("test_mutual_outlink.R")  # pull in pre-requisite source code 
require(snow)

sleep_some <- function(num,x)
{
    # output not printed from slave processes 
    Sys.sleep(x)
}
cluster <- function(hosts, processes_per_host)
{
    cl <- makeCluster(type="SOCK", c("localhost","localhost"))
    print("cluster: ")
    print(cl)
    clusterApply(cl,c(1,2),sleep_some,30)
}
test_that("Calculates mutual outlinks using two local hosts",
{
 #cluster(c(1), 2)
 #test_m <- build_test_matrix() # build the input matrixd

 #expect_that(4,equals(mtl(c(1,2,3),test_m)))  # compare each of 1st 3 rows to remaining rows of the input matrix.
})
