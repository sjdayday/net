require(igraph)
require(multicore)

source("vertex_disjoint_path.R")
source("upTriangle.R")
source("path.matrix.r")
options(cores= 2)

  print("cores: ")
  print(getOption("cores"))
  print("before creating network")
  timestamp()
  set.seed(123456)
  g <- watts.strogatz.game(1, 300 , 10 , 0.05)

  numV = length(V(g))

  print("before creating vertex pair list")
  timestamp()
  vertex_pair_list <- upTriangle(numV)

  print("before starting mclapply")
  timestamp()
  path_list <- vertex_disjoint_path_list(vertex_pair_list,g)

  print("before building final path matrix")
  timestamp()
  matrix <- path.matrix(path_list,numV)

  #Note that this file is overwritten on subsequent runs
  print("before writing the matrix file")
  timestamp()
  write.csv(matrix, "matrix.csv")

  print("end of job")
  timestamp()
