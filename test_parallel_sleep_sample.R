context("Parallel processes sleep sample; uncomment to run")  # Identify the set of tests

require(snow)

sleep_some <- function(num,x)
{
    # output not printed from slave processes 
    Sys.sleep(x)
}
parallel_sleep <- function(t)
{
    cl <- makeCluster(type="SOCK", c("localhost","localhost"))
    print("cluster: ")
    print(cl)
    clusterApply(cl,c(1,2),sleep_some,t)
}
test_that("Slave processes are visible sleeping; uncomment to run",
{
  #parallel_sleep(30)
})
