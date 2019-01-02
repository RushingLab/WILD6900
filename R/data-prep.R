WILD6900_colors <- data.frame(name = c("primary", "secondary", "success", "info", "warning", "danger", "light", "dark"),
                              value = c("#446E9B", "#999999", "#3CB521", "#3399F3", "#D47500", "#CD0200", "#eeeeee", "#333333"))
WILD6900_colors$value <- as.character(WILD6900_colors$value)

SurvPriorDat <- read.csv("data-raw/SurvAF_PublishedKnowledge.csv")

SurvPriorDat <- dplyr::filter(SurvPriorDat, !is.na(AFse))

SurvPriorDat <- dplyr::select(SurvPriorDat, AF, AFse, Reference)

SurvPriorData <- dplyr::rename(SurvPriorDat, phi = AF, se = AFse)

usethis::use_data(WILD6900_colors, SurvPriorData, overwrite = TRUE)
