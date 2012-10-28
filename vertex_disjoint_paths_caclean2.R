# SJD updated to point to caclean2 data (should be passed as a parameter instead)
# also updated to write the output file to the out directory (in addition to the working directory), so that it doesn't get overlaid accidentally when new code is deployed. 
# also updated cores 

require(igraph)
require(multicore)

source("vertex_disjoint_path.R")
source("upTriangle.R")
source("path.matrix.r")
options(cores= 512)

  print("cores: ")
  print(getOption("cores"))
  print("before creating network")
  timestamp()
#  set.seed(123456)
#  g <- watts.strogatz.game(1, 300 , 10 , 0.05)
  g <- read.graph(file="http://intersci.ss.uci.edu/wiki/pdf/0SDSC/edges_caclean2.net", format="pajek")
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
  print("before writing the matrix file to ~/R/out directory - assumed to exist (but also written to working directory, just in case)")
  timestamp()
  write.csv(matrix, "matrix_caclean2.csv")
  write.csv(matrix, "~/R/out/matrix_caclean2.csv")

  print("end of job")
  timestamp()
