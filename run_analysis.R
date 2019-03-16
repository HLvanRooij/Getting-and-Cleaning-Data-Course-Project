#### SETUP ####

library(dplyr)


#### READ TXT FILES ####

# Folder UCI HAR DATASET ##
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", header = FALSE)
features <- read.table("./UCI HAR Dataset/features.txt")

# Read Train Data 
subject_train <-  read.table("./UCI HAR Dataset/train/subject_train.txt")
X_train <-  read.table("./UCI HAR Dataset/train/X_train.txt")
Y_train <-  read.table("./UCI HAR Dataset/train/y_train.txt")

# Read test Data 
subject_test <-  read.table("./UCI HAR Dataset/test/subject_test.txt")
X_test <-  read.table("./UCI HAR Dataset/test/X_test.txt")
Y_test <-  read.table("./UCI HAR Dataset/test/y_test.txt")



#### CHANGE DATA NAMES ####


## Tidy column names 
# Write "time" and "freq" out in full
colnames(features) <- sub( "^f", "freq.", colnames(features) )
colnames(features) <- sub( "^t", "time.", colnames(features) )

#Change all stripes by dots 
colnames(features) <- gsub( "-", ".", colnames(features))

# Lookup label for the Y_tables  
Y_train <- merge(Y_train, activity_labels, by.x = "V1", by.y = "V1")
Y_test <- merge(Y_test, activity_labels, by.x = "V1", by.y = "V1")


## Change colnames 
# Change colnames train data 
colnames(Y_train)[2] <- "Activity"
colnames(subject_train) <- "Subject"
colnames(X_train) <- features$V2

# Change colnames test data 
colnames(Y_test)[2] <- "Activity"
colnames(subject_test) <- "Subject"
colnames(X_test) <- features$V2


# Remove first column Y_Table 
Y_train <- Y_train[, 2, drop = FALSE]
Y_test <- Y_test[, 2, drop = FALSE]



#### MERGE DATASETS ####

# Merge train data in one data_frame
train_final <- cbind(subject_train, Y_train, X_train)
test_final <- cbind(subject_test, Y_test, X_test)
complete_data <- rbind(train_final, test_final)


#### SELECT MEAN AND STD COLUMN NAMES ####
measurements_std_mean <- cbind(complete_data[, 1:2], 
                   complete_data[, 
                                 grepl( "mean\\(\\)" , names(complete_data)) | 
                                     grepl("std\\(\\)", names(complete_data))]
                    ) 



#### SUMMARIZE DATA #### 
# Calculate mean for each subject and activity 
summary_measurements <- measurements_std_mean %>%
    group_by(Subject, Activity) %>% 
    summarise_all(mean)

write.table(summary_measurements, "./Getting and Cleaning Data Course project.txt")
                