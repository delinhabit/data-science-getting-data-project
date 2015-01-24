processHARDataset <- function(zipFilename) {
    # Process the UCI HAR dataset located in the provided file and create a
    # tidy dataset required for this assignment.
    #
    # Arguments:
    #    zipFilename - path to the zip file containing the UCI HAR Dataset
    #
    features <- getFeatures(getDataFile(zipFilename, kFeaturesFilename))
    labels <- getLabels(getDataFile(zipFilename, kLabelsFilename))
}

getDataFile <- function(zipFilename, filename) {
    # Get a connection to the provided file in the zip archive.
    #
    # Arguments:
    #    zipFilename - the name of the zip file containing data files
    #    filename - the name of the data file inside the zip
    #
    # Examples:
    # getDataFile("data/UCI_HAR_Dataset.zip", "features.txt")
    # getDataFile("data/UCI_HAR_Dataset.zip", "train/X_train.txt")
    #
    unz(zipFilename, filename = sprintf("UCI HAR Dataset/%s", filename))
}

capitalize = function(str) {
    letters = strsplit(str, '')[[1]]
    letters[1] = toupper(letters[1])
    paste(letters, collapse='')
}

getLabels <- function(labelsFile) {
    # Fetch the labels from the labels file as a list mapping label ids to
    # names.
    #
    # Arguments:
    #    labelsFile - a connection to the labels file
    #
    labelsData <- read.table(labelsFile)

    labels <- list()
    apply(labelsData, 1, function(x) {
        labels[[x[1]]] <<- capitalize(tolower(x[2]))
    })
    labels
}

getFeatures <- function(featuresFile) {
    # Fetch the features from the features file as a list mapping label ids to
    # names.
    #
    # Arguments:
    #    featuresFile - a connection to the features file
    #
    featuresData <- read.table(featuresFile)
    meanFeatures <- sapply(
        featuresData$V2,
        function(x) { grepl("mean()", x, fixed = T) })
    stdFeatures <- sapply(
        featuresData$V2,
        function(x) { grepl("std()", x, fixed = T) })
    featuresData <- featuresData[meanFeatures | stdFeatures, ]

    features <- list()
    apply(featuresData, 1, function(x) {
        id <- as.character(as.numeric(x[1]))
        features[[id]] <<- as.character(x[2])
    })
    features
}

saveHARDataset <- function(dataSet, file) {
    # Save the provided dataSet to a text file.
    #
    # Arguments:
    #    dataSet - the `data.frame` to save
    #    file - the path to the file in which to save the data
    write.table(dataSet, file = file, row.names = FALSE)
}