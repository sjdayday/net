require(igraph)
require(digest)
require(RSQLite)

g <- read.graph(file="http://intersci.ss.uci.edu/wiki/Vlado/zachary.net", format="pajek")

numV = length(V(g));

vertex.disjoint.paths(g,1,3)

a<-matrix(nrow=numV,ncol=numV,seq(0,0,length=64))
for(i in 1:(numV - 1)){
 for (j in (i+1):numV){
#	print(i)
#	print(j)
	a[i,j]<-vertex.disjoint.paths(g,i,j)
}
}
a<-a+t(a)

