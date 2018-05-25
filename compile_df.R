#  Script name:  compile_uci_df.R
# P2.  Create script to compile each data set into it's own data frame
# 
# Each row will look like the following so let's read each data file and then compile at end
#     
# SubjectId:  Participant number 
# — Generated from subject_xxx.txt
# — i.e. Test1-30 and Train1-30)
# 
# Activity ID/Label:  The activity the participant was performing
# — Generated from y_xxx.txt
# — 1-6 representing WALKING, LAYING, SITTING, etc.
# — Generated from activity_labels.txt
# 
# Features:  A 561-item vector containing various summary type data for each row
# — Generated from X_xxx.txt
# — Key/label for each item in vector represented by features.txt
# 
# Inertial Signals:  Body Acc, Body Gyro, Total Acc for XYZ for each measurement 
# — Generated from body_acc_xyz_xxx.txt body_gyro_xyz_xxx.txt, and total_acc_xyz_xxx.txt
# - Each axis has vector of 128 values therefore 1152 total

# - Final data frame will then have 1,716 variables


compile_uci_df <- function (datasetname) {

    basePath = paste("UCI HAR DataSet/", datasetname, "/", sep="")
    # print(basePath)
    
    # Get the SubjectId
    subjects <- read.table(file=paste(basePath, "subject_", datasetname, ".txt", sep=""), col.names=c("SubjectId"))
    
    # Add the data set name to the subjectId
    subjects[,1] <- paste(datasetname, "_", subjects[,1], sep = "")
    
    
    # Activity ID/Label:  The activity the participant was performing
    # — Generated from y_xxx.txt
    # — 1-6 representing WALKING, LAYING, SITTING, etc.
    # — Generated from activity_labels.txt
    

    # Read in the activity labels
    activity_labels <- read.table(file="UCI HAR DataSet/activity_labels.txt", col.names=c("Id", "Activity"))
    
    # Read in the activity rows
    activity <- read.table(file=paste(basePath, "y_", datasetname, ".txt", sep=""), col.names=c("ActivityId"))
    
    
    # Perform lookup to match ActivityId to get the ActivityName
    activity_df <- data.frame(ActivityId = activity$ActivityId, Activity_Name = activity_labels[match(activity$ActivityId, activity_labels$Id), 2])
    
    # Features:  A 561-item vector containing various feature summary type data for each row
    # — Generated from X_xxx.txt
    # — Labels for each item in vector represented by features.txt
    
    # Read in the features labels
    feature_labels <- read.table(file="UCI HAR DataSet/features.txt", col.names=c("Id", "Feature"))
    
    # Read in the features rows
    features <- read.table(file=paste(basePath, "X_", datasetname, ".txt", sep=""), col.names=unlist(feature_labels[,2]))
    
    # Inertial Signals:  Body Acc, Body Gyro, Total Acc for XYZ for each measurement
    # — Generated from body_acc_xyz_xxx.txt body_gyro_xyz_xxx.txt, and total_acc_xyz_xxx.txt
    inertiaPath <- paste(basePath, "Inertial Signals/", sep = "")
    
    readIS <- function (type, d) {
        # read in the file
        temp <- read.table(file=paste(inertiaPath, type, "_", d,"_", datasetname, ".txt", sep=""), col.names=c(paste(type, d, 1:128)))
    }

    body_acc_x <- readIS("body_acc", "x")
    body_acc_y <- readIS("body_acc", "y")
    body_acc_z <- readIS("body_acc", "z")
    body_gyro_x <- readIS("body_gyro", "x")
    body_gyro_y <- readIS("body_gyro", "y")
    body_gyro_z <- readIS("body_gyro", "z")
    total_acc_x <- readIS("total_acc", "x")
    total_acc_y <- readIS("total_acc", "y")
    total_acc_z <- readIS("total_acc", "z")
    
    # Create the final data frame to be returned
    data.frame(subjects, activity_df, features, 
               body_acc_x, body_acc_y, body_acc_z, 
               body_gyro_x, body_gyro_y, body_gyro_z,
               total_acc_x, total_acc_y, total_acc_z)
}
