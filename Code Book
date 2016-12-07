##1.Merges the training and the test sets to create one data set.
subject_test : subject IDs for test
subject_train : subject IDs for train
X_test : values of variables in test
X_train : values of variables in train
y_test : activity ID in test
y_train : activity ID in train
activity_labels : Description of activity IDs in y_test and y_train
features : description(label) of each variables in X_test and X_train
dataSet : bind of X_train and X_test

##2.Extracts only the measurements on the mean and standard deviation for each measurement.
MeanStdOnly : a vector of only mean and std labels extracted from 2nd column of features
dataSet : at the end of this step, dataSet will only contain mean and std variables

##3.Uses descriptive activity names to name the activities in the data set
CleanFeatureNames : a vector of "clean" feature names
subject : bind of subject_train and subject_test
activity : bind of y_train and y_test

##4.Appropriately labels the data set with descriptive variable names.
act_group : factored activity column of dataSet

##5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
baseData : melted tall and skinny dataSet
secondDataSet : casete baseData which has means of each variables
