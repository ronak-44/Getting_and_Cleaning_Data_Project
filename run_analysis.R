 dataDir <- "C:\Users\ADMIN\Desktop\ronak"
x_train <- read.table(paste(sep = "", dataDir, "/UCI HAR Dataset/train/X_train.txt"))
features <- read.table(paste(sep = "", dataDir, "/UCI HAR Dataset/features.txt"))
y_train <- read.table(paste(sep = "", dataDir, "/UCI HAR Dataset/train/Y_train.txt"))
subject_train <- read.table(paste(sep = "", dataDir, "/UCI HAR Dataset/train/subject_train.txt"))

d1<-cbind(x_train,y_train)
d1<-cbind(d1,subject_train)

colnames(d1) <- features$V2
names(d1)[562]<-"Y"
names(d1)[563]<-"subject"


x_test<- read.table(paste(sep = "", dataDir, "/UCI HAR Dataset/test/X_test.txt"))
y_test <- read.table(paste(sep = "", dataDir, "/UCI HAR Dataset/test/Y_test.txt"))
subject_test <- read.table(paste(sep = "", dataDir, "/UCI HAR Dataset/test/subject_test.txt"))

d2<-cbind(x_test,y_test)
d2<-cbind(d2,subject_test)


colnames(d2) <- features$V2
names(d2)[562]<-"Y"
names(d2)[563]<-"subject"

data<-rbind(d1,d2)


step2 <- grep("std\\(\\)|mean\\(\\)|Y|subject", colnames(data), value=TRUE)
data2<-data[,step2]

activity <- read.table(paste(sep = "", dataDir, "/UCI HAR Dataset/activity_labels.txt"))


data2$Y<-factor(data2$Y);
data2$Y<- factor(data2$Y,labels=as.character(activity$V2))


s4<-aggregate(. ~subject + Y, data2, mean)
s4<-s4[order(s4$subject,s4$activity),]
write.table(s4, file = "C:\\Users\\ADMIN\\Desktop\\ronak\\tidydata.txt",row.name=FALSE)