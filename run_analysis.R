source("download.R")
source("analysis.R")

inputUrl <- paste(
    c("https://d396qusza40orc.cloudfront.net",
      "getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"),
    collapse="/")
inputFile <- downloadData(inputUrl)
outputFile <- "data/tidyHARDataset.txt"

kLabelsFilename <- "UCI\ HAR\ Dataset/activity_labels.txt"
kFeaturesFilename <- "UCI\ HAR\ Dataset/features.txt"

dataSet <- processHARDataset(inputFile)
saveHARDataset(dataSet, outputFile)