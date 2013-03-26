context("Dispatch lists for multicore")  # Identify the set of tests

source("dispatch_list.R")  # pull in pre-requisite source code  

# For N = 6, we expect 15 pairs.  If we have 4 cores, we expect each
# core to process four pairs, except the last core (3 pairs), divided as follows:  
#
# [1-2, 1-3, 1-4, 1-5] [1-6, 
# 2-3, 2-4, 2-5] [2-6
# 3-4, 3-5, 3-6]
# [4-5, 4-6
# 5-6]
test_that("Calculate total list length and division by number of cores into number of pairs per chunk",
{
  N = 6
  total <- total_list_length(N)
  expect_that(15,equals(total))
  lastNode <- N
  options(cores= 3)
  expect_that(5,equals(number_of_pairs_per_chunk(total)))
  options(cores= 4)
# if there are an uneven number of pairs per chunk, round up
  expect_that(4,equals(number_of_pairs_per_chunk(total)))
  options(cores= 6)
  expect_that(3,equals(number_of_pairs_per_chunk(total)))
# note:  as number of cores gets higher in relation to total, we may have cores with no work to do
  options(cores= 8)
  expect_that(2,equals(number_of_pairs_per_chunk(total)))
  options(cores= 14)
  expect_that(2,equals(number_of_pairs_per_chunk(total)))
  options(cores= 15)
  expect_that(1,equals(number_of_pairs_per_chunk(total)))
  options(cores= 16)
  expect_that(1,equals(number_of_pairs_per_chunk(total)))
})
test_that("Calculate starting pair, given starting row, chunk, total, and number of this core",
{
  N = 6
  lastNode <- N
  total <- total_list_length(N)
  options(cores= 4)
  chunk <- number_of_pairs_per_chunk(total)
  coreNumber <- 0
   expect_that(c(1,2),equals(offset_to_starting_pair(6, 15, 4, 0)))
   expect_that(c(1,6),equals(offset_to_starting_pair(6, 15, 4, 1)))
   expect_that(c(2,6),equals(offset_to_starting_pair(6, 15, 4, 2)))
   expect_that(c(4,5),equals(offset_to_starting_pair(6, 15, 4, 3)))
})
test_that("Each node builds list of vertex pairs from starting pair",
{
  N = 6
  chunk <- 4
  start_node <- c(1,2)
  node_list <- vertex_list_from_starting_pair(N,chunk,start_node)
  expect_that(4,equals(length(node_list)))
  expect_that(c(1,2),equals(node_list[[1]]))
  expect_that(c(1,5),equals(node_list[[4]]))
  start_node <- c(1,6)
  node_list <- vertex_list_from_starting_pair(N,chunk,start_node)
  expect_that(4,equals(length(node_list)))
  expect_that(c(1,6),equals(node_list[[1]]))
  expect_that(c(2,5),equals(node_list[[4]]))
  start_node <- c(2,6)
  node_list <- vertex_list_from_starting_pair(N,chunk,start_node)
  expect_that(4,equals(length(node_list)))
  expect_that(c(2,6),equals(node_list[[1]]))
  expect_that(c(3,6),equals(node_list[[4]]))
  start_node <- c(4,5)
  node_list <- vertex_list_from_starting_pair(N,chunk,start_node)
  expect_that(3,equals(length(node_list)))
  expect_that(c(4,5),equals(node_list[[1]]))
  expect_that(c(5,6),equals(node_list[[3]]))
  start_node <- c(5,6)
  node_list <- vertex_list_from_starting_pair(N,chunk,start_node)
  expect_that(1,equals(length(node_list)))
  expect_that(c(5,6),equals(node_list[[1]]))
})
test_that("Core dispatch list built",
{
  options(cores = 2)
  N = 6
  dispatch_list <- build_core_dispatch_list(N)
  expect_that(2,equals(length(dispatch_list)))
  expect_that(c(6,15,8,0),equals(dispatch_list[[1]]))
  expect_that(c(6,15,8,1),equals(dispatch_list[[2]]))
#  mclapply(vertex_list, vertex_disjoint_paths, graph,mc.cores = getOption("cores"))
})
test_that("Vertex list built across multiple cores",
{
  options(cores = 2)
  N = 6
#  mclapply(vertex_list, vertex_disjoint_paths, graph,mc.cores = getOption("cores"))
})

