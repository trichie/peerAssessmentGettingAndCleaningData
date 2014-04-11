library(data.table)

# Loading labels and Features
act_lab <- read.table("UCI HAR Dataset/activity_labels.txt")
colnames(act_lab) <- c("activityID","activity")
feat <- read.table("UCI HAR Dataset/features.txt")
colnames(feat) <- c("column","feature")

# Loading Raw Data: Test data
sub_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
colnames(sub_test) <- "subjectID"
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
colnames(x_test) <- feat$feature
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
colnames(y_test) <- "activityID"

# Loading Raw Data: Training data
sub_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
colnames(sub_train) <- "subjectID"
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
colnames(x_train) <- feat$feature
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
colnames(y_train) <- "activityID"

# Selecting only required columns, here: means and standard deviations
selection <- ((grepl("-mean",feat$feature) & !grepl("-meanF",feat$feature)) | grepl("-std",feat$feature))

# Combining data with labels, merging test and training data
test_data <- merge(cbind(sub_test,x_test[,selection],y_test),act_lab, by = "activityID", all.x = TRUE)
train_data <- merge(cbind(sub_train,x_train[,selection],y_train),act_lab, by = "activityID", all.x = TRUE)
data <- as.data.table(rbind(test_data,train_data))
write.table(data,file="tidyData.txt",sep=",",row.names=FALSE)

# Creating separate file with grouped means
groupedColumns <- names(data)[3:(length(data)-1)]
groupedMeans <- data[, lapply(.SD, mean, na.rm=TRUE), .SDcols=groupedColumns, by=list(subjectID,activityID,activity)]
groupedMeans <- groupedMeans[order(groupedMeans$subjectID,groupedMeans$activityID),]
write.table(groupedMeans,file="tidyGroupedMeans.txt",sep=",",row.names=FALSE)
