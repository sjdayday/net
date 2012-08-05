cat("################################################",sep="\n")
cat(" R called from Pajek                            ",sep="\n")
cat(" http://vlado.fmf.uni-lj.si/pub/networks/pajek/ ",sep="\n")
cat(" Vladimir Batagelj & Andrej Mrvar               ",sep="\n")
cat(" University of Ljubljana, Slovenia              ",sep="\n")
cat("-----------------------------------------------------------------------",sep="\n")
cat(" The following networks/matrices read:",sep="\n")
n1<-matrix(nrow=13,ncol=13,seq(0,0,length=169))
G=0
F=0
n1[13,5]<-1; G[13]=5
n1[1,5]<-1; G[1]=5
n1[1,6]<-2; F[1]=6
n1[2,6]<-1; G[2]=6
n1[2,7]<-2; F[2]=7
n1[3,7]<-1; G[3]=7
n1[3,8]<-2; F[3]=8
n1[4,8]<-1; G[4]=8
n1[4,5]<-2; F[4]=5
n1[5,9]<-1; G[5]=9
n1[5,10]<-2; F[5]=10
n1[6,10]<-1; G[6]=10
n1[6,11]<-2; F[6]=11
n1[7,11]<-1; G[7]=11
n1[7,12]<-2; F[7]=12
n1[8,12]<-1; G[8]=12
n1[8,9]<-2; F[8]=9
G[9]=0
G[10]=0
G[11]=0
G[12]=0
F[13]=0
F[9]=0
F[10]=0
F[11]=0
F[12]=0
F[13]=0
colnames(n1)<-c("Child 1","Child 2","Child 3","Child 4","Couple 5","Couple 6","Couple 7","Couple 8","Couple 9","Andestor 10","Couple 11","Andestor 12","Child 13")
rownames(n1)<-c("Child 1","Child 2","Child 3","Child 4","Couple 5","Couple 6","Couple 7","Couple 8","Couple 9","Andestor 10","Couple 11","Andestor 12","Child 13")
comment(n1)<-"C:/Program Files/R/R-2.6.2/0KinPajFiles/KinSim3gen.net (13)"
cat(" n1  :  C:/Program Files/R/R-2.6.2/0KinPajFiles/KinSim3gen.net (13)",sep="\n")
cat("",sep="\n")
cat(" The following vectors read:",sep="\n")
v1<-c(1,1,1,1,2,2,2,2,3,3,3,3,1)
comment(v1)<-"From partition 1 (13)"
cat(" v1  :  From partition 1 (13)",sep="\n")
v2<-c(0.77000000,0.59000000,0.41000000,0.23000000,0.77000000,0.59000000,0.41000000,0.23000000,0.77000000,0.59000000,0.41000000,0.23000000,0.92710000)
comment(v2)<-"x-coordinate of N1 (13)"
cat(" v2  :  x-coordinate of N1 (13)",sep="\n")
cat("",sep="\n")
cat(" Use objects() to get list of available objects           ",sep="\n")
cat(" Use comment(?) to get information about selected object  ",sep="\n")
savevector<-function(v,direct){write(c(paste("*Vertices",length(v)), v), file = direct, ncolumns=1)}
cat(" Use savevector(v?,'???.vec') to save vector to Pajek input file  ",sep="\n")
comment(savevector)<-"Save vector to file that can be read by Pajek"
savematrix <- function(n,direct,twomode=1){
if ((dim(n)[1] == dim(n)[2]) & (twomode!=2))
{ write(paste("*Vertices",dim(n)[1]), file = direct);
  write(paste(seq(1,length=dim(n)[1]),' "',rownames(n),'"',sep=""), file = direct,append=TRUE);
  write("*Matrix", file = direct,append=TRUE);
  write(t(n),file = direct,ncolumns=dim(n)[1],append=TRUE) }
else
{ write(paste("*Vertices",sum(dim(n)),dim(n)[1]), file = direct);
  write(paste(1:dim(n)[1],' "',rownames(n),'"',sep=""), file = direct,append=TRUE);
  write(paste(seq(dim(n)[1]+1,length=dim(n)[2]),' "',colnames(n),'"',sep=""), file = direct,append=TRUE);
  write("*Matrix", file = direct, append=TRUE);
  write(t(n),file = direct, ncolumns=dim(n)[2],append=TRUE)} }
cat(" Use savematrix(n?,'???.net') to save matrix to Pajek input file (.MAT) ",sep="\n")
cat("     savematrix(n?,'???.net',2) to request a 2-mode matrix (.MAT) ",sep="\n")
comment(savematrix)<-"Save matrix to file that can be read by Pajek (as *Matrix)"
savenetwork <- function(n,direct,twomode=1){
if ((dim(n)[1] == dim(n)[2]) & (twomode!=2))
{ write(paste("*Vertices",dim(n)[1]), file = direct);
  write(paste(seq(1,length=dim(n)[1]),' "',rownames(n),'"',sep=""), file = direct,append=TRUE);
  write("*Arcs", file = direct,append=TRUE);
   for (i in 1:dim(n)[1]) {
     for (j in 1:dim(n)[2]) {
       if (n[i,j]!=0) {write(paste(i,j,n[i,j]),file = direct,append=TRUE)}
     }
   } }
else
{ write(paste("*Vertices",sum(dim(n)),dim(n)[1]), file = direct);
  write(paste(1:dim(n)[1],' "',rownames(n),'"',sep=""), file = direct,append=TRUE);
  write(paste(seq(dim(n)[1]+1,length=dim(n)[2]),' "',colnames(n),'"',sep=""), file = direct,append=TRUE);
  write("*Edges", file = direct,append=TRUE);
   for (i in 1:dim(n)[1]) {
     for (j in 1:dim(n)[2]) {
       if (n[i,j]!=0) {write(paste(i,j+dim(n)[1],n[i,j]),file = direct,append=TRUE)}
     }
   } } }
cat(" Use savenetwork(n?,'???.net') to save matrix to Pajek input file (.NET) ",sep="\n")
cat("     savenetwork(n?,'???.net',2) to request a 2-mode network (.NET) ",sep="\n")
comment(savenetwork)<-"Save matrix to file that can be read by Pajek (as *Arcs)"
loadvector <- function(direct){
  vv<-read.table(file=direct,skip=1)
  if (dim(vv)[2]==1)
    vv<-vv[[1]]
  vv
}
cat(" Use v?<-loadvector('???.vec') to load vector(s) from Pajek input file  ",sep="\n")
comment(loadvector)<-"Load vector(s) from file that was produced by Pajek"
loadmatrix <- function(direct){
nn<-read.table(file=direct,nrows=1)
if (length(nn) == 2)
  { xx<-read.table(file=direct,skip=1,nrows=nn[[2]],fill=TRUE)
    n<-read.table(file=direct,skip=nn[[2]]+2)
    rownames(n)<-xx[[2]]
    colnames(n)<-xx[[2]] }
 else
   {xxrow<-read.table(file=direct,skip=1,nrows=nn[[3]],fill=TRUE)
    xxcol<-read.table(file=direct,skip=nn[[3]]+1,nrows=nn[[2]]-nn[[3]],fill=TRUE)
    n<-read.table(file=direct,skip=nn[[2]]+2)
    rownames(n)<-xxrow[[2]]
    colnames(n)<-xxcol[[2]] }
  as.matrix(n)
  }
cat(" Use n?<-loadmatrix('???.mat') to load matrix from Pajek input file  ",sep="\n")
comment(loadmatrix)<-"Load matrix from file that was produced by Pajek"
cat("-----------------------------------------------------------------------",sep="\n")
cat("",sep="\n")


