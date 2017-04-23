---
title: "Getting and cleaning data - final project - Code Book"
output: github_document
---

This document is part of the final project for the Getting and Cleaning Data class.

The assignment requires to download data from 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones, and from them generate a new
tidy data set (here called "tidy_data.txt").

The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone.
Several kinds of motions data have been collected from 30 different subjects, performing 6 types of different activities
while carrying a smartphone embedded with motion sensors.

Info about the original data and the variables names are taken from the 
files "README.txt",  "activity_labels.txt" and "feature_info.txt" in the folder "UCI HAR Dataset".

========================================================================= 

# Description of transformations performed on the original data

The analysis was carried on performing the following operation on the original data set.


1. The original set of observation are collected in the files "X_test.txt" and "X_train.txt".
To each of those tables add: 
a first column with subject index for every observation, using the info contained in 
the file "subject_test.txt" ("subject_train.txt") and renamed "subject"; 
a second column with the activity type, using the info conteined 
in the file "y_test.txt"("y_train.txt") and renamed "label". 
Finally merge the train and test data set. We obtain  a table of 10299 observations and 563 variables.

2. Use the information contained in the file "features.txt" to select the variables containg only info on
mean value and standard deviation. We obtain  a table of 10299 observations and 68 variables.

3. In the second column, use descriptive activity names using the information
contained in the file "activity_labels.txt".

4. Rename the data set with descriptive variable names: 
first column "subject", second column "activity", the remaining variables named using 
the information in the file "features.txt".

5. For each variable compute average respect each activity and each subject.
Collect the data in a new table and save it as "tidy_data.txt".


# Description of the final data set

The "tidy_data.txt" consist in a table of 180 observations for  68 variables.

The variables are:

subject

activity

tBodyAcc-mean()-X

tBodyAcc-mean()-Y

tBodyAcc-mean()-Z

tBodyAcc-std()-X

tBodyAcc-std()-Y

tBodyAcc-std()-Z

tGravityAcc-mean()-X

tGravityAcc-mean()-Y

tGravityAcc-mean()-Z

tGravityAcc-std()-X

tGravityAcc-std()-Y

tGravityAcc-std()-Z

tBodyAccJerk-mean()-X

tBodyAccJerk-mean()-Y

tBodyAccJerk-mean()-Z

tBodyAccJerk-std()-X

tBodyAccJerk-std()-Y

tBodyAccJerk-std()-Z

tBodyGyro-mean()-X

tBodyGyro-mean()-Y

tBodyGyro-mean()-Z

tBodyGyro-std()-X

tBodyGyro-std()-Y

tBodyGyro-std()-Z

tBodyGyroJerk-mean()-X

tBodyGyroJerk-mean()-Y

tBodyGyroJerk-mean()-Z

tBodyGyroJerk-std()-X

tBodyGyroJerk-std()-Y

tBodyGyroJerk-std()-Z

tBodyAccMag-mean()

tBodyAccMag-std()

tGravityAccMag-mean()

tGravityAccMag-std()

tBodyAccJerkMag-mean()

tBodyAccJerkMag-std()

tBodyGyroMag-mean()

tBodyGyroMag-std()

tBodyGyroJerkMag-mean()

tBodyGyroJerkMag-std()

fBodyAcc-mean()-X

fBodyAcc-mean()-Y

fBodyAcc-mean()-Z

fBodyAcc-std()-X

fBodyAcc-std()-Y

fBodyAcc-std()-Z

fBodyAccJerk-mean()-X

fBodyAccJerk-mean()-Y

fBodyAccJerk-mean()-Z

fBodyAccJerk-std()-X

fBodyAccJerk-std()-Y

fBodyAccJerk-std()-Z

fBodyGyro-mean()-X

fBodyGyro-mean()-Y

fBodyGyro-mean()-Z

fBodyGyro-std()-X

fBodyGyro-std()-Y

fBodyGyro-std()-Z

fBodyAccMag-mean()

fBodyAccMag-std()

fBodyAccJerkMag-mean()

fBodyAccJerkMag-std()

fBodyGyroMag-mean()

fBodyGyroMag-std()

fBodyGyroJerkMag-mean()

fBodyGyroJerkMag-std().


#### Description of the variables
        

subject

$\qquad$ subject identifier, going from 1 to 30, for a total of 30 different subjects.

activity

$\qquad$ tipe of activity, can be one of the following:  "walking","walking upstairs","walking downstairs", "sitting", 
"standing", "laying".

The other 66 variables are created as follows: 

In the original data set this signals are used ('-XYZ' is used to denote 3-axial signals in the X, Y and Z directions):

tBodyAcc-XYZ

tGravityAcc-XYZ

tBodyAccJerk-XYZ

tBodyGyro-XYZ

tBodyGyroJerk-XYZ

tBodyAccMag

tGravityAccMag

tBodyAccJerkMag

tBodyGyroMag

tBodyGyroJerkMag

fBodyAcc-XYZ

fBodyAccJerk-XYZ

fBodyGyro-XYZ

fBodyAccMag

fBodyAccJerkMag

fBodyGyroMag

fBodyGyroJerkMag

To each of this signals the following functions are applied (in the original more, but we are interested only in this two):

mean(): Mean value
std(): Standard deviation

obtaining a total of 66 variables: 8 signals with 3 components + 9 signals with 1 conponet,
to each of those apply two functions.

Finally each of those variables is averaged on activity and subject: 30 subjects with 6 possible activities,
gives us a final dataset of 180 observations.
