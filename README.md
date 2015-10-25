# run_analysis code explanation

This README.md file contains the explanation of run_analysis.R script and how to obtain the tidy_data_set.


1) Understand the data:
The first step consisted in reading the README.md files included in the original data set. We had 30 subjects and 2 data sets: test and train. For each set there was 6 different activities and 561 variables. 

2) Installing and loading the dplyr package.

3) Set the working directory:
 Session -> Set working directory -> To Files Pane Location

4) Read the feature and activity_labels data in the work space using read.table() into data frames.
The file “features.txt”, containing the 561 variables, was read into data frame labeled as feat (561 obs. 2 variables).
The file “activity_labels.txt” was read into data frame labeled as act (6 obs. 2 variables).

5) Acquired the test data using read.table() into data frames
sbj_test <- read.table("test//subject_test.txt") # contains the subject id number, (2947 obs. 1 variable).
xtest <- read.table("test//X_test.txt") # contains the readings of the 561 variables (2947 obs. of 561 variables).
ytest <- read.table("test//y_test.txt”)# containing the activity_labels 

6)Acquired the train data using read.table() into data frames
sbj_train <- read.table("train//subject_train.txt")# contains the subject id number (7352 obs. 1 variable).
xtrain <- read.table("train//X_train.txt")# contains the readings of the 561 variables (7352 obs. of 561 variables).
ytrain <- read.table("train//y_train.txt")

7) Convert the column #2 of feat into character with as.character() and then transpose with t() to 1X561 to match the columns in xtest and xtrain.

8) Rename the columns of xtest and xtrain with the feature names taken in step 7 with colnames().

9) Rename the columns of sbj_test and sbj_train with the name “Subject” using colnames().

10)Subset the columns of mean and std for each variable in xtest and xtrain first by selecting the columns with that name using grep() and then by subsetting this columns using x[,df].
data_test_mean_test <- xtest[,desired_mean_test]  
data_test_std_test <- xtest[,desired_std_test]
data_test_mean_train <- xtrain[,desired_mean_train]
data_test_std_train

11) Convert the activity number to activity names.  Get each activity number in data frame “ytest” and match it with the activity name in the data frame “act”, convert to character with as.character() and replace the number with the activity name. Change the name of the column to “Activity” with colnames(). Repeat the same procedure to ytrain.

12) Combine the subject, activity and observations files  in a single data frame for test and train with cbind(). Arrange by Subject number with arrange(). 
data_test <- cbind(sbj_test, ytest, data_test_mean_test, data_test_std_test)
data_train <- cbind(sbj_train, ytrain, data_test_mean_train, data_test_std_train)

13) Combine the test and train data frames to obtain a single data frame with rbind(). Again, arrange by Subject number with arrange().
data <- rbind(data_train, data_test)

14) Group the data frame by both subject and activity using group_by()
15) Calculate the average of each variable for each subject and each activity with summarise_each (df, funs (mean)).
data_avg <- summarise_each(temp, funs(mean)) ##(180 obs. of 81 variables)


16) Create a txt file with the tidy data set using write.table().




