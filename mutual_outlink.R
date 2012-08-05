# Calculate the number of mutual outlinks in an adjacency matrix:
# 1 if link from this vertex (row) to target vertex (col); 0 if not 
# From R pgmming, ch 16, loc 9829

mtl <- function(ichunks, adjacency_matrix)
{
   # ichunks is a vector of the row numbers to be evaluated; if length(ichunks) < nrow(m)
   # mtl can participate in parallel processing.  
   n <- ncol(adjacency_matrix)
   matches <- 0
   for (i in ichunks)
   {
      if (i < n)
      rowi = adjacency_matrix[i,]
      {
	matches <- matches + sum(adjacency_matrix[(i+1):n,] %*% rowi) # multiple matrix of subset of rows * vector of the row being evaluated.
      }
   }
   return(matches)
}
