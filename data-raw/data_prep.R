
pb <- read.csv("data-raw/SurvAF_PublishedKnowledge.csv")

pb$Subpopulation <- toupper(letters[1:nrow(pb)])


usethis::use_data(overwrite = TRUE)
