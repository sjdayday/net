path.matrix<-function(path.list,n){
  pmatrix<-matrix(rep(0,n*n),nrow=n,ncol=n)
  for(i in 1:length(path.list)){
    pmrow<- unlist(path.list[[i]][2])[1]
    pmcol<- unlist(path.list[[i]][2])[2]
    pmatrix[pmrow,pmcol]<-unlist(path.list[[i]][1])
  }
  pmatrix<- pmatrix+t(pmatrix)
  return(pmatrix)
}