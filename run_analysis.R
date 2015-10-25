setwd("~/Dropbox/Data_analysis/Obtaining and tidying up data/Programming assignment/UCI HAR Dataset")

library(dplyr) # load the library

feat <- read.table("features.txt") # features will be in feat
act <- read.table("activity_labels.txt") # activities will be in act

sbj_test <- read.table("test//subject_test.txt") # subjects will be in sbj_test

# Acquiring test data
xtest <- read.table("test//X_test.txt")
ytest <- read.table("test//y_test.txt")

# Acquiring train data
sbj_train <- read.table("train//subject_train.txt")
xtrain <- read.table("train//X_train.txt")
ytrain <- read.table("train//y_train.txt")

## get the feature names from column#2 of feat and convert to character
## then transpose the matrix to 1x561 to match the xtest columns
tfeat <- t(as.character(feat[,2])) 

## Rename the columns of xtest and xtrain with the feature names taken above
colnames(xtest) <- tfeat
colnames(xtrain) <- tfeat

colnames(sbj_test) <- "Subject"
colnames(sbj_train) <- "Subject"

# grep the titles of xtest and xtrain containing mean() and std()
desired_mean_test <- grep("mean", names(xtest))
desired_std_test <- grep("std", names(xtest))
desired_mean_train <- grep("mean", names(xtrain))
desired_std_train <- grep("std", names(xtrain))

# extract the desired data (mean and std in this case)
data_test_mean_test <- xtest[,desired_mean_test]
data_test_std_test <- xtest[,desired_std_test]
data_test_mean_train <- xtrain[,desired_mean_train]
data_test_std_train <- xtrain[,desired_std_train]


ytest <- as.character(act[ytest[,1],2])
ytest <- t(ytest)
ytest <- t(ytest)
colnames(ytest) <- "Activity"
ytrain <- as.character(act[ytrain[,1],2])
ytrain <- t(ytrain)
ytrain <- t(ytrain)
colnames(ytrain) <- "Activity"

# bind the seperate data given in seperate files into test and train data frames
data_test <- cbind(sbj_test, ytest, data_test_mean_test, data_test_std_test)
data_train <- cbind(sbj_train, ytrain, data_test_mean_train, data_test_std_train)
data_test <- arrange(data_test, Subject)
data_train <- arrange(data_train, Subject)

# Bind the data and get all the test and train data together 
data <- rbind(data_train, data_test)
data <- arrange(data, Subject)

# Group the data by Subject and Activity
temp <- group_by(data, Subject, Activity)
# Calculate the average of each variable for each subject and each activity.
data_avg <- summarise_each(temp, funs(mean))

