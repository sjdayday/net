# Calculate vertex disjoint paths from graph and 2 element vector of vertices

require(igraph)
options(cores = 16) # update as appropriate; benchmarking suggested

build_list <- function(c, verts)
{
  list(count=c, vertices=verts)
}

vertex_disjoint_paths <- function(vertices, graph)
{
  source <- vertices[1]
  target <- vertices[2]
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
  mclapply(vertex_list, vertex_disjoint_paths, graph)
}
