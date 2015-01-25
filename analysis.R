library(dplyr)

processHARDataset <- function(zipFilename) {
    # Process the UCI HAR dataset located in the provided file and create a
    # tidy dataset as required by step 4 ot the assignment
    #
    # Arguments:
    #    zipFilename - path to the zip file containing the UCI HAR Dataset
    #
    features <- getFeatures(readData(zipFilename, "features.txt"))
    labels <- getLabels(readData(zipFilename, "activity_labels.txt"))

    trainDataset <- getDataset(zipFilename, "train", features, labels)
    testDataset <- getDataset(zipFilename, "test", features, labels)
    rbind(trainDataset, testDataset)
}

readData <- function(zipFilename, filename) {
    # Read the data located in the provided file inside the zip archive.
    #
    # Arguments:
    #    zipFilename - the name of the zip file containing data files
    #    filename - the name of the data file inside the zip
    #
    # Examples:
    # readData("data/UCI_HAR_Dataset.zip", "features.txt")
    # readData("data/UCI_HAR_Dataset.zip", "train/X_train.txt")
    #
    conn <- unz(zipFilename, filename = sprintf("UCI HAR Dataset/%s", filename))
    read.table(conn)
}

getFeatures <- function(featuresData, filters = c("mean()", "std()")) {
    # Extract the relevant feature names from the features data as a list
    # mapping label ids to names.
    #
    # Arguments:
    #    featuresData - the features data as retrieved from features.txt
    #    filters - a character vector by which to filter the feature names.
    #              By default will extract only features that contain
    #              'mean()' and 'std()' in their names.
    #
    filterBy <- rep(FALSE, times = length(featuresData[2]))
    for (filter in filters) {
        filterBy <- filterBy | sapply(
            featuresData[2],
            function(x) { grepl(filter, x, fixed = T) })
    }
    featuresData <- featuresData[filterBy, ]

    features <- list()
    apply(featuresData, 1, function(x) {
        id <- as.character(as.numeric(x[1]))
        features[[id]] <<- as.character(x[2])
    })
    features
}

getLabels <- function(labelsData) {
    # Extract the labels from the labels data as a list mapping label ids to
    # names.
    labelNames <- list()
    apply(labelsData, 1, function(x) {
        labelNames[[x[1]]] <<- makeLabelName(x[2])
    })
    labelNames
}

makeLabelName <- function(rawLabel) {
    # Create a label name from the raw label by spliting it by '_' and
    # capitalizing the first letter of each word
    nameParts <- strsplit(tolower(rawLabel), "_")[[1]]
    paste(
        toupper(substring(nameParts, 1, 1)),
        substring(nameParts, 2),
        sep="",
        collapse=" ")
}

getDataset <- function(zipFilename, type, features, labels) {
    # Fetch the feature vectors, labels and subjects from the dataset of the
    # provided type and return a data frame containing all the data.
    #
    # Arguments:
    #    zipFilename - the name of the zip file containing data files
    #    type - one of 'train' or 'test', representing the data set to fetch
    #    features - a list of features to consider. The tags are the feature ids
    #               and the values are the feature names
    #    labels - the list of label names where the tags are the label ids.
    #
    featuresDataset <- readData(zipFilename, sprintf("%s/X_%s.txt", type, type))
    featuresDataset <- featuresDataset[, as.numeric(names(features))]
    names(featuresDataset) <- as.character(features)

    labelsDataset <- readData(zipFilename, sprintf("%s/y_%s.txt", type, type))
    names(labelsDataset) <- c("Activity.Name")
    labelsDataset$Activity.Name <- as.character(
        labels[labelsDataset$Activity.Name])

    subjectsDataset <- readData(
        zipFilename,
        sprintf("%s/subject_%s.txt", type, type))
    names(subjectsDataset) <- c("Subject.Id")

    cbind(subjectsDataset, labelsDataset, featuresDataset)
}

processAveragesDataset <- function(dataset) {
    # Process the tidy dataset obtained at step 4 and return a new tidy data set
    # containing all the variables as required by step 5 of the assignment.
    #
    # Arguments:
    #    dataset - the tidy dataset as returned by processHARDataset
    #
}