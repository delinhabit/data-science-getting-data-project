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
    labelsData <- data.frame(
        V1 = c(1, 2, 3),
        V2 = c("WALKING", "WALKING_UPSTAIRS", "RUNNING"),
        stringsAsFactors = FALSE)

    checkEquals(
        tidyLabels(labelsData),
        data.frame(
            id = c(1, 2, 3),
            name = c("Walking", "Walking Upstairs", "Running"),
            stringsAsFactors = FALSE))
}

test_tidyFeatures <- function() {
    featuresData <- data.frame(
        V1 = c(1, 19, 44, 77),
        V2 = c(
            "tBodyAcc-mean()-X",
            "tBodyAcc-energy()-Z",
            "tGravityAcc-std()-X",
            "tGravityAcc-arCoeff()-Z,4"),
        stringsAsFactors = FALSE)

    checkEquals(
        tidyFeatures(featuresData),
        data.frame(
            id = c(1, 44),
            name = c("tBodyAcc.mean.X", "tGravityAcc.std.X"),
            stringsAsFactors = FALSE))
}