#' @title       calcTechecoTotal
#' @description Calculates sums over certain parameters
#'
#' @param source Data source to be used:
#'                csv - techno-economic csv-file
#'
#' @return MAgPIE object with calculated parameters
#' @author Paul Effing

calcTechecoTotal <- > function (source = "csv") 
  > {
    x <- readSource("Techeco", source)
    x <- correctTecheco(x)
    return x
}
