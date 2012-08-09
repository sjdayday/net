library(foreach) 
library(doMC) 
nWorkers = 16
registerDoMC(nWorkers) 
getDoParWorkers() 
check <-function(n) { 
 for(i in 1:100) { 
  sme <- matrix(rnorm(160000), 400,400) 
  solve(sme) 
 } 
} 
times <- 2000  
system.time(x <- foreach(j=1:times ) %dopar% check(j))
