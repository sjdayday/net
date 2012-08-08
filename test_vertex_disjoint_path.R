context("Vertex disjoint paths")  # Identify the set of tests

source("vertex_disjoint_path.R")
source("sample_net.R")
#require(multicore)
#require(doMC)

test_that("Disjoint paths calculated correctly",
{
  g <- graph.adjacency(n1)   # n1 from sample_net.R 
  vertices <- c(1,2)
  expect_that(3,equals(vertex_disjoint_paths(vertices,g)))
  vertices <- c(3,2)  # should fail; target must be greater than source
  vertex_disjoint_paths(vertices,g)
  expect_that(-99,equals(vertex_disjoint_paths(vertices,g)))
  vertices <- c(2,2)  # should fail; source can't equal target 
  expect_that(-98,equals(vertex_disjoint_paths(vertices,g)))
  vertices <- c(0,2)  # should fail; 0 invalid
  expect_that(-97,equals(vertex_disjoint_paths(vertices,g)))
  vertices <- c(1,10)  # should fail; target out of range
  expect_that(-96,equals(vertex_disjoint_paths(vertices,g)))
  vertices <- c("a","b")  # should fail; must be numeric
  expect_that(-95,equals(vertex_disjoint_paths(vertices,g)))
})
  #out <- lapply(L, vertex_disjoint_paths, graph)
