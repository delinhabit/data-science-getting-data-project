source("download.R")
source("analysis.R")

inputUrl <- paste(
    c("https://d396qusza40orc.cloudfront.net",
      "getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"),
    collapse="/")
inputFile <- downloadData(inputUrl)

harDataset <- processHARDataset(inputFile)
write.table(harDataset, file = "data/HARDataset.txt", row.names = FALSE)

averagesDataset <- processAveragesDataset(harDataset)
write.table(averagesDataset, file = "data/AVGDataset.txt", row.names = FALSE)