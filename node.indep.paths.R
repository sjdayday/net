##Node Independent Paths Newman's Technique
# SJD renamed to .R from .r

library(network)
library(sna)

vertex.indep <- function(adj.mat,v1,v2){     ###V2 MUST BE GREATER THAN V1!!!!!!!
  n <- dim(adj.mat)[1]
 # copy to new matrix, dropping the columns for the two vertices
  adj.mat.reduced <- subset(adj.mat, select=c(-v1,-v2)) 
 # create a zero'ed matrix, with the same number of rows but double the number of columns 
  mat.zeros <- matrix(0, dim(adj.mat.reduced)[1], dim(adj.mat.reduced)[2]*2) 

  for(i in 1:dim(adj.mat.reduced)[2]){
   mat.zeros[,((2*i)-1)] <- adj.mat.reduced[,i]
  }
  mat.zeros <- insertCol(mat.zeros,((2*v1)-1),adj.mat[,v1])
  mat.zeros <- insertCol(mat.zeros,((2*v2)-2),adj.mat[,v2])

  col.ok <-t(mat.zeros)
  adj.mat.reduced2 <- subset(col.ok, select=c(-v1,-v2))
  mat.zeros2 <- matrix(0, dim(adj.mat.reduced2)[1], dim(adj.mat.reduced2)[2]*2)
  for(i in 1:dim(adj.mat.reduced2)[2]){
    mat.zeros2[,2*i] <- adj.mat.reduced2[,i]
  }
  mat.zeros2 <- insertCol(mat.zeros2,((2*v1)-1),col.ok[,v1])
  mat.zeros2 <- insertCol(mat.zeros2,((2*v2)-2),col.ok[,v2])
  final.matrix <- t(mat.zeros2)
  for (i in setdiff(c(1:n),c(v1,v2))){
    if (i < v1)
      final.matrix[(2*i)-1, 2*i] <-1
    if ((i > v1) & (i < v2))
      final.matrix[(2*i)-2, (2*i)-1] <-1
    if (i > v2)
      final.matrix[(2*i)-3, (2*i)-2] <-1
  }
  return(maxflow(final.matrix,((2*v1)-1),((2*v2)-2)))
}

##in igraph this function is inbuilt which does the exact same thing.
#vertex.disjoint.paths(toy,0,3)







