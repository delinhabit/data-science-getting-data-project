source("download.R")

test_inferFilenameFromUrl <- function() {
    filename <- inferFilenameFromUrl("https://data.company.org/files/data.zip")
    checkEquals(filename, "data.zip")
}

test_inferFromUrlEncodedFilename <- function() {
    url <- paste(
        c("https://d396qusza40orc.cloudfront.net",
          "getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"),
        collapse="/")

    filename <- inferFilenameFromUrl(url)
    checkEquals(filename, "UCI_HAR_Dataset.zip")
}