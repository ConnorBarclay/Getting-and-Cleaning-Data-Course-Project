#Merges the training and the test sets to create one data set.
#Extracts only the measurements on the mean and standard deviation for each measurement.
#Uses descriptive activity names to name the activities in the data set
#Appropriately labels the data set with descriptive variable names.
#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


# 1. 
rm(list=ls())
X_train <- read.table("UCI HAR Dataset/train/X_train.txt", header=F, sep = "")
train <- cbind(train, read.table("UCI HAR Dataset/train/subject_train.txt"), read.table("UCI HAR Dataset/train/y_train.txt"))
X_test <- read.table("UCI HAR Dataset/test/X_test.txt", header=F, sep = "")
test <- cbind(test, read.table("UCI HAR Dataset/test/subject_test.txt"), read.table("UCI HAR Dataset/test/y_test.txt"))
data <- rbind(train, test)

# 2. 
features <- read.table("UCI HAR Dataset/features.txt", header=F, stringsAsFactors=F)
features <- make.names(features[,"V2"])
mean_std <- data[,grep(pattern="std|mean", x=features, ignore.case=T)]

# 3. 
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", header=F, stringsAsFactors=F)
activity_labels <- apply(activity_labels, 1, function(x) unlist(strsplit(x, split=" ")))
data[,563] <- factor(as.factor(data[,563]), labels=activity_labels[2,])

# 4. 
features <- read.table("UCI HAR Dataset/features.txt", header=F, stringsAsFactors=F)
features <- make.names(features[,"V2"])
features[562] = "subject"
features[563] = "activity"
colnames(data) <- features

# 5. 
data2 <- lapply(X=labels, FUN=function(x) tapply(data[[x]], list(data$activity, data$subject), mean))
names(data2) <- labels

write.table(data2, file = "Tidy.txt", row.names = FALSE)              
                   
                   
