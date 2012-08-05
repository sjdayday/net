#2011 creative commons B. Tolga Oztan Z-0001Protected backup
#libraries to add:
library(sna)
library(network)
##source the toy example:
net=source("http://intersci.ss.uci.edu/wiki/pub/PajekR-KinSimGF.R")

generation.permutation <- function(matrix,generation,location, lineage="MALEANDFEMALE"){
 gen <- max(generation) #number of generation in the network
 nodes <- length(matrix[1,])  #number of nodes in the network
 matriline <- rep(0, nodes) #create a vector of zeros of length equal to the number of nodes in the network to store female lineage.
 patriline <- rep(0, nodes) #create a vector of zeros of length equal to the number of nodes in the network to store male lineage.

 for (i in 1:nodes) {
  if (sum(matrix[i,]) ==3)  #this line checks if the row sum equals 3 i.e, the node corresponds to a marriage not a single person
     for (j in 1:nodes){
      if (matrix[i,j] == 1) patriline[i] <- j  #when the node is indeed a marriage find the node that the husband comes from
      if (matrix[i,j] == 2) matriline[i] <- j  #when the node is indeed a marriage find the node that the wife comes from
     }
 }

 genindex <- which(generation == gen) ##store the index for the oldest generation
 generationformarried <- generation * as.logical(patriline)  ##new generation vector where single nodes and oldest generation become 0's
 generationformarried[genindex] <- gen    ##we put the oldes generation back so only the single nodes are 0's now.

 #permute the patriline and matriline
 permutedpatriline<-patriline
 permutedmatriline<-matriline
  
 if (lineage=="MALEANDFEMALE")  {
   for(i in 1:(gen-1)){
     index<-which(generationformarried==i) #index the nodes (marriages only) of generation i
     v<-sample(permutedpatriline[index]) #permute those
     v2<-sample(permutedmatriline[index])
     while (sum(v==v2) > 0)               ##make sure the wife and husband are not sent to the same parantal node, i.e sibling marriage
       v2 <- sample(permutedmatriline[index])
     permutedpatriline[index]<-v        #put permuted back in permutedpatriline
     permutedmatriline[index]<-v2
   }
 }
 if (lineage=="MALE") {
   for(i in 1:(gen-1)){
     index<-which(generationformarried==i) #index the nodes (marriages only) of generation i
     v<-sample(permutedpatriline[index]) #permute those
     v2<- permutedmatriline[index]
     while (sum(v==v2) > 0)               ##make sure the wife and husband are not sent to the same parantal node, i.e sibling marriage
       v <- sample(permutedpatriline[index])
     permutedpatriline[index]<-v        #put permuted back in permutedpatriline
   }
 }
  
 if (lineage=="FEMALE")   {
   for(i in 1:(gen-1)){
     index<-which(generationformarried==i) #index the nodes (marriages only) of generation i
     v<-sample(permutedmatriline[index]) #permute those
     v2<- permutedpatriline[index]
     while (sum(v==v2) > 0)               ##make sure the wife and husband are not sent to the same parantal node, i.e sibling marriage
       v <- sample(permutedmatriline[index])
     permutedmatriline[index]<-v        #put permuted back in permutedpatriline
   }
 }
  
 ##recreating the adjacency matrix
 permmatrix <- matrix
   for (i in 1:nodes){
     permmatrix[i, patriline[i]] <- 0
     permmatrix[i, matriline[i]] <- 0
     permmatrix[i, permutedpatriline[i]] <- 1
     permmatrix[i, permutedmatriline[i]] <- 2
   }



 #gplot(matrix,  coord = cbind(4*location,generation),gmode = "digraph", vertex.col=generation, edge.col=matrix, vertex.cex=2, label = c(1:dim(matrix)[2]))
 #dev.new()
 #gplot(permmatrix,  coord = cbind(15*location,generation),gmode = "digraph", vertex.col=generation, edge.col=permmatrix, vertex.cex=2, label = c(1:dim(permmatrix)[2]))
 return(permmatrix)
}

generation.permutation(n1,v1,v2)

