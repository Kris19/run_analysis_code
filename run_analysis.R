## Set working directory with Session -> Set working directory -> To Files Pane Location
library(dplyr) # load the package dplyr

feat <- read.table("features.txt") # features will be in the data frame labeled as feat
act <- read.table("activity_labels.txt") # activity labels will be in the data frame labeled as act

# Acquiring test data
sbj_test <- read.table("test//subject_test.txt") # subjects will be in the data frame labeled as sbj_test
xtest <- read.table("test//X_test.txt")
ytest <- read.table("test//y_test.txt")

# Acquiring train data
sbj_train <- read.table("train//subject_train.txt")
xtrain <- read.table("train//X_train.txt")
ytrain <- read.table("train//y_train.txt")

## get the feature names from column#2 of feat and convert to character
## then transpose the matrix to 1x561 to match the xtest and xtrain columns
tfeat <- t(as.character(feat[,2])) 

## Rename the columns of xtest and xtrain with the feature names taken above
colnames(xtest) <- tfeat
colnames(xtrain) <- tfeat

# Rename the column of sbj_test and sbj_train with the name "Subject"
colnames(sbj_test) <- "Subject"
colnames(sbj_train) <- "Subject"

# grep the titles of xtest and xtrain containing mean() and std()
desired_mean_test <- grep("mean", names(xtest))
desired_std_test <- grep("std", names(xtest))
desired_mean_train <- grep("mean", names(xtrain))
desired_std_train <- grep("std", names(xtrain))

# extract (subset) the desired data (mean and std in this case)
data_test_mean_test <- xtest[,desired_mean_test]
data_test_std_test <- xtest[,desired_std_test]
data_test_mean_train <- xtrain[,desired_mean_train]
data_test_std_train <- xtrain[,desired_std_train]

# convert the activity number to activity names
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
#Create a txt file from the data_avg 
write.table(data_avg, file="tidy_data_set.txt",row.names = FALSE)


