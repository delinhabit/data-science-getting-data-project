source("download.R")
source("analysis.R")

inputUrl <- paste(c(
    "https://d396qusza40orc.cloudfront.net",
    "/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"))
inputFile <- downloadData(inputUrl, filename = "HARDataset.zip")
outputFile <- "data/tidyHARDataset.txt"


dataSet <- processHARDataset(inputFile)
saveHARDataset(dataSet, outputFile)
