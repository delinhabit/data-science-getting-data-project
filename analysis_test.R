source("analysis.R")

test_tidyLabelName <- function() {
    checkEquals(tidyLabelName("WALKING"), "Walking")
    checkEquals(tidyLabelName("WALKING_DOWNSTAIRS"), "Walking Downstairs")
}

test_tidyFeatureName <- function() {
    checkEquals(tidyFeatureName("tBodyAcc-mean()-X"), "tBodyAcc.mean.X")
    checkEquals(
        tidyFeatureName("tGravityAcc-arCoeff()-Z,4"),
        "tGravityAcc.arCoeff.Z.4")
    checkEquals(
        tidyFeatureName("tBodyAccJerkMag-arCoeff()4"),
        "tBodyAccJerkMag.arCoeff.4")
    checkEquals(
        tidyFeatureName("fBodyAcc-bandsEnergy()-49,64"),
        "fBodyAcc.bandsEnergy.49.64")
    checkEquals(
        tidyFeatureName("angle(tBodyAccMean,gravity)"),
        "angle.tBodyAccMean.gravity")
}

test_tidyLabels <- function() {
    labels.data <- data.frame(
        V1 = c(1, 2, 3),
        V2 = c("WALKING", "WALKING_UPSTAIRS", "RUNNING"),
        stringsAsFactors = FALSE)

    checkEquals(
        tidyLabels(labels.data),
        data.frame(
            id = c(1, 2, 3),
            name = c("Walking", "Walking Upstairs", "Running"),
            stringsAsFactors = FALSE))
}

test_tidyFeatures <- function() {
    features.data <- data.frame(
        V1 = c(1, 19, 44, 77),
        V2 = c(
            "tBodyAcc-mean()-X",
            "tBodyAcc-energy()-Z",
            "tGravityAcc-std()-X",
            "tGravityAcc-arCoeff()-Z,4"),
        stringsAsFactors = FALSE)

    checkEquals(
        tidyFeatures(features.data),
        data.frame(
            id = c(1, 44),
            name = c("tBodyAcc.mean.X", "tGravityAcc.std.X"),
            stringsAsFactors = FALSE))
}

test_tidyDataset <- function() {
    # The messy.dataset, features and labels variables are defined in the test
    # runner script so that they are available here
    features <- tidyFeatures(features)
    labels <- tidyLabels(labels)

    checkEquals(
        tidyDataset(messy.dataset, features, labels),
        data.frame(
            subject.id = rep(1:4, times = 3),
            activity.name = rep(c("Walking", "Sitting", "Laying"), times = 4),
            tBodyAcc.mean.X = rep(1:4, times = 3),
            tBodyAcc.std.Z = rep(5:8, times = 3),
            stringsAsFactors = FALSE))
}

test_processDataset <- function() {
    # The messy.dataset, features and labels variables are defined in the test
    # runner script so that they are available here
    checkEquals(
        processDataset(messy.dataset, messy.dataset, features, labels),
        data.frame(
            subject.id = rep(1:4, times=6),
            activity.name = rep(c("Walking", "Sitting", "Laying"), times = 8),
            tBodyAcc.mean.X = rep(1:4, times = 6),
            tBodyAcc.std.Z = rep(5:8, times = 6),
            stringsAsFactors = FALSE))
}

test_processAveragesDataset <- function() {
    dataset <- processDataset(messy.dataset, messy.dataset, features, labels)

    checkEquals(
        processAveragesDataset(dataset),
        data.frame(
            subject.id = rep(1:4, each=3),
            activity.name = rep(c("Laying", "Sitting", "Walking"), times = 4),
            tBodyAcc.mean.X = rep(1:4, each=3),
            tBodyAcc.std.Z = rep(5:8, each=3),
            stringsAsFactors = FALSE))
}
