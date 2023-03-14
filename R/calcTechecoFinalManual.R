#' @title       calcTechecoFinalManual
#' @description Calculates final data for manual analysis from secondary data
#'
#' @param source Data source to be used:
#'                Dataframe - secondary data
#'
#' @return MAgPIE object with calculated parameters
#' @author Paul Effing
#' @export

calcTechecoFinalManual <- function ()
   {
    # get magpie object from read-method
    x <- calcOutput("TechecoSecondary", aggregate=FALSE)

    # perform calculations
    # -------

    # optional: perform corrections on data
    # x <- correctTecheco(x)

    return(list(x=x, weight=x, isocountries=FALSE, description="Eletrolysis data based on variuos sources. It contains the following variables: CAPEX as inco0: Initial investment costs given in TrEUR/TWa; OPEX as omf: Variable operation and maintenance costs given in TrEUR(2015)/TWa energy production; Fixed as omv: Fixed operation and maintenace costs given as a fraction of investment costs; efficiency as eta: Conversion efficieny, i.e. energy output divided by energy input"))
}
