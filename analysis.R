library(dplyr)
library(reshape2)

processDataset <- function(train.dataset, test.dataset, features, labels) {
    # Process the messy UCI HAR dataset as required by step 4 of the assignment.
    #
    # Arguments:
    #    train.dataset - a list of data frames containing the train dataset
    #    test.dataset - a list of data frames containing the test dataset
    #    features - a data frame containing the feature names
    #    labels - a data frame containing the label names
    #
    # train.dataset and test.dataset are expected to contain the following
    # tags: subjects, labels and features, pointing to the corresponding data
    # frames
    #
    features <- tidyFeatures(features)
    labels <- tidyLabels(labels)

    trainDataset <- tidyDataset(train.dataset, features, labels)
    testDataset <- tidyDataset(test.dataset, features, labels)
    bind_rows(trainDataset, testDataset)
}

processAveragesDataset <- function(dataset) {
    # Process the tidy dataset obtained at step 4 and return a new tidy data set
    # containing averages of each variable for each activity and each subject.
    #
    # Arguments:
    #    dataset - the tidy dataset as returned by processHARDataset
    dataset %>%
        melt(id.vars = c("subject.id", "activity.name")) %>%
        group_by(subject.id, activity.name, variable) %>%
        dcast(subject.id + activity.name ~ variable, mean)
}

tidyFeatures <- function(features.data) {
    # Tidy the features dataset as read from the features file to provide better
    # column names and to transform the names using tidyFeatureName.
    #
    # We also retain only the features that contain mean() and std() in their
    # name as required by the assignment.
    features.data %>%
        rename(id = V1, name = V2) %>%
        filter(
            grepl("mean()", name, fixed = T) |
            grepl("std()", name, fixed = T)
        ) %>%
        rowwise() %>%
        mutate(name = tidyFeatureName(name))
}

tidyFeatureName <- function(raw.feature.name) {
    # Create a feature name from the raw feature by splitting by
    # non-alphanumeric characters and pasting the parts back by dots
    name.parts <- strsplit(raw.feature.name, split="[^[:alnum:]]")[[1]]
    name.parts <- name.parts[name.parts != ""]
    paste(name.parts, collapse=".")
}

tidyLabels <- function(labels.data) {
    # Tidy the labels dataset as read from the labels file to provide better
    # column names and to transform the names using makeLabelName.
    labels.data %>%
        rename(id = V1, name = V2) %>%
        rowwise() %>%
        mutate(name = tidyLabelName(name))
}

tidyLabelName <- function(raw.label.name) {
    # Create a label name from the raw label by spliting it by '_' and
    # capitalizing the first letter of each word
    name.parts <- strsplit(tolower(raw.label.name), "_")[[1]]
    paste(
        toupper(substring(name.parts, 1, 1)),
        substring(name.parts, 2),
        sep="",
        collapse=" ")
}

tidyDataset <- function(messy.dataset, features, labels) {
    # Tidy the messy model dataset composed of subjects, labels and feature
    # vectors into a single tidy data frame.
    subjects.dataset <- messy.dataset$subjects %>% select(subject.id = V1)

    labels.dataset <- messy.dataset$labels %>%
        inner_join(labels, by = c("V1" = "id")) %>%
        select(activity.name = name)

    features.dataset <- messy.dataset$features[, features$id]
    names(features.dataset) <- features$name

    bind_cols(subjects.dataset, labels.dataset, features.dataset)
}
