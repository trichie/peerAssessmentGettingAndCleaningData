peerAssessmentGettingAndCleaningData
====================================

Requirements for running the script:
* The data must be unzipped in the working directory and the directory structure within the data was not changed, i.e. the folder UCI HAR Dataset should be directly in the working directory.

... 

The script consists of the following parts:

* Loading activity labels and feature list
* Loading the test data and setting labels
* Loading the training data and setting labels
* Selecting only the columns containing means or standard deviations. This is achieved with grepl by selecting all columns that contain "-mean but not -meanF (didn't want meanFrequency)" or "-std" 
* cBinding subject data, selected columns of test data and activity data, followed by a merge to get proper names for activities creates the test data set
* dito for training data set
* rBinding test data set and training data set creates required tidy data set
* writing tidy data set to disk
* grouping of means is performed by using data.table functionality and lapply
* sorting data set with grouped means is sorted by subject and activity and writing it to disk
