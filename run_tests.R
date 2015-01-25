library('RUnit')

# Define some mock data to be used in tests suites

var1.data <- rep(1:4, times = 3)
var2.data <- rep(10:13, times = 3)
var3.data <- rep(5:8, times = 3)

messy.dataset <- list(
    subjects = data.frame(V1 = rep(1:4, times = 3)),
    labels = data.frame(V1 = rep(1:3, times = 4)),
    features = data.frame(
        V1 = rep(1:4, times = 3),
        V2 = rep(10:13, times = 3),
        V3 = rep(5:8, times = 3)))

features <- data.frame(
    V1 = 1:3,
    V2 = c(
        "tBodyAcc-mean()-X",
        "tBodyAcc-energy()-Y",
        "tBodyAcc-std()-Z"),
    stringsAsFactors = FALSE)

labels <- data.frame(
    V1 = 1:3,
    V2 = c("WALKING", "SITTING", "LAYING"),
    stringsAsFactors = FALSE)

# Load and run the test suite

test.suite <- defineTestSuite(
    "Getting Data Project",
    dirs = file.path(getwd()),
    testFileRegexp = '^\\w+_test\\.R')

test.result <- runTestSuite(test.suite)

printTextProtocol(test.result)
