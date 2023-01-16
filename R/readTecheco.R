#' @title       readTecheco
#' @description Read in irrigation system type for initialization
#'
#' @param subtype Data source to be used:
#'                csv - techno-economic csv-file
#'
#' @return MAgPIE object of techno-economic data
#' @author Paul Effing
#' @export

readTecheco <- function(subtype = "csv") {

  # Read in data
  file <- read.csv("Electrolysis_costs.csv")

  # Set default year of 2030 for missing year entries
  file$Year[is.na(file$Year)] <- 2030
  file$attr <- file[,2]

  # if final value was manually set, all other values for the same attribute and year are ignored (omitted)
  manuallySetGroups <- file[!is.na(file$Final.value), c("attr","Year")]
  file <- file[(!paste0(file$attr, file$Year) %in% paste0(manuallySetGroups$attr, manuallySetGroups$Year)) |!is.na(file$Final.value),]

  # Convert units to REMIND units
  # read in mapping to REMIND
  # mapping <- toolGetMapping("Mapping_Electrolysis.csv", type = "reportingVariables")
  mapping <- read.csv("Mapping_Electrolysis.csv")

  # outer right join mapping to data
  file <- merge(x=file, y=mapping, by.x=c("attr", "Reported.Unit"), by.y=c("Electrolysis.Report", "Unit.Input"), all=FALSE)

  # apply conversion factors for direct multiplication
  file$Final.value[file$conversion.remarks == ""] <- file$Report.Value[file$conversion.remarks == ""] * file$Factor[file$conversion.remarks == ""]

  # apply conversion factors for division/percentage conversions
  file$Final.value[file$conversion.remarks=="DIV"] <-  (file$Factor[file$conversion.remarks=="DIV"]) / file$Report.Value[file$conversion.remarks=="DIV"]

  # if final value was not set, an average value from all values for the same REMIND attribute and year is created
  agvs <- aggregate(Final.value~REMIND + Year,file,mean)

  # create magpie object with single region and found years and values using the REMIND variable name
  m <- new.magpie(cells_and_regions = c("GLO"),
                  years = unique(file$Year[!is.na(file$Year)]),
                  names = unique(file$REMIND[!is.na(file$REMIND)]),
                  sets = c("region", "year", "value"),
                  fill = 0)

  # fill magpie with corresponding values
  # duplicates are overridden
  for(i in 1:nrow(file)) {
    x <- agvs[i,]

    # Consider only rows where an used value exists
    if(!is.na(x$Final.value)){

      m["GLO",as.integer(x$Year),x$REMIND] <- as.double(x$Final.value)

    }
  }

  # return filled magpie object
  return(m)
}
