# Getting and Cleaning Data
## Course Project

This repository contains the project files for the
[Getting an Cleaning Data](https://www.coursera.org/course/getdata) course project
in the [Data Science](https://www.coursera.org/specialization/jhudatascience/1)
specialization.

### Assignment definition

The purpose of this project is to demonstrate your ability to collect, work with,
and clean a data set. The goal is to prepare tidy data that can be used for
later analysis.

One of the most exciting areas in all of data science right now is wearable
computing - see for example [this article](http://www.insideactivitytracking.com/data-science-activity-tracking-and-the-battle-for-the-worlds-top-sports-brand/). Companies
like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced
algorithms to attract new users. The data linked to from the course website
represent data collected from the accelerometers from the Samsung Galaxy S
smartphone.

A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

You should create one `R` script called `run_analysis.R` that does the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set
with the average of each variable for each activity and each subject.

### Project structure

The project is organized in two parts: the `R` and help files plus a `data/`
directory which is created automatically when you run the analysis.

Here is a brief explanation of all the `R` and help files which are
available in this project:

* __CodeBook.md__ The code book file that describes the variables, the data,
and any transformations or work that was performed to clean up the data
* __analysis.R__ The support functions for performing the analysis and tidying
of the data
* __io.R__ Utility functions for input/output, including for downloading the
original data and caching it on the local filesystem
* __run_analysis.R__ The R script for running the analysis
* *___test.R__ Test suites for each of the `*.R` files that contains testable
units of code
* __run_tests.R__ The R script for running the test suites defined in the
`*_test.R` files

### The test suite

Only the I/O code paths are not unit tested. Everything else is tested
individually to cover as many possible cases as possible.

Run the test suite by using the following command at the command promopt:

```bash
$ Rscript run_tests.R
```

If there are no errors you should be ready to run the analysis as the core
functionality is ensured to be correct.

### Running the analysis

```bash
$ Rscript run_analysis.R
```

When you run the analysis the first time, a new `data/` directory will be
created that will cache the original file and will hold the output files.

When the processing is done, the script will save the two created datasets into
individual files as explained below:

* __data/UCI_HAR_Dataset.zip__ The original dataset downloaded from the URL
that was provided in the assignment. This file acts as a local cache for the
analysis script and will be downloaded only once
* __data/HARDataset.txt__ The tidy dataset as required by the 4th step of the
assignment
* __data/AVGDataset.txt__ The tidy dataset that contains averages of each
variable for each activity and each subject as required by step 5 of the
assignment. The dataset is explained in detail in this [CodeBook](CodeBook.md)
