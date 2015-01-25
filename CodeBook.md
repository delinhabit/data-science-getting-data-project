## Getting and Cleaning Data
### Course Project - CodeBook for AVGDataset.txt

The averages dataset represents the averages of a subset of measurements 
from the original dataset for each subject and each activity. Therefore the 
dataset contains 180 observations (30 subject x 6 activities) for 68 variables
explained in detail in the following sections.

#### Fixed variables

There are two fixed variables in the tidy dataset and they are presented in 
detail, in their exact order as found in the output file.

##### subject.id
_(integer)_

A integer value in the `[1..30]` interval representing the subject on which
the measurement was performed. 

The data was pulled from the original `train/subjects_train.txt` and 
`test/subjects_test.txt` files and was left as is.

##### activity.name
_(character)_

A character value representing the verbose name of the activity label.
The value can be one of:

* `Walking`
* `Walking Upstairs`
* `Walking Downstairs`
* `Sitting`
* `Standing`
* `Laying`

The label IDs where extracted from the `train/y_train.txt` and `test/y_test.txt` 
files. We then replaced them with their corresponding verbose names before 
merging the label data into the final dataset.

The verbose names were extracted from the `activity_labels.txt` file and were 
transformed as follows:

1. Made the names lowercase
2. Split in words by `_`
3. Capitalized the first letter of each word

#### Measurement variables

All the measurement variables are of _numeric_ type and represent the averages
of each corresponding measurements for each activity and each subject.

The measurements were loaded from the train and test datasets located in the 
`train/` and `test/` directories respectively, and were merged together into a
single dataset. 

For this analysis we required only the measurements of mean and standard 
deviations so we only selected the corresponding columns that contained
either `mean()` or `std()` in their names. This operation filtered only 66 of 
the 561 measurements.

The names of the measurement variables were tidied from the corresponding names 
found in the `features.txt` file as follows:

1. Split the name by any non-alphanumeric character
2. Removed empty parts
3. Joined the values together by dots (`.`)

This was necessary in order to ensure legal `R` names for the columns of the 
tidied dataset.

The following table presents all the measurement variables in their exact order
and the corresponding original feature name as found in `features.txt`.

Variable name   | Original feature name
--------------- | ---------------------
tBodyAcc.mean.X | tBodyAcc-mean()-X
tBodyAcc.mean.Y | tBodyAcc-mean()-Y
tBodyAcc.mean.Z | tBodyAcc-mean()-Z
tBodyAcc.std.X | tBodyAcc-std()-X
tBodyAcc.std.Y | tBodyAcc-std()-Y
tBodyAcc.std.Z | tBodyAcc-std()-Z
tGravityAcc.mean.X | tGravityAcc-mean()-X
tGravityAcc.mean.Y | tGravityAcc-mean()-Y
tGravityAcc.mean.Z | tGravityAcc-mean()-Z
tGravityAcc.std.X | tGravityAcc-std()-X
tGravityAcc.std.Y | tGravityAcc-std()-Y
tGravityAcc.std.Z | tGravityAcc-std()-Z
tBodyAccJerk.mean.X | tBodyAccJerk-mean()-X
tBodyAccJerk.mean.Y | tBodyAccJerk-mean()-Y
tBodyAccJerk.mean.Z | tBodyAccJerk-mean()-Z
tBodyAccJerk.std.X | tBodyAccJerk-std()-X
tBodyAccJerk.std.Y | tBodyAccJerk-std()-Y
tBodyAccJerk.std.Z | tBodyAccJerk-std()-Z
tBodyGyro.mean.X | tBodyGyro-mean()-X
tBodyGyro.mean.Y | tBodyGyro-mean()-Y
tBodyGyro.mean.Z | tBodyGyro-mean()-Z
tBodyGyro.std.X | tBodyGyro-std()-X
tBodyGyro.std.Y | tBodyGyro-std()-Y
tBodyGyro.std.Z | tBodyGyro-std()-Z
tBodyGyroJerk.mean.X | tBodyGyroJerk-mean()-X
tBodyGyroJerk.mean.Y | tBodyGyroJerk-mean()-Y
tBodyGyroJerk.mean.Z | tBodyGyroJerk-mean()-Z
tBodyGyroJerk.std.X | tBodyGyroJerk-std()-X
tBodyGyroJerk.std.Y | tBodyGyroJerk-std()-Y
tBodyGyroJerk.std.Z | tBodyGyroJerk-std()-Z
tBodyAccMag.mean | tBodyAccMag-mean()
tBodyAccMag.std | tBodyAccMag-std()
tGravityAccMag.mean | tGravityAccMag-mean()
tGravityAccMag.std | tGravityAccMag-std()
tBodyAccJerkMag.mean | tBodyAccJerkMag-mean()
tBodyAccJerkMag.std | tBodyAccJerkMag-std()
tBodyGyroMag.mean | tBodyGyroMag-mean()
tBodyGyroMag.std | tBodyGyroMag-std()
tBodyGyroJerkMag.mean | tBodyGyroJerkMag-mean()
tBodyGyroJerkMag.std | tBodyGyroJerkMag-std()
fBodyAcc.mean.X | fBodyAcc-mean()-X
fBodyAcc.mean.Y | fBodyAcc-mean()-Y
fBodyAcc.mean.Z | fBodyAcc-mean()-Z
fBodyAcc.std.X | fBodyAcc-std()-X
fBodyAcc.std.Y | fBodyAcc-std()-Y
fBodyAcc.std.Z | fBodyAcc-std()-Z
fBodyAccJerk.mean.X | fBodyAccJerk-mean()-X
fBodyAccJerk.mean.Y | fBodyAccJerk-mean()-Y
fBodyAccJerk.mean.Z | fBodyAccJerk-mean()-Z
fBodyAccJerk.std.X | fBodyAccJerk-std()-X
fBodyAccJerk.std.Y | fBodyAccJerk-std()-Y
fBodyAccJerk.std.Z | fBodyAccJerk-std()-Z
fBodyGyro.mean.X | fBodyGyro-mean()-X
fBodyGyro.mean.Y | fBodyGyro-mean()-Y
fBodyGyro.mean.Z | fBodyGyro-mean()-Z
fBodyGyro.std.X | fBodyGyro-std()-X
fBodyGyro.std.Y | fBodyGyro-std()-Y
fBodyGyro.std.Z | fBodyGyro-std()-Z
fBodyAccMag.mean | fBodyAccMag-mean()
fBodyAccMag.std | fBodyAccMag-std()
fBodyBodyAccJerkMag.mean | fBodyBodyAccJerkMag-mean()
fBodyBodyAccJerkMag.std | fBodyBodyAccJerkMag-std()
fBodyBodyGyroMag.mean | fBodyBodyGyroMag-mean()
fBodyBodyGyroMag.std | fBodyBodyGyroMag-std()
fBodyBodyGyroJerkMag.mean | fBodyBodyGyroJerkMag-mean()
fBodyBodyGyroJerkMag.std | fBodyBodyGyroJerkMag-std()
