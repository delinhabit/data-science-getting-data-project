downloadData <- function(url, filename = NULL) {
    # Download the data from the provided URL and return the path to the
    # downloaded file.
    #
    # Arguments
    #    url - the URL from wich to download the data file
    #    as - the optional name of the destination file.
    #         If not provided we will infer the name from the URL
    #
    if (!file.exists("data")) {
        dir.create("data")
    }

    if (is.null(filename)) {
        filename <- inferFilenameFromUrl(url)
    }

    destfile = paste(c("data", filename), collapse="/")
    if (!file.exists(destfile)) {
        download.file(url, destfile = destfile, method = "curl")
    }

    destfile
}

inferFilenameFromUrl <- function(url) {
    # Infer the filename from the provided URL
    # Handles properly normal filenames but also urlencoded paths
    parts <- strsplit(url, "/", fixed = T)[[1]]
    filename.part <- parts[[length(parts)]]

    filename.parts <- strsplit(URLdecode(filename.part), "/", fixed = T)[[1]]
    filename <- filename.parts[[length(filename.parts)]]
    gsub(" ", "_", filename)
}

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
