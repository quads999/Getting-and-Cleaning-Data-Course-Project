# This script reads a collection of flat files, combines them into a single dataset,
# adds column headings, selects a subset of the columns, and applies other transformations
# to create a tidy dataset. This script also calculates the averages for each variable 
# for each subject and activity separately and stores the results in a separate tidy dataset.

library(dplyr)
library(tidyr)

# Combine the 3 separate flat files for the training data and store it in a single data frame.

subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
train <- cbind(subject_train, y_train, X_train)

# Combine the 3 separate flat files for the test data and store it in a single data frame.

subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
test <- cbind(subject_test, y_test, X_test)

# Combine the training and test datasets and add variable labels in the column headers.

fulldataset <- rbind(train, test)
names(fulldataset) <- c("Subject", "ActivityNum", as.character(read.table("./UCI HAR Dataset/features.txt")[,2]))
colref <- grep("Subject|ActivityNum|mean[^Freq]|std", names(fulldataset))

# Identify the columns that represent variables that are a mean or standard deviation,
# and then create a new dataset that excludes all other measured variables.

colref <- grep("Subject|ActivityNum|mean[^Freq]|std", names(fulldataset))
extractdataset <- fulldataset[,colref]

# Add a column to the dataset that includes the name of the activity.

Activity_Lkup <- read.table("./UCI HAR Dataset/activity_labels.txt")
names(Activity_Lkup)[2] = "Activity"
mergedataset <- merge(extractdataset, Activity_Lkup, by.x = "ActivityNum", by.y = "V1")

# Create a separate tidy dataset that contains the average value for each variable
# for each subject and activity type.

mutatedataset <- mutate(mergedataset, Subject = paste("Subject", Subject))
finaldataset <- rbind(aggregate(mutatedataset[,3:68], list(mutatedataset$Subject), mean), aggregate(mutatedataset[,3:68], list(mutatedataset$Activity), mean))
names(finaldataset)[1] <- "Group"