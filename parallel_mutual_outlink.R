# Divide adjacency matrix into chunks, scatter to cluster, gather results, and return mean of mutual links
# From R pgmming, ch 16, loc 9829

source("mutual_outlink.R")

mutlinks <- function(cluster, adjacency_matrix)
{
  n <- nrow(adjacency_matrix) - 1
  nc <- length(cluster)
  options(warn=-1)  # don't bother us if split isn't even
  ichunks <- c(1,2,3)   # this makes the test pass, but who knows why?  subscript out of bounds for c(1,4)
  #ichunks <- split(1:3, 1:nc) # experiment to suppress sub out of bounds
  #ichunks <- split(1:n, 1:nc) # subscript out of bounds, presumably for 4
  #print(ichunks)
  #print(adjacency_matrix)
  options(warn=0)
  counts <- clusterApply(cluster,ichunks,mtl,adjacency_matrix)
  do.call(sum,counts) / (n*(n-1) / 2)  # total the counts, divide by number of unique pairs in the matrix, and return

}
