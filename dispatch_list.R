# function that takes the size of the matrix and return all the upper triangle vertex pairs
source("vertex_disjoint_path.R")
total_list_length <- function(n){
   list_length <- (n*(n-1)) / 2  
   list_length
}
number_of_pairs_per_chunk <- function(total){
   number_cores = getOption("cores")
   chunk <- total %/% number_cores  
#   print("cores: ")
   if (0 < (total %% number_cores)) {
     chunk <- chunk + 1
   }
   chunk
}
offset_to_starting_pair <- function(last_node, total, chunk, core_number){
  not_there_yet = TRUE
  current_row <- 0
  row_index <- 0
  end_node <- 0
  offset <- chunk * core_number
  while (not_there_yet) {
    last_index <- row_index
    last_row <- current_row
    current_row <- current_row + 1
    row_size <- last_node - current_row
    row_index <- row_index + row_size	
    if ((row_index > offset) || (current_row >= last_node)){ 
       not_there_yet = FALSE
       index <- last_index
       end_node <- current_row + 1
       while (index < offset){
	 end_node <- end_node + 1
         index <- index + 1 
       }
    }    
  }
  start_node <- current_row
  starting_pair <- c(start_node,end_node)
  starting_pair 

}
vertex_list_from_starting_pair <- function(last_node, chunk, start_node){
  vertex_list <- list()
  start_row <- start_node[1]
  end_node <- start_node[2]
  node <- 1
  while(node <= chunk)
  {
        vertex_list[[node]] <- c(start_row,end_node)
        end_node <- end_node+1
        if (end_node > last_node)
        {
	    start_row <- start_row+1
            end_node <- start_row+1
	}
        if (start_row >= last_node) 
        { 
            break
        }
        else
	{
	    node <- node+1
        }
  }
  vertex_list
}
build_core_dispatch_list <- function(last_node)
{
  dispatch_list <- list()
  total <- total_list_length(last_node)
  chunk <- number_of_pairs_per_chunk(total)
  number_cores = getOption("cores")
  for (i in 0:(number_cores - 1))
  {
     index <- i+1
     dispatch_list[[index]] <- c(last_node,total,chunk,i)
  }
  dispatch_list
}
vertex_disjoint_path_list_by_core <- function(core_dispatch_list,graph)
{
   mclapply(core_dispatch_list, vertex_disjoint_paths_by_core, graph,mc.cores = getOption("cores"))
}
vertex_disjoint_paths_by_core <- function(dispatch_entry,graph)
{
  last_node <- dispatch_entry[1]
  total <- dispatch_entry[2]
  chunk <- dispatch_entry[3]
  core_number <- dispatch_entry[4]
  start_node <- offset_to_starting_pair(last_node, total, chunk, core_number)
  vertex_list <- vertex_list_from_starting_pair(last_node, chunk, start_node)
  lapply(vertex_list, vertex_disjoint_paths, graph)  
}
format_path_list_to_single_level <- function(path_list)
{
  path_list_single_level <- list()
  k <- 0
  for(i in 1:length(path_list))
  {
    sub_list <- path_list[[i]]
    for(j in 1:length(sub_list))
    {
      k <- k+1
      path_list_single_level[[k]] <- sub_list[[j]]
    }
  }
  path_list_single_level
}
