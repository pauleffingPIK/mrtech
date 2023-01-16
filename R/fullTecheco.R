#' @title       fullTECHECO
#' @description creates collection of techno-economic dataset and packages them
#'
#'
#' @return collection of data sources
#' @author Paul Effing
#' @export

fullTECHECO <- function (rev = 0, dev = "")
{
  if (rev >= 1) {
    calcOutput("TechecoTotal",aggregate=FALSE,file="techeco.cs4")
  }
  if (dev == "test") {
    message("Here you could execute code for a hypothetical development version called \"test\"")
  }
  return(list(tag = "customizable_tag", pucTag = "tag"))
}
