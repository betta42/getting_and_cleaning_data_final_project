##### Getting and cleaning data course project

#to run this scrip you need to call this library
library(data.table)

#create a directory where to download the assgnment material
dir.create("temp_betta4242")
setwd("temp_betta4242")

## download the assgnment material
url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, destfile = "data.zip")

#unzip 
unzip("data.zip")
#move in the "UCI HAR Dataset" folder
setwd("UCI HAR Dataset")

##################################################################################################### 1 
#Merge the training and the test sets to create one data set

# first read the data

#read test set
x<- read.table("./test/X_test.txt")
#str(x)#'data.frame':2947 obs. of  561 variables:

#read test labels
# there are 6 possible activities identified by labels
y<-read.table("./test/y_test.txt")
#str(y)#2947    1
#rename the only variable, to avoid confusion later
setnames(y, "labels")

#read test subject
#Each row identifies the subject who performed the activity 
#for each window sample. Its range is from 1 to 30. 
s<-read.table("./test/subject_test.txt")
#str(s)#2947    1
#rename the only variable
setnames(s, "subject")

#put togheter the three test datasets
test<-cbind(s, y, x)
#str(test)# 'data.frame'2947 obs. of  563 variables

#read train data
xx<- read.table("./train/X_train.txt")
#str(xx)#'data.frame':	7352 obs. of  561 variables:

#Train labels
yy<-read.table("./train/y_train.txt")
#str(yy)#'data.frame':	7352 obs. of  1 variable:
#rename the only variable
setnames(yy, "labels")

#Train subject
ss<-read.table("./train/subject_train.txt")
#str(ss)#7352 obs. of  1 variable:
#rename the only variable
setnames(ss, "subject")

#put togheter the three test datasets
train<-cbind(ss, yy, xx)
#str(train)# 'data.frame':7352 obs. of  563 variables

#REMARK
#I find it better to have in the same table the first two columns
#telling what is the subject and what is the sort of activity that are being observed
#anyway this means that now the variables column index is shifted by 2
#(V1 is column 3, V2 is column 4 and so on)

#bind test and train
data<-rbind(test, train)
#str(data)#10299 obs. of  563 variables

#first col: wich subject, 1 to 30
#second col: wich activity, 1 to 6
#the list of the other 561 variables is in the file features.txt

################################################################################################################ 2
#Extract only the measurements on the mean and standard deviation for each measurement.

#the info of which variables are about mean and standatrd deviation are in the file features.txt

feat<-read.table("features.txt")
#str(feat)#'data.frame':561 obs. of  2 variables:
#first col= variable index
#second col= variable name

#extract only the rows that have the word "std" or "mean" in the second col
feat1<-feat[grep("std|mean", feat$V2),]
# problem: it keeps also meanFreq, so delate those rows
feat2<-feat1[grep("meanFreq", feat1$V2, invert = TRUE),]
# now the first col contains the indeces of the variables giving mean and std
#this tells us wich colums extraxt from the table in step 1
#dim(feat2)##66 2

#We want the cols in the data set created in step 1 for the variables listed in feat2$v1
#remember that the column index is shifted by 2, so add 2 to the index
#and keep the columns for subjects and labels (that is 1 and 2)

#this are the columns that we need
cols<-c(1,2, feat2$V1+2)

data1<-data[ , cols]
#str(data1)#'data.frame':10299 obs. of  68 variables


##################################################################################################### 3
#Uses descriptive activity names to name the activities in the data set

#from the file activity_labels.txt
#1 WALKING
#2 WALKING_UPSTAIRS
#3 WALKING_DOWNSTAIRS
#4 SITTING
#5 STANDING
#6 LAYING

#in the column labels (=second col) of data1 we have to replace numbers with descreptive names

data1$labels[data1$labels==1]<-"walking"
data1$labels[data1$labels==2]<-"walking upstairs"
data1$labels[data1$labels==3]<-"walking downstairs"
data1$labels[data1$labels==4]<-"sitting"
data1$labels[data1$labels==5]<-"standing"
data1$labels[data1$labels==6]<-"laying"

####################################################################################################### 4
#Appropriately labels the data set with descriptive variable names.

#the first variable, "subject", is OK
#the second variable should be "activity"
#for the other 66 variables we are going to use the info in  the second column of feat2 created in part 2

a<-as.character(feat2$V2)
variables_names<-c("subject", "activity", a)

colnames(data1)<-variables_names


######################################################################################################## 5
#From the data set in step 4, create a second, 
#independent tidy data set with the average of each variable for each activity and each subject.

# there are 30 subjects and  6 activities
# for 66 variables

#define vector of activity names
activity_names<-c("walking","walking upstairs","walking downstairs", "sitting", "standing", "laying")

#create new empty table with same header of data1
new_data<- data1[0, ]#0 obs. of  68 variables

#compute the mean for every activity and every subject
for(i in activity_names){#loop over 6 activities
        activity<-i
        #create empty table with same header of data1, to store data for specific activity
        temp_data<- data1[0, ]
        for(i in 1:30){#loop over 30 possible subjects
                subj<-subset(data1, data1$subject==i)#subset only info for subject i
                subj_activity<- subset(subj, subj$activity==activity)#subset only info for subject i, and given activity 
                temp<-sapply(subj_activity[ , 3:68], mean)#apply mean to columns from 3 to 68 (that is, to 66 variables)
                temp1<-c(i, activity, temp)#add subject identifier and activity
                temp_data[i, ]<- temp1 #add as row i of temp_data
                #at the end of this loop, temp_data contains info of avarege of every variable for every subject,
                #for specifiv activity
        }
        #bind together data for all activities
        new_data<-rbind(new_data, temp_data)
}

#str(new_data)#'data.frame':180 obs. of  68 variables
#first col: wich subject
#second col: wich activity
#col 3:68 averege for subject and activity given by the row, for variable given by the coulumn name

#save tidy data in the original working directory
setwd("..")
setwd("..")
write.table(new_data, "tidy_data.txt")

