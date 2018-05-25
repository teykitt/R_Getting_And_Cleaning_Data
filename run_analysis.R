# The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set.
# 
# Review criteria
# The submitted data set is tidy.
# The Github repo contains the required scripts.
# GitHub contains a code book that modifies and updates the available codebooks with the data to indicate all the variables and summaries calculated, along with units, and any other relevant information.
# The README that explains the analysis files is clear and understandable.
# The work submitted for this project is the work of the student who submitted it.

# Getting and Cleaning Data Course Project
# The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. 
# The goal is to prepare tidy data that can be used for later analysis. 
# You will be graded by your peers on a series of yes/no questions related to the project. 
# You will be required to submit: 
# 1) a tidy data set as described below
# 2) a link to a Github repository with your script for performing the analysis
# 3) a code book that describes the variables, the data, and any transformations or work that you performed 
#    to clean up the data called CodeBook.md. 
# 4) You should also include a README.md in the repo with your scripts. 
#    This repo explains how all of the scripts work and how they are connected.
# 
# One of the most exciting areas in all of data science right now is wearable computing - see for example this article . 
# Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. 
# The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S 
# smartphone. A full description is available at the site where the data was obtained:
# 
#     http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
# 
# Here are the data for the project:
# 
#     https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# 
# You should create one R script called run_analysis.R that does the following.
# 
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable 
# for each activity and each subject.  Good luck!

##################################################################################################
#  BEGINNING OF ANALYSIS
##################################################################################################

#  STEP 1:  Merges the training and the test sets to create one data set.
#  - Starting with my own pre-steps.  
    #  P1:  Download and unzip the data.
    #  P2:  Create script to compile each data set into it's own data frame
    #  P3:  Execute P2 script for test and train and merge the data frames together

# Create data directory to store downloaded files
 if (!file.exists("data")) {
     dir.create("data")
 }
 
# set the working directory path
setwd("~/Desktop/Data_Science_Track/Getting_And_Cleaning_Data/Week_4/Assignment/data")

# # P1.  Download and unzip the data

 setwd("data")
 fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
 download.file(fileUrl, destfile="dataset.zip", method = "curl")
 dateDownloaded <- date()
 unzip("dataset.zip")

# P2.  Create script to compile each data set into it's own data frame
    #  Script name:  compile_uci_df.R

# P3:  Execute P2 script for test and train and merge the data frames together
 test_df <- compile_uci_df ("test")
 train_df <- compile_uci_df ("train")
 final_df <- rbind(test_df, train_df)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# Extracting the first three columns SubjectId, ActivityID, Activity_Name along with all varriables related to mean/std
 sub_final_df <- final_df[c(1:3, grep ("([mM]ean|[sS]td)", names(test)))]

# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# Both steps 3-4 were completed as part of step 1

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable 
# for each activity and each subject.  Good luck!

# Current dimensions are 10299 observations for 89 variables
# Expected new tidy data would have combination of rows = (subject x activity) x columns (avg for each 86 varibles)

# Get the unique list of SubjectID and ActivityID from the data set
# uniqSubjectID <- unique(sub_final_df$SubjectId)
# uniqActivityName <- unique(sub_final_df$Activity_Name)

# create base tidy data frame from the unique SubjectID and ActivityName combinations
tidy_avg_df <- unique.data.frame(sub_final_df[,c(1,3)])

# reset the row names 
rownames(tidy_avg_df) <- NULL 

# calculate the mean of each variable for each row of tidy_avg_df

for (r in 1:nrow(tidy_avg_df)) { # for each row
    # print(paste("For row number: ", r))
    
    for (v in names(sub_final_df)[-(1:3)]) { # for each variable column (except the first 3)
        # print(paste("For variable: ", v))
        # print the subject, activity and calculated mean for each variable
        # print(paste("Mean for Subject: ", tidy_avg_df[r,1], " Activity_name: ", tidy_avg_df[r,2], 
        #    " calc mean: ", mean(sub_final_df[sub_final_df$SubjectId == tidy_avg_df[r, 1] 
        #                        & sub_final_df$Activity_Name == tidy_avg_df[r, 2], v])))
        
        # calculate and store the mean for each variable
        tidy_avg_df[r, v] <- mean(sub_final_df[sub_final_df$SubjectId == tidy_avg_df[r, 1] 
                                & sub_final_df$Activity_Name == tidy_avg_df[r, 2], v])
    }
}

# Prefix the variable columns with Avg_ to indicate these are the new calculated averages
names(tidy_avg_df)[-(1:3)] <- paste("Avg_", names(tidy_avg_df)[-(1:3)], sep="")

# Write out the output of the final tidy data set
write.table(tidy_avg_df, 
            file="/Users/janma/Desktop/Data_Science_Track/Getting_And_Cleaning_Data/Week_4/Assignment/data/tidy_avg_df.txt", row.names=FALSE)