#Codebook for Data Science: Getting and Cleaning Data Project
*Created by Roger Palay
*Created on July 26, 2015

##General Overview

The table produced by the run_analysis.R script contains 82 variables
and 180 observations on those variables.  The table was written to 
a file called aggregate.csv whith the parameters row.name=FALSE, sep=",".
In particular, there is a full header line in that file with the
variable names identical to the names given below.

The variables fall into two groups.  The first group, comprising the first three
variables, Subj_num, Action, and train_test, identify the particular subject and
the particular action that was being measured along with an indicator of whether
this subject was part of the training or the test subgroup.  The subsequent 79
variables aree all computed mean values for the corresponding variables in the
original data set.  This, for example, the variable "tBodyAcc-mean()-X" holds the 
mean of all the values in the original data set under that same vaiable name and
for the particular subject and activity (Action as it is called here). Thus, 
"tBodyAcc-mean()-X" in this data set is really the mean of the means reported in the
original data set.  Or, the
variable "tBodyAcc-std()-X" holds the mean of all the values in the original data 
set under that same vaiable name and
for the particular subject and activity (Action as it is called here).

##Identification variables
```
Subj_num
  Holds the number assigned to the subject in the original data
Action
  Holds the name of the activity being performed for the original data
train_test
  Holds the value "train" if this subject was in the training group, or it
  holds the value "test" if this subject was in the test group
```

##Computed variables


Each of the following variables holds the computed mean of the variables 
with the same name in the original data set, where the mean is for the 
values for a particuar subject and a particular activity.
The deeper meanings and units for those
variables will be found in the documentation of the original data set.
The justification for maintaining the variable names as they we used
in the original set is in the README.md file.
```
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
fBodyAcc-meanFreq()-X
fBodyAcc-meanFreq()-Y
fBodyAcc-meanFreq()-Z
fBodyAccJerk-mean()-X
fBodyAccJerk-mean()-Y
fBodyAccJerk-mean()-Z
fBodyAccJerk-std()-X
fBodyAccJerk-std()-Y
fBodyAccJerk-std()-Z
fBodyAccJerk-meanFreq()-X
fBodyAccJerk-meanFreq()-Y
fBodyAccJerk-meanFreq()-Z
fBodyGyro-mean()-X
fBodyGyro-mean()-Y
fBodyGyro-mean()-Z
fBodyGyro-std()-X
fBodyGyro-std()-Y
fBodyGyro-std()-Z
fBodyGyro-meanFreq()-X
fBodyGyro-meanFreq()-Y
fBodyGyro-meanFreq()-Z
fBodyAccMag-mean()
fBodyAccMag-std()
fBodyAccMag-meanFreq()
fBodyBodyAccJerkMag-mean()
fBodyBodyAccJerkMag-std()
fBodyBodyAccJerkMag-meanFreq()
fBodyBodyGyroMag-mean()
fBodyBodyGyroMag-std()
fBodyBodyGyroMag-meanFreq()
fBodyBodyGyroJerkMag-mean()
fBodyBodyGyroJerkMag-std()
fBodyBodyGyroJerkMag-meanFreq()
```