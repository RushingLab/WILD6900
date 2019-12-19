## Color palette
WILD6900_colors <- data.frame(name = c("primary", "secondary", "success", "info", "warning", "danger", "light", "dark"),
                              value = c("#446E9B", "#999999", "#3CB521", "#3399F3", "#D47500", "#CD0200", "#eeeeee", "#333333"))
WILD6900_colors$value <- as.character(WILD6900_colors$value)

## Dispersal data
DispData <- read.csv("data-raw/Plantdispersaldata.csv")
DispData2 <- DispData[c(36,37), -c(1,2,3,4)]


Disp_df <- data.frame(Distance = as.numeric(DispData2[1,]),
                      Density = as.numeric(DispData2[2,]))
ggplot(Disp_df) + geom_point(aes(x = Distance, y = Density))

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

bbs_data <- list(routes = bbs_routes, weather = bbs_weather, counts = bbs_counts)

library(sf)
bcr <- sf::st_read("data-raw/BCR.shp")
bcr <- dplyr::filter(bcr, BCRNumber %in% c(9, 10, 16))

### Falcons ----

falcons <- read.table('data-raw/falcons.txt', header =  TRUE)

### Tits ----

tits <- read.table('data-raw/tits.txt', header =  TRUE)

### Pelicans ----

pelicans <- read.csv("data-raw/colony_count_simple.csv")

### Sheep ----

ewe_counts <- read.csv("data-raw/EweMatrix_KSinclair.csv")
ewe_counts <- dplyr::select(ewe_counts, -X)


lamb_counts <- read.csv("data-raw/LambMatrix_KSinclair.csv")
lamb_counts <- dplyr::select(lamb_counts, -X)


### Salamanders ----

salamanders <- read.csv("data-raw/salamander.csv")

### Exam data ----
#### Questions 1

J <- 12               # Number of sites
N <- 120              # Number of observations
rain <- rnorm(N)    # Scaled body length

## Randomly determine each individuals study plot
plot <- c(12, 6, 5, 2, 3, 3, 11, 3, 6, 11, 2, 4, 2, 6, 6, 9, 1, 5, 1, 11, 1, 6, 12, 11, 6, 8, 12, 12,
          11, 8, 5, 6, 3, 7, 2, 2, 8, 8, 3, 5, 6, 1, 5, 2, 4, 9, 1, 2, 10, 3, 5, 2, 12, 2, 5, 5, 2, 2,
          3, 4, 1, 9, 9, 6,
          11, 5, 12, 6, 1, 6, 11, 5, 9, 4, 5, 10, 12, 3, 9, 1, 11, 9, 6, 9, 12, 6, 1, 3, 12, 12, 11,
          11, 8, 12, 5, 12, 7, 6, 12, 8, 10, 5, 3, 6, 11, 9, 12, 2, 11, 8, 9, 6, 12, 4, 1, 8, 8, 12, 6, 11)

mu.alpha <- 400   # Overall mean AGB
sigma.alpha <- 25 # standard deviation of group-level means

alpha <- rnorm(J, mu.alpha, sigma.alpha)

mu.beta <- 4.5
sigma.beta <- 2
beta <- rnorm(J, mu.beta, sigma.beta)     # Slope of rainfall on AGB
sigma <- 30    # Residual standard deviation

Xmat <- model.matrix(~as.factor(plot)*rain - 1)
linear.pred <- Xmat %*% c(alpha, beta)
plot(linear.pred ~ rain)

usethis::use_data(WILD6900_colors, SurvPriorData, bbs_data, bcr, falcons, tits, pelicans, ewe_counts, lamb_counts, salamanders, overwrite = TRUE)

