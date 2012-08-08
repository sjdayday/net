#install.packages(igraph)
library(igraph)
t1<-matrix(nrow=8,ncol=8,seq(0,0,length=64))
 t1[1,2]<-1
 t1[2,3]<-1
 t1[3,4]<-1
 t1[4,5]<-1
 t1[4,7]<-1
 t1[5,6]<-1
 t1[6,7]<-1
 t1[7,8]<-1
 t1[8,1]<-1
 t2<-t1+t(t1)
 toy<-graph.adjacency(t2)
 vertex.disjoint.paths(toy,0,3) # nips test
 ALL EFFORTS BELOW HAVE THIS ERROR
 Error in vertex.disjoint.paths(toy, i, j) : 
  At flow.c:2086 : The source==target case is not implemented, Unimplemented function call
#TOLGA'S TRY
a<-rep(0,64)
a<-matrix(a,nrow=8,ncol=8)
for(i in 1:8){
 for (j in 1:8){
	a[i,j]<-vertex.disjoint.paths(toy,i-1,j-1)
}
}
#TOLGA'S TRY 2
a<-rep(0,64)
a<-matrix(a,nrow=8,ncol=8,seq(0,0,length=64))
for(i in 0:7){
 for (j in 0:7){
	a[i,j]<-vertex.disjoint.paths(toy,i,j)
}
}
 #DOUG'S TRY
 t3<-rep(0,64)
 t3<-matrix(nrow=8,ncol=8,seq(0,0,length=64))
 for (i in 0:7) {
     (j in 0:7) {t3<-vertex.disjoint.paths(toy,i,j)
                 }} # nips 

NO NEED TO VECTORIZE
     [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8]
[1,]    0    1    0    0    0    0    0    1
[2,]    1    0    1    0    0    0    0    0
[3,]    0    1    0    1    0    0    0    0
[4,]    0    0    1    0    1    0    0    0
[5,]    0    0    0    1    0    1    0    0
[6,]    0    0    0    0    1    0    1    0
[7,]    0    0    0    0    0    1    0    1
[8,]    1    0    0    0    0    0    1    0


