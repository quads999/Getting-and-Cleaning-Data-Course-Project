# Codebook for script: run_analysis.R

# Variables created
 - subject_train : stores the subject number for each observation of the training dataset
 - y_train : stores the activity Id for each observation of the training dataset
 - X_train : stores the measured variables for each observation of the training dataset
 - train : combines all data from the training dataset into one data frame
 - subject_test : stores the subject number for each observation of the test dataset
 - y_test : stores the activity Id for each observation of the test dataset
 - X_test : stores the measured variables for each observation of the test dataset
 - test : combines all data from the test dataset into one data frame
 - fulldataset : combines the training and test datasets into one dataframe
 - colref : contains a vector of references to columns of the data frame that represent variables that are a mean or standard deviation
 - extractdataset : subset of the full dataset that contains only the subject number, activity Id, and variables that are a mean or standard deviation
 - Activity_Lkup : lookup table that contains the activity Id and along with the name of the activity
 - mergedataset : adds a column with the activity name to extractdataset
 - mutatedataset : takes mergedataset and adds "Subject" in front of the values in the column with the subject number to make groups easier to quickly understand

# Transformations applied to datasets
 - The 3 separate flat files for the training and test datasets and were combined together and with the column header files and stored in a single data frame.
 - The columns that represent variables that are a mean or standard deviation were identified and a new dataset was created that excluded all other measured variables.
 - A column was added to the dataset that includes the name of the activity.
 - The average value of each measured variable was calculated for each subject and each activity and placed in a new separate tidy dataset.
