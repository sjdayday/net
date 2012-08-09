context("Vertex disjoint paths")  # Identify the set of tests

source("vertex_disjoint_path.R")
source("sample_net.R")
#require(multicore)

test_that("Disjoint paths calculated correctly",
{
  g <- graph.adjacency(n1)   # n1 from sample_net.R 
  vertices <- c(1,2)
  expect_that(3,equals(vertex_disjoint_paths(vertices,g)[[1]]))
  vertices <- c(3,2)  # should fail; target must be greater than source
  vertex_disjoint_paths(vertices,g)
  expect_that(-99,equals(vertex_disjoint_paths(vertices,g)[[1]]))
  vertices <- c(2,2)  # should fail; source can't equal target 
  expect_that(-98,equals(vertex_disjoint_paths(vertices,g)[[1]]))
  vertices <- c(0,2)  # should fail; 0 invalid
  expect_that(-97,equals(vertex_disjoint_paths(vertices,g)[[1]]))
  vertices <- c(1,10)  # should fail; target out of range
  expect_that(-96,equals(vertex_disjoint_paths(vertices,g)[[1]]))
  vertices <- c("a","b")  # should fail; must be numeric
  expect_that(-95,equals(vertex_disjoint_paths(vertices,g)[[1]]))
})

test_that("Path count list returned from vertex list",
{
  g <- graph.adjacency(n1)   # n1 from sample_net.R 
  lv <- list(c(1,2), c(4,3), c(4,5), c(5,6), c(6,7))
  path_list <- vertex_disjoint_path_list(lv,g)
  expect_that(3,equals(path_list[[1]][[1]])) # disjoint path count...
  expect_that(c(1,2),equals(path_list[[1]][[2]])) # for vertices(1,2)
  expect_that(-99,equals(path_list[[2]][[1]])) # error returned for second vertex pair
})
