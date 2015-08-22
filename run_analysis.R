# clear out workspace
rm(list = ls())
gc()

# check if dataset is downloaded, otherwise download
if(!file.exists('getdata_projectfiles_UCI HAR Dataset.zip'))
{
   download.file(url="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
                 destfile = "getdata_projectfiles_UCI HAR Dataset.zip", mode = "wb")
}

# unpack data and overwrite to prevent using modified data
unzip("./getdata_projectfiles_UCI HAR Dataset.zip")
setwd('./UCI HAR Dataset')

# Load up datasets
testData <- read.table("./test/X_test.txt")
testLabels <- read.table("./test/Y_test.txt")
testSubjects <- read.table("./test/subject_test.txt")
trainData <- read.table("./train/X_train.txt")
trainLabels <- read.table("./train/Y_train.txt")
trainSubjects <- read.table("./train/subject_train.txt")
activityLabels <- read.table("./activity_labels.txt")
feats <- read.delim("./features.txt", header=FALSE, sep="")

# Add labels to the datasets
trainData <- cbind(trainData, trainLabels, trainSubjects)
testData <- cbind(testData, testLabels, testSubjects)

# Merge together datasets and add column names to data
mergeData <- rbind(trainData, testData)
mycolnames <- as.character(feats[,2])
mycolnames <- c(mycolnames, "Activity", "Subject")
colnames(mergeData) <- factor(mycolnames)

# Determine which columns contain mean() or std()
meanIndices <- numeric()
for (n in 1:nrow(feats))
{
  if (length(grep("mean()", feats[n,2], value="TRUE", fixed=TRUE) ) > 0)
  {
    meanIndices <- c(meanIndices, n)
  }
}

stdIndices <- numeric()
for (n in 1:nrow(feats))
{
  if (length(grep("std()", feats[n,2], value="TRUE", fixed=TRUE) ) > 0)
  {
    stdIndices <- c(stdIndices, n)
  }
}

# Filter data to mean and std values
filterIndices <- c(meanIndices, stdIndices,length(mycolnames)-1,length(mycolnames))
filterData <- mergeData[,filterIndices]

# Uses descriptive activity names to name the activities in the data set
filterData$Activity <- as.factor(filterData$Activity)
levels(filterData$Activity) <- as.character(activityLabels[,2])

rm(mergeData)

# Appropriately label the data set with descriptive variable names
library(dplyr)

## Rename means

filterData <- rename(filterData, `Avg Body Acceleration In X` = `tBodyAcc-mean()-X`)
filterData <- rename(filterData, `Avg Body Acceleration In Y` = `tBodyAcc-mean()-Y`)
filterData <- rename(filterData, `Avg Body Acceleration In Z` = `tBodyAcc-mean()-Z`)

filterData <- rename(filterData, `Avg Gravity Acceleration In X` = `tGravityAcc-mean()-X`)
filterData <- rename(filterData, `Avg Gravity Acceleration In Y` = `tGravityAcc-mean()-Y`)
filterData <- rename(filterData, `Avg Gravity Acceleration In Z` = `tGravityAcc-mean()-Z`)

filterData <- rename(filterData, `Avg Body Acceleration Jerk In X` = `tBodyAccJerk-mean()-X`)
filterData <- rename(filterData, `Avg Body Acceleration Jerk In Y` = `tBodyAccJerk-mean()-Y`)
filterData <- rename(filterData, `Avg Body Acceleration Jerk In Z` = `tBodyAccJerk-mean()-Z`)

filterData <- rename(filterData, `Avg Body Gyro In X` = `tBodyGyro-mean()-X`)
filterData <- rename(filterData, `Avg Body Gyro In Y` = `tBodyGyro-mean()-Y`)
filterData <- rename(filterData, `Avg Body Gyro In Z` = `tBodyGyro-mean()-Z`)

filterData <- rename(filterData, `Avg Body Gyro Jerk In X` = `tBodyGyroJerk-mean()-X`)
filterData <- rename(filterData, `Avg Body Gyro Jerk In Y` = `tBodyGyroJerk-mean()-Y`)
filterData <- rename(filterData, `Avg Body Gyro Jerk In Z` = `tBodyGyroJerk-mean()-Z`)

filterData <- rename(filterData, `Avg Magnitude of Body Acceleration` = `tBodyAccMag-mean()`)
filterData <- rename(filterData, `Avg Magnitude of Gravity Acceleration` = `tGravityAccMag-mean()`)
filterData <- rename(filterData, `Avg Magnitude of Body Acceleration Jerk` = `tBodyAccJerkMag-mean()`)
filterData <- rename(filterData, `Avg Magnitude of Body Gyro` = `tBodyGyroMag-mean()`)
filterData <- rename(filterData, `Avg Magnitude of Body Gyro Jerk` = `tBodyGyroJerkMag-mean()`)

filterData <- rename(filterData, `Fourier Response of Avg Body Acceleration In X` = `fBodyAcc-mean()-X`)
filterData <- rename(filterData, `Fourier Response of Avg Body Acceleration In Y` = `fBodyAcc-mean()-Y`)
filterData <- rename(filterData, `Fourier Response of Avg Body Acceleration In Z` = `fBodyAcc-mean()-Z`)

filterData <- rename(filterData, `Fourier Response of Avg Body Acceleration Jerk In X` = `fBodyAccJerk-mean()-X`)
filterData <- rename(filterData, `Fourier Response of Avg Body Acceleration Jerk In Y` = `fBodyAccJerk-mean()-Y`)
filterData <- rename(filterData, `Fourier Response of Avg Body Acceleration Jerk In Z` = `fBodyAccJerk-mean()-Z`)

filterData <- rename(filterData, `Fourier Response of Avg Body Gyro In X` = `fBodyGyro-mean()-X`)
filterData <- rename(filterData, `Fourier Response of Avg Body Gyro In Y` = `fBodyGyro-mean()-Y`)
filterData <- rename(filterData, `Fourier Response of Avg Body Gyro In Z` = `fBodyGyro-mean()-Z`)

filterData <- rename(filterData, `Fourier Response of Avg Magnitude of Body Acceleration` = `fBodyAccMag-mean()`)
filterData <- rename(filterData, `Fourier Response of Avg Magnitude of Body Acceleration Jerk` = `fBodyBodyAccJerkMag-mean()`)
filterData <- rename(filterData, `Fourier Response of Avg Magnitude of Body Gyro` = `fBodyBodyGyroMag-mean()`)
filterData <- rename(filterData, `Fourier Response of Avg Magnitude of Body Gyro Jerk` = `fBodyBodyGyroJerkMag-mean()`)

## Rename STD

filterData <- rename(filterData, `StDev of Body Acceleration In X` = `tBodyAcc-std()-X`)
filterData <- rename(filterData, `StDev of Body Acceleration In Y` = `tBodyAcc-std()-Y`)
filterData <- rename(filterData, `StDev of Body Acceleration In Z` = `tBodyAcc-std()-Z`)

filterData <- rename(filterData, `StDev of Gravity Acceleration In X` = `tGravityAcc-std()-X`)
filterData <- rename(filterData, `StDev of Gravity Acceleration In Y` = `tGravityAcc-std()-Y`)
filterData <- rename(filterData, `StDev of Gravity Acceleration In Z` = `tGravityAcc-std()-Z`)

filterData <- rename(filterData, `StDev of Body Acceleration Jerk In X` = `tBodyAccJerk-std()-X`)
filterData <- rename(filterData, `StDev of Body Acceleration Jerk In Y` = `tBodyAccJerk-std()-Y`)
filterData <- rename(filterData, `StDev of Body Acceleration Jerk In Z` = `tBodyAccJerk-std()-Z`)

filterData <- rename(filterData, `StDev of Body Gyro In X` = `tBodyGyro-std()-X`)
filterData <- rename(filterData, `StDev of Body Gyro In Y` = `tBodyGyro-std()-Y`)
filterData <- rename(filterData, `StDev of Body Gyro In Z` = `tBodyGyro-std()-Z`)

filterData <- rename(filterData, `StDev of Body Gyro Jerk In X` = `tBodyGyroJerk-std()-X`)
filterData <- rename(filterData, `StDev of Body Gyro Jerk In Y` = `tBodyGyroJerk-std()-Y`)
filterData <- rename(filterData, `StDev of Body Gyro Jerk In Z` = `tBodyGyroJerk-std()-Z`)

filterData <- rename(filterData, `StDev of Magnitude of Body Acceleration` = `tBodyAccMag-std()`)
filterData <- rename(filterData, `StDev of Magnitude of Gravity Acceleration` = `tGravityAccMag-std()`)
filterData <- rename(filterData, `StDev of Magnitude of Body Acceleration Jerk` = `tBodyAccJerkMag-std()`)
filterData <- rename(filterData, `StDev of Magnitude of Body Gyro` = `tBodyGyroMag-std()`)
filterData <- rename(filterData, `StDev of Magnitude of Body Gyro Jerk` = `tBodyGyroJerkMag-std()`)

filterData <- rename(filterData, `Fourier Response of StDev of Body Acceleration In X` = `fBodyAcc-std()-X`)
filterData <- rename(filterData, `Fourier Response of StDev of Body Acceleration In Y` = `fBodyAcc-std()-Y`)
filterData <- rename(filterData, `Fourier Response of StDev of Body Acceleration In Z` = `fBodyAcc-std()-Z`)

filterData <- rename(filterData, `Fourier Response of StDev of Body Acceleration Jerk In X` = `fBodyAccJerk-std()-X`)
filterData <- rename(filterData, `Fourier Response of StDev of Body Acceleration Jerk In Y` = `fBodyAccJerk-std()-Y`)
filterData <- rename(filterData, `Fourier Response of StDev of Body Acceleration Jerk In Z` = `fBodyAccJerk-std()-Z`)

filterData <- rename(filterData, `Fourier Response of StDev of Body Gyro In X` = `fBodyGyro-std()-X`)
filterData <- rename(filterData, `Fourier Response of StDev of Body Gyro In Y` = `fBodyGyro-std()-Y`)
filterData <- rename(filterData, `Fourier Response of StDev of Body Gyro In Z` = `fBodyGyro-std()-Z`)

filterData <- rename(filterData, `Fourier Response of StDev of Magnitude of Body Acceleration` = `fBodyAccMag-std()`)
filterData <- rename(filterData, `Fourier Response of StDev of Magnitude of Body Acceleration Jerk` = `fBodyBodyAccJerkMag-std()`)
filterData <- rename(filterData, `Fourier Response of StDev of Magnitude of Body Gyro` = `fBodyBodyGyroMag-std()`)
filterData <- rename(filterData, `Fourier Response of StDev of Magnitude of Body Gyro Jerk` = `fBodyBodyGyroJerkMag-std()`)

names(filterData)

# From the data set, create a second, independent tidy data set with the average of each variable 
# for each activity and each subject.

groupData <- group_by(filterData, Subject, Activity)
groupData2 <- summarise_each(groupData, funs(mean))

write.table(groupData2, file = "output.txt", row.names = F)          
          
          
          