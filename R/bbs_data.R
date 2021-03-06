#' Breeding Bird Survey data
#'
#' A dataset containing the raw BBS counts and covariate data for BCRs 9, 10, and 16 (1966-present).
#'
#' @format A list with 3 data frames:
#' \describe{
#'   \item{routes}{ROUTE ATTRIBUTES}
#'     \itemize{
#'       \item{`countrynum`}{  The three digit code that identifies country where route is located}
#'       \item{`statenum`}{  The two digit numerical code that identifies the state, province, or territory where the route is located}
#'       \item{`Route`}{  The three digit code that identifies the route}
#'       \item{`Active`}{  1 if the route is currently active, 0 if it is not}
#'       \item{`Latitude`}{  The latitude of the route start point in decimal degrees}
#'       \item{`Longitude`}{  The longitude of the route start point in decimal degrees}
#'       \item{`BCR`}{ The Bird Conservation Region where the route is located}
#'       \item{`RouteTypeID`}{  Indicates route length and selection criteria (1=random, 50 Stops, 2 =Not Random, 50 Stops, 3=Not Random, < 50 stops)}
#'       \item{`routeID`}{  Unique eight digit route ID}
#'    }
#'   \item{weather}{RUN ATTRIBUTES}
#'     \itemize{
#'       \item{`RPID`}{  The run protocol identification number.}
#'       \item{`Year`}{  The year}
#'       \item{`Month`}{  The month the route was run (1-12)}
#'       \item{`Day`}{  The day the route was run (1-31)}
#'       \item{`ObsN`}{  Unique observer identification number}
#'       \item{`StartTemp`}{  The temperature recorded at the beginning of the run of the route}
#'       \item{`EndTemp`}{  The temperature recorded at the end of the run of the route}
#'       \item{`StartWind`}{  The Beaufort wind speed code recorded at the beginning of the run of the route}
#'       \item{`EndWind`}{  The Beaufort wind speed code recorded at the end of the run of the route}
#'       \item{`StartSky`}{  The Weather Bureau sky code recorded at the beginning of the run of the route}
#'       \item{`EndSky`}{  The Weather Bureau sky code recorded at the end of the run of the route}
#'       \item{`StartTime`}{  The time the run of the route began, recorded in 24 hour local time}
#'       \item{`EndTime`}{  The time the run of the route ended, recorded in 24 hour local time}
#'       \item{`Assistant`}{  If someone assisted the observer by recording the data}
#'       \item{`RunType`}{  The RunType code helps to quickly determine which data do, or do not meet the BBS program’s data criteria. A RunType code of 1 is assigned whenever data were collected under conditions that meet BBS weather, date, time, and route completion criteria (QualityCurrentID = 1) on a randomly established route (i.e., RouteTypeDetailID = 1) using the official BBS sampling protocol (RunProtocolID = 101)}
#'       \item{`routeID`}{  Unique eight digit route ID}
#'    }
#'   \item{counts}{SPECIES COUNTS}
#'    \itemize{
#'       \item{`Year`}{  The year}
#'       \item{`routeID`}{  Unique eight digit route ID}
#'       \item{`aou`}{  All remaining columns are the counts of specific species; column names refer to the aou code used by BBS to identify species; values indicate the total number of individuals counted at each route in each year}
#'    }
#'}
#' @source \url{https://www.mbr-pwrc.usgs.gov/bbs/}
"bbs_data"
