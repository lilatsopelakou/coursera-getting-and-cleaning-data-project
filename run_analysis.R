## download and unzip data


fileName <- "UCIdata.zip"
url <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
dir <- "UCI HAR Dataset"

if(!file.exists(fileName)){
  download.file(url,fileName, mode = "wb") 
}

if(!file.exists(dir)){
  unzip("UCIdata.zip", files = NULL, exdir=".")
}

## Read Data
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")

activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
features <- read.table("UCI HAR Dataset/features.txt")  

# 1. Merges the training and the test sets to create one data set.
dataSet <- rbind(X_train,X_test)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
MeanStdOnly <- grep("mean()|std()", features[, 2]) 
dataSet <- dataSet[,MeanStdOnly]


# 4. Appropriately labels the data set with descriptive activity names.
CleanFeatureNames <- sapply(features[, 2], function(x) {gsub("[()]", "",x)})
names(dataSet) <- CleanFeatureNames[MeanStdOnly]
subject <- rbind(subject_train, subject_test)
names(subject) <- 'subject'
activity <- rbind(y_train, y_test)
names(activity) <- 'activity'
dataSet <- cbind(subject,activity, dataSet)


# 3. Uses descriptive activity names to name the activities in the data set
act_group <- factor(dataSet$activity)
levels(act_group) <- activity_labels[,2]
dataSet$activity <- act_group


# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
if (!"reshape2" %in% installed.packages()) {
  install.packages("reshape2")
}
library("reshape2")
baseData <- melt(dataSet,(id.vars=c("subject","activity")))
secondDataSet <- dcast(baseData, subject + activity ~ variable, mean)
names(secondDataSet)[-c(1:2)] <- paste("[mean of]" , names(secondDataSet)[-c(1:2)] )
write.table(secondDataSet, "tidy_data.txt", sep = ",")
