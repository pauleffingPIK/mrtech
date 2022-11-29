#' @title       readTecheco
#' @description Read in irrigation system type for initialization
#'
#' @param subtype Data source to be used:
#'                csv - techno-economic csv-file
#'
#' @return MAgPIE object of techno-economic data
#' @author Paul Effing

readTecheco <- function(subtype = "csv") {

  # Read in data
  x <- read.csv("techeco.csv")
  return(x)
}
