library('RUnit')

test.suite <- defineTestSuite(
    "Getting Data Project",
    dirs = file.path(getwd()),
    testFileRegexp = '^\\w+_test\\.R')

test.result <- runTestSuite(test.suite)

printTextProtocol(test.result)
