processHARDataset <- function(dataFile) {
    data.frame()
}

saveHARDataset <- function(dataSet, file) {
    # Save the provided dataSet to a text file.
    #
    # Arguments:
    #    dataSet - the `data.frame` to save
    #    file - the path to the file in which to save the data
    write.table(dataSet, file = file, row.names = FALSE)
}