# Calculate vertex disjoint paths from graph and 2 element vector of vertices
require(multicore)
require(igraph)
#options(cores = 16) # commented; this should be set at the benchmark level to enable it to be overridden easily by the run script

build_list <- function(c, verts)
{
  list(count=c, vertices=verts)
}

vertex_disjoint_paths <- function(vertices, graph)
{
  # if logs become too verbose, comment out the next 3 lines
  #print("before calculating disjoint paths for vertices: ")
  #print(vertices)
  #timestamp()
  source <- vertices[1]
  target <- vertices[2]
  if ((source %% 500 == 0) && (target %% 500 == 0))
  {
     timestamp()
     print("source: ")
     print(source)
     print("target: ")
     print(target)
  }
  num_vertices <- length(V(graph))
  if (mode(vertices) != "numeric") { return(build_list(-95,vertices)) }  
  if (target < source) {  return(build_list(-99,vertices)) }
  if (target == source) {  return(build_list(-98,vertices)) }
  if ((target <= 0) || (source <= 0)) { return(build_list(-97,vertices)) }
  if ((target > num_vertices) || (source > num_vertices)) { return(build_list(-96,vertices)) }
  build_list(vertex.disjoint.paths(graph, source, target),vertices)
}
vertex_disjoint_path_list <- function(vertex_list, graph)
{
  mclapply(vertex_list, vertex_disjoint_paths, graph,mc.cores = getOption("cores"))
}
write_path_list_to_file <- function(vertex_path_list, filename)
{
  len <- length(vertex_path_list)
  for(i in 1:len)
  {
    cat(file=filename, sep="\t", append=TRUE, unlist(vertex_path_list[[i]]), "\n")
  }
  len
}

