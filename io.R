readData <- function(zipFilename, filename) {
    # Read the data located in the provided file inside the zip archive and
    # return a `dplyr::tbl_df` instance.
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

saveData <- function(dataset, filename) {
    # Save the dataset to the provided file.
    #
    # Arguments:
    #    dataset - the dataset to save
    #    filename - the name of the file to store the dataset
    #
    write.table(dataset, file = filename, row.names = FALSE)
}
