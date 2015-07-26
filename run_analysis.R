##         Author:  Roger Palay
##        Purpose:  Programming assignment for Data Sciences: Get and Clean Data Course
##                  Coursera course from Johns Hopkins
##  Creation Date:  July 26, 2015
##
##  General Description
##  
##  We we given a description of a data set at 
##        http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
##  and a link to a zip file of the data set at 
##        https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
##  From that information we were to understand the data set structure and create one R script
##  that (quoted from the assignment):
##
##          1.  Merges the training and the test sets to create one data set.
##          2.  Extracts only the measurements on the mean and standard deviation for each measurement. 
##          3.  Uses descriptive activity names to name the activities in the data set
##          4   Appropriately labels the data set with descriptive variable names. 
##          5.  From the data set in step 4, creates a second, 
##              independent tidy data set with the average of each variable for each 
##              activity and each subject.
##
##  This is that script.  
##  
##  Method
##   
##  It is essential to note that the first thing this script does is to check to see if the 
##  data file noted above (the zip file) exists in the current working directory.  If it 
##  does not exist then the script will attempt to download it and extract the data files
##  from it.  
##       +-----------------------------------------------------------+
##       |This will create the directory structure that is required  |
##       | for the subsequent file reads.                            |
##       +-----------------------------------------------------------+
##  This also means that if the zip file was not present the script will still
##  overwrite any previous extracted directories and files.
##
##  Another essential note is that this script has built-in diagnostics and 
##  intermediate output.  This is controlled by the trace_level variable.  
##  If trace_level == 0 then no such diagnostic output is given.  
##  Higher values set into trace_level cause more information to be displayed.
##  The maximum effective value of trace_level is 9.
##
    trace_level<-0
    
##  The main task is to read the test and training data sets and to merge these. 
##  fortunately they have exactly the same structure and that means the same
##  column names.  We can assign these names prior to the merge. However,
##  in doing this appending we will want to keep these data rows 
##  identified as coming from the test or the training files.  Thus, prior to 
##  appending we will create a new column in each called train_test with values
##  set appropriately to "train" or "test".
##
##  Preliminary work:
##
##  We will want to use these packages later, but we will start off by installing
##  them and loading the respective libraries.  We will do this now because if there
##  is any problem doing so we might was well find out before we do anything else.

install.packages("plyr")
library(plyr)
install.packages("dplyr")
library(dplyr)

## Possibly get the zip file and unzip it.

if( !file.exists("getdata-projectfiles UCI-HAR Dataset.zip"))
{ download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
                mode="wb",destfile="getdata-projectfiles UCI-HAR Dataset.zip")
  unzip("getdata-projectfiles UCI-HAR Dataset.zip", junkpaths=FALSE)
}

## We can now assume that the files are there and that they are in the required
## directories with the required file names.  

top_dir <- "./UCI HAR Dataset/"

## The first file to read is the   features.txt file since it holds the names of 
## the columns in the two main files that we will read later.  These names are also
## used to get the subset of columns (the ones for mean and standard deviation) to 
## be moved to our tidy data.

features_filename <- paste(top_dir, "features.txt", sep="")
features<-read.table(features_filename,header=FALSE, as.is=TRUE)
if( trace_level > 5)
   { print("Head, Tail and structure of Features:")
     print (head(features) )
     print( tail(features) )
     str(features)
   }

all_column_names<-features$V2

which_col <- features[ grepl("-mean()",all_column_names) | grepl("-std()", all_column_names),]
if( trace_level > 5)
{ print("Head, Tail and structure of which_col:")
  print ( head(which_col) )
  print ( tail(which_col) )
  str(which_col)
}

## Now read the activity names in preparation for using them later

activity_filename <- paste(top_dir, "activity_labels.txt", sep="")
activities <- read.table(activity_filename,header=FALSE, as.is=TRUE)

if( trace_level > 5)
{ print("Head, Tail and structure of activities:")
  print ( head(activities) )
  print ( tail(activities) )
  str(activities)
}

##  We will handle the training data set first

##  Here we have three files that have important values.  The subject_train.txt 
##  file holds the subject number of each row of data in the X_train.txt file.
##  Likewise the y_train.txt file gives the activity for each row.  
##  After reading the huge X_train file we will assign column headings, then extract
##  just the columns that we want, then add columns for the subject number, the activity number,
##  and the train-test value.

train_dir <- paste(top_dir, "train/", sep="")
if (trace_level > 3 )
   { print ("working on the training portion of the data")}
y_activity_filename <- paste(train_dir, "y_train.txt", sep="")
y_activities <- read.table(y_activity_filename,header=FALSE, as.is=TRUE)
colnames( y_activities) <- "Activity"

if( trace_level > 5)
{ print("Head, Tail and structure of y_activities:")
  print ( head(y_activities) )
  print ( tail(y_activities) )
  str(y_activities)
}

subject_filename <- paste(train_dir, "subject_train.txt", sep="")
subjects <- read.table(subject_filename,header=FALSE, as.is=TRUE)
colnames( subjects) <- "Subject_Num"
if( trace_level > 5)
{ print("Head, Tail and structure of subjects:")
  print ( head(subjects) )
  print ( tail(subjects) )
  str(subjects)
}

x_train_filename <- paste(train_dir, "X_train.txt", sep="")
training <- read.table(x_train_filename,header=FALSE, as.is=TRUE)

if( trace_level > 5)
{ print("Head, Tail and structure of part of training:")
  num_cols <- ncol(training)
  print ( head(training[,c(1:4,(num_cols-3):num_cols)] ) )
  print ( tail(training[,c(1:4,(num_cols-3):num_cols)] ) )
  str(training[,c(1:4,(num_cols-3):num_cols)] )
}

## affix labels to all of the columns

colnames(training) <- all_column_names

if( trace_level > 5)
{ print("After adding labels, Head, Tail and structure of part of training:")
  num_cols <- ncol(training)
  print ( head(training[,c(1:4,(num_cols-3):num_cols)] ) )
  print ( tail(training[,c(1:4,(num_cols-3):num_cols)] ) )
  str(training[,c(1:4,(num_cols-3):num_cols)] )
}

## pull out just the desired columns

ms_training <- training[,which_col$V2]

if( trace_level > 5)
{ print("Head, Tail and structure of part of ms_training:")
  num_cols <- ncol(ms_training)
  print( dim(ms_training))
  print ( head(ms_training[,c(1:4,(num_cols-3):num_cols)] ) )
  print ( tail(ms_training[,c(1:4,(num_cols-3):num_cols)] ) )
  str(ms_training[,c(1:4,(num_cols-3):num_cols)] )
}

train_test<-rep("train",nrow(y_activities))
ms_training <- cbind( subjects, y_activities, train_test, ms_training)

if( trace_level > 5)
{ print("after merging columns Head, Tail and structure of part of ms_training:")
  num_cols <- ncol(ms_training)
  print( dim(ms_training))
  print ( head(ms_training[,c(1:7,(num_cols-3):num_cols)] ) )
  print ( tail(ms_training[,c(1:7,(num_cols-3):num_cols)] ) )
  str(ms_training[,c(1:7,(num_cols-3):num_cols)] )
}

## Now do the same things but for the test data

if (trace_level > 3 )
   { print ("working on the test portion of the data")}

test_dir <- paste(top_dir, "test/", sep="")

y_activity_filename <- paste(test_dir, "y_test.txt", sep="")
y_activities <- read.table(y_activity_filename,header=FALSE, as.is=TRUE)
colnames( y_activities) <- "Activity"

if( trace_level > 5)
{ print("Head, Tail and structure of y_activities:")
  print ( head(y_activities) )
  print ( tail(y_activities) )
  str(y_activities)
}

subject_filename <- paste(test_dir, "subject_test.txt", sep="")
subjects <- read.table(subject_filename,header=FALSE, as.is=TRUE)
colnames( subjects) <- "Subject_Num"
if( trace_level > 5)
{ print("Head, Tail and structure of subjects:")
  print ( head(subjects) )
  print ( tail(subjects) )
  str(subjects)
}

x_test_filename <- paste(test_dir, "X_test.txt", sep="")
testing <- read.table(x_test_filename,header=FALSE, as.is=TRUE)

if( trace_level > 5)
{ print("Head, Tail and structure of part of testing:")
  num_cols <- ncol(testing)
  print ( head(testing[,c(1:4,(num_cols-3):num_cols)] ) )
  print ( tail(testing[,c(1:4,(num_cols-3):num_cols)] ) )
  str(testing[,c(1:4,(num_cols-3):num_cols)] )
}

## affix labels to all of the columns

colnames(testing) <- all_column_names

if( trace_level > 5)
{ print("After adding labels, Head, Tail and structure of part of testing:")
  num_cols <- ncol(testing)
  print ( head(testing[,c(1:4,(num_cols-3):num_cols)] ) )
  print ( tail(testing[,c(1:4,(num_cols-3):num_cols)] ) )
  str(testing[,c(1:4,(num_cols-3):num_cols)] )
}

## pull out just the desired columns

ms_testing <- testing[,which_col$V2]

if( trace_level > 5)
{ print("Head, Tail and structure of part of ms_testing:")
  num_cols <- ncol(ms_testing)
  print( dim(ms_testing))
  print ( head(ms_testing[,c(1:4,(num_cols-3):num_cols)] ) )
  print ( tail(ms_testing[,c(1:4,(num_cols-3):num_cols)] ) )
  str(ms_testing[,c(1:4,(num_cols-3):num_cols)] )
}

train_test<-rep("test",nrow(y_activities))
ms_testing <- cbind( subjects, y_activities, train_test, ms_testing)

if( trace_level > 5)
{ print("after merging columns Head, Tail and structure of part of ms_testing:")
  num_cols <- ncol(ms_testing)
  print( dim(ms_testing))
  print ( head(ms_testing[,c(1:7,(num_cols-3):num_cols)] ) )
  print ( tail(ms_testing[,c(1:7,(num_cols-3):num_cols)] ) )
  str(ms_testing[,c(1:7,(num_cols-3):num_cols)] )
}

##  The next step is to append one of these, ms_training and mm_testing, to the other

newdf<-merge(ms_training,ms_testing,all=TRUE)

##  then change the Activity column to a name of the activity

newdf$Activity<-activities$V2[newdf$Activity]


if( trace_level > 5)
{ print("after merging rows and fixing activity Head, Tail and structure of part of newdf:")
  num_cols <- ncol(newdf)
  print( dim(newdf))
  print ( head(newdf[,c(1:7,(num_cols-3):num_cols)] ) )
  print ( tail(newdf[,c(1:7,(num_cols-3):num_cols)] ) )
  str(newdf[,c(1:7,(num_cols-3):num_cols)] )
}

if( trace_level > 5 )
{ write.table(newdf, file="newdf.txt", row.name=FALSE )}

##  The last task is to create a new tidy data set that
##  holds the average values for each subject and activity

tmp_sn <- select(newdf,1)
tmp_ac <- select(newdf,Activity)
vtmp_sn <- tmp_sn[,1]
vtmp_ac <- tmp_ac[,1]
suppressWarnings(newdfag <- aggregate( newdf,by=list(Subj_num=vtmp_sn,Action=vtmp_ac), FUN=mean))
newdfag_columns <- ncol(newdfag)
newdfag <- newdfag[,-(3:4)]

## we want to restore the values of test and train to the column train_test
##  the last time we set subjects it was the list of all subject numbers
##  assigned to the "test" data rows.  We can use that list.

tt<- unique(subjects[,1])
newdfag$train_test<-ifelse(newdfag$Subj_num %in% tt,"test","train")

## finally, we want to write out this tidy data set

write.table( newdfag, file="aggregate_data.txt", row.name=FALSE)

print("All Done...")