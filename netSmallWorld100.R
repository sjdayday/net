require(igraph)
require(digest)
require(RSQLite)

source("vertex_disjoint_path.R")

g <- watts.strogatz.game(1, 100, 5, 0.05)

numV = length(V(g))

a<-matrix(nrow=numV,ncol=numV,seq(0,0,length=(numV*numV)))

for(i in 1:(numV - 1)){
 for (j in (i+1):numV){
#	print(i)
#	print(j)
	a[i,j]<-vertex.disjoint.paths(g,i,j)
}
}
a<-a+t(a)

