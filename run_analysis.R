library(dplyr)
library(plyr)
library(reshape2)

subject_test <- read.table("subject_test.txt", col.names=c("Subject")) #read subject test data 
subject_test<-tbl_df(subject_test)

subject_train <- read.table("subject_train.txt", col.names=c("Subject"))# read subject train data 
subject_train<-tbl_df(subject_train)

X_test <- read.table("X_test.txt") #read feature test data 
X_test<-tbl_df(X_test)

X_train <- read.table("X_train.txt") #read feature train data 
X_train <- tbl_df(X_train)

Y_test <- read.table("Y_test.txt") #read activity data 
Y_test<-tbl_df(Y_test)

Y_train <- read.table("Y_train.txt") #read activity data 
Y_train <- tbl_df(Y_train)

feature <- read.table("features.txt", col.names=c("index", "feature_labels"))# read list of features

feature_labels <- feature$feature_labels # create 1 dimensional vector containing features from feature data frame

activity_labels<-read.table("activity_labels.txt",sep=" ",col.names=c("activityLabel","Activity"))# read acitvity label and add
activity_labels<-tbl_df(activity_labels)

subject<-bind_rows(subject_train, subject_test)#combine train and test

X_data <- bind_rows(X_train, X_test) #combine X_train and X_test data 
Y_data <- bind_rows(Y_test, Y_train) #combine Y_train and Y_test data 
colnames(Y_data) <- "activityLabel" # assigne acctivity lable to Y_data as a column
Y_data<-inner_join(Y_data,activity_labels,by="activityLabel")
Y_data<-select(Y_data, Activity) # just keep Activity column


features_subset <- grepl('mean\\(\\)|std\\(\\)',feature_labels) #create logical vector with column names that have mean() and std()

feature <- as.character(feature_labels[features_subset])# create a vector of features with mean and std in their name

colnames(X_data) <- feature_labels # rename columns in X_data 

X_data <- X_data[,features_subset] #subset only mean() and std() columns from X_data

main_data <- cbind(X_data, Y_data, subject) #combine X_data, Y_data and subject data in to one data frame

final_data <- melt(main_data, id=c("Subject", "Activity"), measure.vars=feature) #melt main_data for reshaping

final_data <- dcast(final_data, Activity + Subject ~ variable, mean)#reshape in to tidy data frame

final_data <- final_data[order(final_data$Subject, final_data$Activity),]# reorder by subject and then activity

rownames(final_data) <- 1:nrow(final_data) #Reindex Rows and move Subject to Column 1
final_data <- final_data[,c(2,1,3:68)]

write.table(final_data,file="final_tidy_data.txt") #output tidy data set
