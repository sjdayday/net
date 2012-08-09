path.matrix<-function(path.list,n){
  pmatrix<-matrix(nrow=n,ncol=n)
  for(i in 1:length(path.list)){
    pmrow<- unlist(path.list[[i]][2])[1]
    pmcol<- unlist(path.list[[i]][2])[2]
    pmatrix[pmrow,pmcol]<-unlist(path.list[[i]][1])
  }
  return(pmatrix)
}