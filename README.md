# R_Getting_And_Cleaning_Data
R_Getting_And_Cleaning_Data Week 4 assignment

There are two scripts in this repo:
run_analysis.R
compile_df.R

run_analysis.R is the primary script and performs the following functions:
- create the data directory (if does not exists), download and unzip the data set.

The data set is download from: "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

This data set contains the UCI HAR Dataset folder which contains the following items:
- activity_labels.txt which are the label names for each activity
- features_info.txt which describes the features in detail
- features.txt which are the label names for the features
- README.txt which is a summary of the data
- two data sets (test and train) each containing the following:
  - Inertial Signals folder with body_acc, body_gyro, and total_acc for xyz axis
  - subject_<data_set>.txt which contains the subject ids
  - X_<data_set> which contains the features data
  - y_<data_set> which contains the activity ID

The compile_df function (from the compile_df.R file) compiles the data and labels from the data set and returns a tidy data frame for that data set.

compile_df is called for both the test and train data sets and then combined into the combined final data frame.

This combined final data frame is then used to complete the remaining steps of subsetting to only obtain the Mean and Standard deviation columns for this data set.

Finally, the unique combinations of SubjectId and ActivityNames are used to create a new data frame and the average for each variable is calculated for each row.
