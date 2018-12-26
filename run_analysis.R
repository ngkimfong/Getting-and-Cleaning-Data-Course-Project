# download zip file containing data if it hasn't already been downloaded
dataset_url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
if(!file.exists("cleandata.zip")){download.file(dataset_url,"cleandata.zip",mode='wb')}

# unzip zip file containing data if data directory doesn't already exist
if(!file.exists("cleandata")){unzip("cleandata.zip",exdir="cleandata")}

# read data
library(dplyr)
trainingsubject <- read.table(file.path("cleandata","UCI HAR Dataset","train","subject_train.txt"))
trainingset <- read.table(file.path("cleandata","UCI HAR Dataset","train","X_train.txt"))
traininglabel <- read.table(file.path("cleandata","UCI HAR Dataset","train","y_train.txt"))

testsubject <- read.table(file.path("cleandata","UCI HAR Dataset","test","subject_test.txt"))
testset <- read.table(file.path("cleandata","UCI HAR Dataset","test","X_test.txt"))
testlabel <- read.table(file.path("cleandata","UCI HAR Dataset","test","y_test.txt"))

features <- read.table(file.path("cleandata","UCI HAR Dataset","features.txt"))
features[,2] <- as.character(features[,2])
activity <- read.table(file.path("cleandata","UCI HAR Dataset","activity_labels.txt"))
colnames(activity) <- c("activityid", "activitylabel")

# Merges the training and the test sets to create one data set.
alldata <- rbind(
  cbind(trainingsubject, trainingset, traininglabel),
  cbind(testsubject, testset, testlabel)
)
colnames(alldata) <- c("subject", features[, 2], "activityid")

# Extracts only the measurements on the mean and standard deviation for each measurement.
columnstokeep <- grepl("subject|activityid|mean|std", colnames(alldata))
alldata1 <- alldata[,columnstokeep]
columnstokeep <- !grepl("meanFreq", colnames(alldata1))
alldata1 <- alldata1[,columnstokeep]

# Uses descriptive activity names to name the activities in the data set
alldata1 <- left_join(alldata1,activity,by="activityid")

# Appropriately labels the data set with descriptive variable names.
alldatacol <- colnames(alldata1)
alldatacol <- gsub("[\\(\\)-]", "", alldatacol)
alldatacol <- gsub("^f", "Frequency", alldatacol)
alldatacol <- gsub("^t", "Time", alldatacol)
alldatacol <- gsub("Acc", "Accelerometer", alldatacol)
alldatacol <- gsub("Gyro", "Gyroscope", alldatacol)
alldatacol <- gsub("Mag", "Magnitude", alldatacol)
alldatacol <- gsub("mean", "Mean", alldatacol)
alldatacol <- gsub("std", "Std", alldatacol)

colnames(alldata1) <- alldatacol

# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
alldata1 <- select(alldata1,-activityid)
alldatamean <- alldata1 %>% 
  group_by(subject, activitylabel) %>%
  summarise_each(funs(mean))

write.table(alldatamean, "tidy_data.txt",row.names = FALSE,quote = FALSE)
