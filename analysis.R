library(dplyr)

processHARDataset <- function(zipFilename) {
    # Process the UCI HAR dataset located in the provided file and create a
    # tidy dataset as required by step 4 ot the assignment
    #
    # Arguments:
    #    zipFilename - path to the zip file containing the UCI HAR Dataset
    #
    features <- tidyFeatures(readData(zipFilename, "features.txt"))
    labels <- tidyLabels(readData(zipFilename, "activity_labels.txt"))

    trainDataset <- tidyDataset(zipFilename, "train", features, labels)
    testDataset <- tidyDataset(zipFilename, "test", features, labels)
    bind_rows(trainDataset, testDataset)
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
    tbl_df(read.table(conn, stringsAsFactors = FALSE))
}

tidyFeatures <- function(featuresData) {
    # Tidy the features dataset as read from the features file to provide better
    # column names and to transform the names using tidyFeatureName.
    #
    # We also retain only the features that contain mean() and std() in their
    # name as required by the assignment.
    featuresData %>%
        rename(id = V1, name = V2) %>%
        filter(
            grepl("mean()", name, fixed = T) |
            grepl("std()", name, fixed = T)
        ) %>%
        rowwise() %>%
        mutate(name = tidyFeatureName(name))
}

tidyFeatureName <- function(rawFeatureName) {
    # Create a feature name from the raw feature by splitting by
    # non-alphanumeric characters and pasting the parts back by dots
    nameParts <- strsplit(rawFeatureName, split="[^[:alnum:]]")[[1]]
    nameParts <- nameParts[nameParts != ""]
    paste(nameParts, collapse=".")
}

tidyLabels <- function(labelsData) {
    # Tidy the labels dataset as read from the labels file to provide better
    # column names and to transform the names using makeLabelName.
    labelsData %>%
        rename(id = V1, name = V2) %>%
        rowwise() %>%
        mutate(name = tidyLabelName(name))
}

tidyLabelName <- function(rawLabelName) {
    # Create a label name from the raw label by spliting it by '_' and
    # capitalizing the first letter of each word
    nameParts <- strsplit(tolower(rawLabelName), "_")[[1]]
    paste(
        toupper(substring(nameParts, 1, 1)),
        substring(nameParts, 2),
        sep="",
        collapse=" ")
}

tidyDataset <- function(zipFilename, type, features, labels) {
    # Fetch the feature vectors, labels and subjects from the dataset of the
    # provided type and return a tidy dataset for all the required data.
    #
    # Arguments:
    #    zipFilename - the name of the zip file containing data files
    #    type - one of 'train' or 'test', representing the data set to fetch
    #    features - the dataset of features
    #    labels - the dataset of labels
    #
    subjectsDataset <-
        readData(zipFilename, sprintf("%s/subject_%s.txt", type, type)) %>%
        select(Subject.Id = V1)

    labelsDataset <-
        readData(zipFilename, sprintf("%s/y_%s.txt", type, type)) %>%
        inner_join(labels, by = c("V1" = "id")) %>%
        select(Activity.Name = name)

    featuresDataset <- readData(zipFilename, sprintf("%s/X_%s.txt", type, type))
    featuresDataset <- featuresDataset[, features$id]
    names(featuresDataset) <- features$name

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