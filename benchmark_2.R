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
# g <- watts.strogatz.game(1, 300 , 10 , 0.05)
  g <- watts.strogatz.game(1, 30 , 5, 0.05)

  numV = length(V(g))

  print("before creating vertex pair list")
  timestamp()
# vertex_pair_list <- upTriangle(numV)
  core_dispatch_list <- build_core_dispatch_list(numV)

  print("before starting mclapply")
  timestamp()
  path_list <- vertex_disjoint_path_list_by_core(core_dispatch_list,g,"paths")

# print("before reformatting path list")
# path_list_single_level <- format_path_list_to_single_level(path_list)
  timestamp()

# print("before building final path matrix")
#  timestamp()
#  matrix <- path.matrix(path_list_single_level,numV)

  #Note that this file is overwritten on subsequent runs
#  print("before writing the matrix file")
#  timestamp()
#  write.csv(matrix, "newmatrix.csv")

  print("end of job")
  timestamp()
