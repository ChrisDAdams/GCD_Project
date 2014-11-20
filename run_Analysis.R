library(plyr)
library(data.table)

run_analysis <- function() {
  #Assume data has been downloaded and extracted from ZIP
  #if(!file.exists(".\\data")){dir.create(".\\data")}
  #fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip?access_type=DOWNLOAD"
  #download.file(fileurl,destfile=".\\data\\UCI HAR Dataset\\UCI HAR Dataset.zip")
  #unzip(".\\data\\UCI HAR Dataset\\UCI HAR Dataset.zip")
  
  #Read input files assumes files in .\data\UCI HAR Dataset
  features <- read.table(".\\UCI HAR Dataset\\features.txt")
  xTest <- read.table(".\\UCI HAR Dataset\\test\\X_test.txt",col.names=features[,2])
  yTest <- read.table(".\\UCI HAR Dataset\\test\\y_test.txt")
  sTest <- read.table(".\\UCI HAR Dataset\\test\\subject_test.txt")
  xTrain <- read.table(".\\UCI HAR Dataset\\train\\X_train.txt",col.names=features[,2])
  yTrain <- read.table(".\\UCI HAR Dataset\\train\\y_train.txt")
  sTrain <- read.table(".\\UCI HAR Dataset\\train\\subject_train.txt")
  actLabels <- read.table(".\\UCI HAR Dataset\\activity_labels.txt",col.names=c("id","Activity"))
 
  #Join Subject/Activity/Data
  colnames(yTest)[1] <- "Activity"
  colnames(sTest)[1] <- "Subject"
  yxTest <- cbind(yTest,xTest)
  syxTest <- cbind(sTest,yxTest)
  
  colnames(yTrain)[1] <- "Activity"
  colnames(sTrain)[1] <- "Subject"
  yxTrain <- cbind(yTrain,xTrain)
  syxTrain <- cbind(sTrain,yxTrain)
  
  #Merge the Test and Training Data and arrange into Subject sequence
  mergeData <- merge(syxTrain,syxTest,all=TRUE)
  mergeData <- arrange(mergeData,Subject)
  
  #Subset to only means and std cols
  col_names <- c("Subject","Activity",grep("[M,m][E,e][A,a][N,n]", colnames(mergeData), value=TRUE),grep("[S,s][T,t][D,d]", colnames(mergeData), value=TRUE))
  subsData <- subset(mergeData,select=col_names)
  
  #Annotate with the Activity Labels
  annData <- merge(actLabels, subsData, by.y='Activity', by.x='id', all=TRUE)
  annData <- subset(annData,select=col_names)
  
  colnames(annData)[] <- gsub("\\.","", tolower(col_names[]))
  #Arrange into Subject sequence
  cleanData <- arrange(annData,subject)
  
  cleanData
}
