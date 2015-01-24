source("analysis.R")

test_getLabels <- function() {
    filename <- tempfile(fileext = ".txt")
    conn <- file(filename, "w")
    writeLines(c("1 WALKING", "2 LAYING", "3 RUNNING"), conn)
    close(conn)

    labels <- getLabels(file(filename, "r"))
    unlink(filename)

    checkEquals(labels, list("1" = "Walking", "2" = "Laying", "3" = "Running"))
}

test_getFeatures <- function() {
    filename <- tempfile(fileext = ".txt")
    conn <- file(filename, "w")
    writeLines(
        c(" 1 tBodyAcc-mean()-X",
          " 5 tBodyAcc-std()-Y",
          "19 tBodyAcc-energy()-Z",
          "43 tGravityAcc-mean()-Z",
          "77 tGravityAcc-arCoeff()-Z,4"),
        conn)
    close(conn)

    features <- getFeatures(file(filename, "r"))
    message(str(features))
    unlink(filename)

    checkEquals(
        features,
        list(
            "1" = "tBodyAcc-mean()-X",
            "5" = "tBodyAcc-std()-Y",
            "43" = "tGravityAcc-mean()-Z"))
}