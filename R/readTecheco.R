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
  data("getDataFromRawFiles")

  # Set default year of 2030 for missing year entries
  df$Year[is.na(df$Year)] <- 2030
  df$attr <- df[,2]

  # if final value was manually set, all other values for the same attribute and year are ignored (omitted)
  manuallySetGroups <- df[!is.na(df$Final.value), c("attr","Year")]
  df <- df[(!paste0(df$attr, df$Year) %in% paste0(manuallySetGroups$attr, manuallySetGroups$Year)) |!is.na(df$Final.value),]

  # ----- Convert units to REMIND units -----

  # Inner join mapping to data
  df <- merge(x=df, y=mapping, by.x=c("attr", "Reported.Unit"), by.y=c("Electrolysis.Report", "Unit.Input"), all=FALSE)

  # apply conversion factors for direct multiplication
  df$Final.value[df$conversion.remarks == ""] <- df$Report.Value[df$conversion.remarks == ""] * df$Factor[df$conversion.remarks == ""]

  # apply conversion factors for division/percentage conversions
  df$Final.value[df$conversion.remarks=="DIV"] <-  (df$Factor[df$conversion.remarks=="DIV"]) / df$Report.Value[df$conversion.remarks=="DIV"]

  # -----

  # if final value was not set, an average value from all values for the same REMIND attribute and year is created
  agvs <- aggregate(Final.value~REMIND + Year,df,mean)

  # write final params to log
  write.csv(df[,c("attr","Final.value", "Unit.REMIND", "REMIND")], "../../output/Techeco_final_data.csv", row.names=FALSE)

  # create magpie object with single region and found years and values using the REMIND variable name
  m <- new.magpie(cells_and_regions = c("GLO"),
                  years = unique(df$Year[!is.na(df$Year)]),
                  names = unique(df$REMIND[!is.na(df$REMIND)]),
                  sets = c("region", "year", "value"),
                  fill = 0)

  # fill magpie with corresponding values
  # duplicates are overridden
  for(i in 1:nrow(df)) {
    x <- agvs[i,]

    # Consider only rows where an used value exists
    if(!is.na(x$Final.value)){

      m["GLO",as.integer(x$Year),x$REMIND] <- as.double(x$Final.value)

    }
  }

  # return filled magpie object
  return(m)
}
