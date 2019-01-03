
pb <- read.csv("data-raw/SurvAF_PublishedKnowledge.csv")

pb$Subpopulation <- toupper(letters[1:nrow(pb)])

bbs <- BBS.tenstop::get_BBS10()

bbs_routes <- dplyr::filter(bbs$routes, BCR %in% c(9, 10, 16))

bbs_routes <- dplyr::select(bbs_routes, countrynum, statenum, Route, Active, Latitude, Longitude, BCR, RouteTypeID, routeID)

bbs_weather <- dplyr::filter(bbs$weather, routeID %in% bbs_routes$routeID)

bbs_weather <- dplyr::select(bbs_weather, countrynum, statenum, Route, RPID, Year, Month, Day, ObsN, StartTemp, EndTemp, StartWind, EndWind, StartSky, EndSky, StartTime, EndTime, Assistant, RunType, routeID)

bbs_counts <- dplyr::filter(bbs$counts, routeID %in% bbs_routes$routeID)

bbs_counts <- dplyr::select(bbs_counts, Year, aou, speciestotal, routeID)
bbs_data <- list(routes = bbs_routes, weather = bbs_weather, counts = bbs_counts)


usethis::use_data(bbs_data,overwrite = TRUE)

