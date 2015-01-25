source("download.R")
source("io.R")
source("analysis.R")

dataset.url <- paste(
    c("https://d396qusza40orc.cloudfront.net",
      "getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"),
    collapse="/")
dataset.filename <- downloadData(dataset.url)

features <- readData(dataset.filename, "features.txt")
labels <- readData(dataset.filename, "activity_labels.txt")
train.dataset <- list(
    subjects = readData(dataset.filename, "train/subject_train.txt"),
    labels = readData(dataset.filename, "train/y_train.txt"),
    features = readData(dataset.filename, "train/X_train.txt"))
test.dataset <- list(
    subjects = readData(dataset.filename, "test/subject_test.txt"),
    labels = readData(dataset.filename, "test/y_test.txt"),
    features = readData(dataset.filename, "test/X_test.txt"))

dataset <- processDataset(train.dataset, test.dataset, features, labels)
saveData(dataset, "data/HARDataset.txt")

averagesDataset <- processAveragesDataset(dataset)
saveData(averagesDataset, "data/AVGDataset.txt")
