source("analysis.R")

test_makeLabelName <- function() {
    checkEquals(makeLabelName("WALKING"), "Walking")
    checkEquals(makeLabelName("WALKING_DOWNSTAIRS"), "Walking Downstairs")
}

test_getLabels <- function() {
    labelsData <- data.frame(
        id = c(1, 2, 3),
        name = c("WALKING", "WALKING_UPSTAIRS", "RUNNING"))

    checkEquals(
        getLabels(labelsData),
        list("1" = "Walking", "2" = "Walking Upstairs", "3" = "Running"))
}

test_getFeatures <- function() {
    featuresData <- data.frame(
        id = c(1, 5, 19, 43, 77),
        name = c(
            "tBodyAcc-mean()-X",
            "tBodyAcc-std()-Y",
            "tBodyAcc-energy()-Z",
            "tGravityAcc-mean()-Z",
            "tGravityAcc-arCoeff()-Z,4"))

    checkEquals(
        getFeatures(featuresData),
        list(
            "1" = "tBodyAcc-mean()-X",
            "5" = "tBodyAcc-std()-Y",
            "43" = "tGravityAcc-mean()-Z"))
}