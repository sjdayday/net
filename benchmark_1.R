require(igraph)
require(multicore)
#require(digest)
#require(RSQLite)

source("vertex_disjoint_path.R")
source("upTriangle.R")
source("path.matrix.r")
options(cores=2)

  set.seed(123456)
  g <- watts.strogatz.game(1, 30,2, 0.05)

  numV = length(V(g))

  vertex_pair_list <- upTriangle(numV)

  path_list <- vertex_disjoint_path_list(vertex_pair_list,g)

  matrix <- path.matrix(path_list,numV)

  write.csv(matrix, "matrix.csv")
  print(matrix)
