context("Testing Upper Triangle Vertex Pairs")  # Identify the set of tests

source("upTriangle.R")

test_that("Test that 45 vertex pairs get created in order",
{
	lTest <- upTriangle(10)
  expect_that(45,equals(length(lTest)))
  vertex <- c(1,2)  # should not fail;
  expect_that(vertex,equals(lTest[[1]]))
  vertex2 <- c(9,10)  # should not fail;
  expect_that(vertex2,equals(lTest[[45]]))
})

