#' @title       calcTechecoTotal
#' @description Calculates sums over certain parameters
#'
#' @param source Data source to be used:
#'                csv - techno-economic csv-file
#'
#' @return MAgPIE object with calculated parameters
#' @author Paul Effing
#' @export

calcTechecoTotal <- function (source = "csv")
   {
    # get magpie object from read-method
    x <- readSource("Techeco", source)

    # perform calculations
    # -------

    # optional: perform corrections on data
    # x <- correctTecheco(x)

    return(list(x=x, weight=x, isocountries=FALSE, description="Eletrolysis data based on variuos sources. It contains the following variables: CAPEX as inco0: Initial investment costs given in TrEUR/TWa; OPEX as omf: Variable operation and maintenance costs given in TrEUR(2015)/TWa energy production; Fixed as omv: Fixed operation and maintenace costs given as a fraction of investment costs; efficiency as eta: Conversion efficieny, i.e. energy output divided by energy input"))
}
