################################# Cleaning Data : Course Project ##############################
#import data
test <- read.table("test/X_test.txt")
train <- read.table("train/X_train.txt")
features <- read.table("features.txt")
subjectTest <- read.table("test/subject_test.txt")
subjectTrain <- read.table("train/subject_train.txt")
y_test <- read.table("test/y_test.txt")
y_train <- read.table("train/y_train.txt")

#merge test and train data sets
data <- rbind(test,train)

#extract only mean and std columns
meanvar <- grepl("mean", features[ , 2])
stdvar <- grepl("std", features[ ,2])
meanStdVar <- (meanvar | stdvar)
data <- data[ , meanStdVar]
features <- features[ meanStdVar, ]

#add subject and activity directly after observation
subject <- rbind(subjectTest, subjectTrain)
activity <- rbind(y_test, y_train)
data <- cbind(data,subject,activity)

#add data column names
subjects <- data.frame(1, "subject")
activities <- data.frame(1, "activity")
colnames(features)<- c("index", "type")
colnames(subjects)<- c("index", "type")
colnames(activities)<- c("index", "type")
cnames <- rbind(features, subjects, activities)
colnames(data) <- cnames[ , 2]

#add descriptive activity names
for (i in 1:length(data[,1])){
  if (data[i,81]==1){
   data[i,81] <- "walking" 
  } else if (data[i,81]==2){
    data[i,81] <- "walking upstairs"
  } else if (data[i,81]==3){
    data[i,81]<-"walking downstairs"
  } else if (data[i,81]==4){
    data[i,81]<-"sitting"
  } else if (data[i,81]==5){
    data[i,81]<-"standing"
  } else {data[i,81]<-"laying"}
}

data