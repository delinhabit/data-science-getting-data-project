source("download.R")
source("analysis.R")

outputFilename <- "data/tidyHARDataset.txt"
url <- paste(c(
    "https://d396qusza40orc.cloudfront.net",
    "/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"))
dataFile <- downloadData(url, filename = "HARDataset.zip")

dataSet <- processHARDataset(dataFile)
write.table(dataSet, file=outputFilename, row.name=FALSE)
