source("download.R")
source("analysis.R")

zipUrl <- paste(
    c("https://d396qusza40orc.cloudfront.net",
      "getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"),
    collapse="/")
zipFilename <- downloadData(zipUrl)

dataset <- processDataset(zipFilename)
write.table(dataset, file = "data/HARDataset.txt", row.names = FALSE)

averagesDataset <- processAveragesDataset(dataset)
write.table(averagesDataset, file = "data/AVGDataset.txt", row.names = FALSE)