# Getting and Cleaning Data Course Project

Course Project for Getting and Cleaning Data (https://class.coursera.org/getdata-031)

## Overview 

This Git repo contains a script for processing the Human Activity Recognition Using Smartphones Data Set.

One of the most exciting areas in all of data science right now is wearable computing. Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

The data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

## run_analysis.R

The provided script downloads the data as necessary and then preprocesses it to make the data tidy.

For preprocessing, the script loads in both the testing and training data sets and merges them together into a unified data set. For the purpose of our analysis, we want the entire dataset. We also load in data from subjects as well as the features file to be able to link up the data later. 

Once we have all the column labels imported from the features data, we proceed to extract only the mean and std parameter values for all subjects for all activities. We rename the activity column with factors so that we can directly see what activity each of the subjects are performing.

Next we rename the column headings with more descriptive names (i.e. 'Avg Body Acceleration In X' instead of 'tBodyAcc-mean()-X'. And finally, we calculate the mean statistic across all columnar data to come up with our final tidy dataset of values grouped by subject and activity. The final tidy dataset is written out in text format using write.table. 
