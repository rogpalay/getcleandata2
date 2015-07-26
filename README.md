#README file for the course projecct


           Author:  Roger Palay
          Purpose:  Programming assignment for Data Sciences: Get and Clean Data
                    Coursera course from Johns Hopkins
    Creation Date:  July 26, 2015
  
    General Description
    
    We we given a description of a data set at 
          http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
    and a link to a zip file of the data set at 
          https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
    From that information we were to understand the data set structure and create one R script
    that (quoted from the assignment):
  
            1.  Merges the training and the test sets to create one data set.
            2.  Extracts only the measurements on the mean and standard deviation for each measurement. 
            3.  Uses descriptive activity names to name the activities in the data set
            4   Appropriately labels the data set with descriptive variable names. 
            5.  From the data set in step 4, creates a second,
                independent tidy data set with the average of each variable for each
                activity and each subject.
  
    That script is to be named run_analysis.R
    
##Method
     
    It is essential to note that the first thing this script does is to check to see if the 
    data file noted above (the zip file) exists in the current working directory.  If it
    does not exist then the script will attempt to download it and extract the data files
    from it.  
         +-----------------------------------------------------------+
         |This will create the directory structure that is required  |
         | for the subsequent file reads.                            |
         +-----------------------------------------------------------+
    This also means that if the zip file was not present the script will still
    overwrite any previous extracted directories and files.
  
    Another essential note is that this script has built-in diagnostics and 
    intermediate output.  This is controlled by the trace_level variable.  
    If trace_level == 0 then no such diagnostic output is given.  
    Higher values set into trace_level cause more information to be displayed.
    The maximum effective value of trace_level is 9.
  
    The trace level is set at line 44 of the script:  trace_level<-0
    
    The main task is to read the test and training data sets and to merge these. 
    fortunately they have exactly the same structure and that means the same
    column names.  We can assign these names prior to the merge. However,
    in doing this appending we will want to keep these data rows
    identified as coming from the test or the training files.  Thus, prior to 
    appending we will create a new column in each called train_test with values
    set appropriately to "train" or "test".
    
    The main outcome of the script is the creation and subsequent writing of a tidy 
    data set, internally called newdfag and externally found in the file aggregate.csv,
    that contains the mean values, by subject and activity,  for all of the columns 
    in the original set that were either "mean()" or "std()" columns.  There are 79 such 
    columns (excluding the "angle" columns whose values could be computed anew from
    the included columns if need be). Since there were 30 subject and each subject
    performed six different tasks (activities or actions), there are 180 resulting
    rows in the "tidy" data set.  
    
    Besides keeping the subject number and the name of the activity (action), I took
    the opportunity to also record if the subject was in the training or the test 
    original data set.  I felt that it was important to maintain that information 
    even though it does mean that it is repeated in each of the six rows for each 
    subject.  It seems to be a small price to pay to maintain the information within
    the data set.
    
##Output

    The main output of the run_analysis.R script is a file called aggregate_data.txt
    in the working diectory.  That file can be read via the command
    
    newdf<-read.table("aggregate_data.txt", as.is=TRUE,header=TRUE)
    
    If the trace_level is 6 or more, then there is also an intermediate file
    that is created, called newdf.txt, also in the working directory.  This
    file holds the data frame of the merged and assembled data before the 
    aggregation was done.
    

##Decision on form of the tidy data

    A case could be made for structuring this tidy data as just four variables:
    Subject number, Activity, measurement type, mean value
    especially since the only real computed values are the 180*79 means.  This
    would entail converting the original column names, possibly modified,
    to be entries in the "measurement type" variable.  
    
    The form of the dataframe used here is a wider version where we retain the
    different measurement items as columns, resulting in 180  rows with
    each row containing, besides the identifying variables, 79 items for the
    79 different measurement types.  This decision was made in part because we
    have no indication of any subsequent processing on this data, in part 
    because it makes the resulting able easier to read (tracking across a row
    to see all of the mean values for a subject-activity pair), and in part
    because it just falls out of the analysis.  
   

##Decision on variable names

    The variable names for the 79 measurement type variables are identical to 
    the names used in the original data set.  This was done on purpose.  It 
    would have been possible, and it could have been done with minimal effort,
    to prepend some text such as "mean of ", or even "mean for subject-activity pair of"
    to each of the original names.  Such added text would have made the names slightly
    more meaningful since the values for those variables are the means of the
    original values, not the same as the original values.  
    
    However, given that we expect the user of this data to know where the data
    originated, and that the goal was to obtain all of these means, it seemed more
    reasonable to maintain the names exactly as they had appeared in the original
    data. This would also facilitate a "cross-walk" between the values in this
    new data set and the values in the original if that became necessary.


