# TestSetup.R :  add libraries for testing
library(testthat)
library(stringr)
library(plyr)
library(evaluate)
library(digest)
library(miscTools)
library(animation)
tests <- function()
{
  suppressPackageStartupMessages(test_dir("."))
}
