# function that takes the size of the matrix and return all the upper triangle vertex pairs
upTriangle <- function(n){

	upTringList <- list()
	k <- 0

	for(i in 1:(n - 1)){
 		for (j in (i+1):n){
#	print(i)
#	print(j)
		k <- k + 1
		upTringList[[k]] <- c(i,j)
		}
	}

	upTringList	

}
