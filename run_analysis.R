############## Extracting Data ##################

xtest <- read.table("UCI HAR Dataset/test/X_test.txt")
ytest <- read.table("UCI HAR Dataset/test/y_test.txt")
subtest <- read.table("UCI HAR Dataset/test/subject_test.txt")

xtrain <- read.table("UCI HAR Dataset/train/X_train.txt")
ytrain <- read.table("UCI HAR Dataset/train/y_train.txt")
subtrain <- read.table("UCI HAR Dataset/train/subject_train.txt")

features <- read.table("UCI HAR Dataset/features.txt")
activitylabels <- read.table("UCI HAR Dataset/activity_labels.txt")

############### Extracting x-Data   #########################

xdata <- rbind(xtrain,xtest)

ext <- sort(union(grep('std',features[,2]),grep('mean',features[,2])))

names(xdata) = features[,2]

xdata <- xdata[,ext]

############### Merging y - Data adding in Descriptions   #########################

ydata <- rbind(ytrain,ytest)
names(ydata) = "activity"
ydata[,1] <- activitylabels[ydata[,1],2]

############### Merging Subject Data #############################

subdata <- rbind(subtest,subtrain)
names(subdata) = "subject"

############### Combining All Data into 1 Set ####################################

dataset <- cbind(xdata,ydata,subdata)

############### Create Tidy Data Set #################################
newset <- aggregate(dataset,by = list(activity = dataset$activity, subject=dataset$subject),mean)
write.table(newset[,1:81],"tidydata.txt",row.name=FALSE,sep="\t")
