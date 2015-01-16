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