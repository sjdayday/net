context("Multicore processing")  # Identify the set of tests

require(multicore)

crunch_awhile <- function(x)
{
    # output not printed from slave processes 
    for(i in 1:1000)
	{
		sme <- matrix(rnorm(10000), 100,100)
		solve(sme)
	}
}
parallel_crunch <- function(t)
{
    #lapply(list(1,2), crunch_awhile)
    mclapply(list(1,2), crunch_awhile)
}
test_that("Slave processes are visible crunching; no expects done.  uncomment to run",
{
    #timestamp()
    #parallel_crunch(1000)
    #no expects done; don't know how to verify the slaves exist other than ps -ax
    #timestamp()
})
