run_analysis contains the following variables:
- fileUrl - URL path to the source data file
- dateDownloaded - store the date of download
- test_df - data frame of the test data set from the compile_df function with SubjectId prefixed with data set name
- train_df - data frame of the train data set from the compile_df function with SubjectId prefixed with data set name
- final_df - final combined data frame of test_df and train_df
- sub_final_df - subset of final data frame containing only the SubjectId, ActivityId, ActivityName, and variables containing mean or std data
- tidy_avg_df - the final tidy data frame consisting of the unique combinations of SubjectId, ActivityName, and average calcuations of each variable contain the mean or std data.  
  - each column in this data set has been prefixed with Avg_ to indicate it is the average calculation of that data.

compile_df contains the following variables and returns the final compiled data frame
- basePath - base path to the UCI data set
- subjects - subjectIds for the data set (prefixed with the data set name and "_")
- activity_labels - labels for the activity variable
- activity - activity data loaded into data frame
- features - features data
- inertiaPath - folder path to the inertia data
- body_acc_xyz - body_acc data for xyz 
- body_gyro_xys - body_gyro data for xyz
- total_acc_xyz - total_acc data for xyz


