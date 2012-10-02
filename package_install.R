# package_install.R : one-time installation of packages.  
# Note:  assumes you have already created directory "RLibrary" in your home directory.  
# Watch for error messages.  After this runs, verify that directories exist in RLibrary for each package.  
# If not, run the corresponding install.packages commabd at the R prompt and look for the error, to start debugging what went wrong.     
install.packages("snow", "~/RLibrary")
install.packages("sna", "~/RLibrary")
install.packages("multicore", "~/RLibrary")
install.packages("igraph", "~/RLibrary")
install.packages("network", "~/RLibrary")
install.packages("stringr", "~/RLibrary")
install.packages("plyr", "~/RLibrary")
install.packages("digest", "~/RLibrary")
install.packages("evaluate", "~/RLibrary")
install.packages("testthat", "~/RLibrary")
install.packages("miscTools", "~/RLibrary")
