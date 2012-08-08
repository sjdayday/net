# Calculate vertex disjoint paths from graph and 2 element vector of vertices

require(igraph)

vertex_disjoint_paths <- function(vertices, graph)
{
  source <- vertices[1]
  target <- vertices[2]
  num_vertices <- length(V(graph))
  if (mode(vertices) != "numeric") { return (-95) }  
  if (target < source) {  return (-99) }
  if (target == source) {  return (-98) }
  if ((target <= 0) || (source <= 0)) { return (-97) }
  if ((target > num_vertices) || (source > num_vertices)) { return (-96) }
  vertex.disjoint.paths(graph, source, target)
}
