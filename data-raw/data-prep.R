## Color palette
WILD6900_colors <- data.frame(name = c("primary", "secondary", "success", "info", "warning", "danger", "light", "dark"),
                              value = c("#446E9B", "#999999", "#3CB521", "#3399F3", "#D47500", "#CD0200", "#eeeeee", "#333333"))
WILD6900_colors$value <- as.character(WILD6900_colors$value)

## Polar bear survival data
SurvPriorDat <- read.csv("data-raw/SurvAF_PublishedKnowledge.csv")

SurvPriorDat <- dplyr::filter(SurvPriorDat, !is.na(AFse))

SurvPriorDat <- dplyr::select(SurvPriorDat, AF, AFse, Reference)

SurvPriorData <- dplyr::rename(SurvPriorDat, phi = AF, se = AFse)


## BBS data

# bbs <- BBS.tenstop::get_BBS10()

bbs_routes <- dplyr::filter(bbs$routes, BCR %in% c(9, 10, 16))

bbs_routes <- dplyr::select(bbs_routes, countrynum, statenum, Route, Active, Latitude, Longitude, BCR, RouteTypeID, routeID)

bbs_weather <- dplyr::filter(bbs$weather, routeID %in% bbs_routes$routeID)

bbs_weather <- dplyr::select(bbs_weather, RPID, Year, Month, Day, ObsN, StartTemp, EndTemp, StartWind, EndWind, StartSky, EndSky, StartTime, EndTime, Assistant, RunType, routeID)

bbs_counts <- dplyr::filter(bbs$counts, routeID %in% bbs_routes$routeID)

bbs_counts <- dplyr::select(bbs_counts, Year, aou, speciestotal, routeID)
bbs_counts <- tidyr::spread(data = bbs_counts, key = aou, value = speciestotal)

bbs_data <- list(routes = bbs_routes, weather = bbs_weather, counts = bbs_counts)

usethis::use_data(WILD6900_colors, SurvPriorData, bbs_data, overwrite = TRUE)
