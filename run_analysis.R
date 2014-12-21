## download the required files and folders into working directory before reading them into R
## use notepad++ to understand the structure of the txt files that need to be read into R
## I have already installed required packages such as dplyr on my laptop


## step 1: dealing with the "test" group
## labels the data set with descriptive variable names in features.txt is done here too 

subject_test <- read.table(file = "C:/Users/Yong/Documents/test/subject_test.txt", stringsAsFactors = FALSE)
activity_test <- read.table(file = "C:/Users/Yong/Documents/test/y_test.txt", stringsAsFactors = FALSE)
reading_test <- read.table(file = "C:/Users/Yong/Documents/test/X_test.txt", stringsAsFactors = FALSE)

## read the 3 txt files into R in 3 data.frames 
## I have used dim() and or notepad++ to check the dimension of these data.frames 
## All raw data consist of 2947 rows so we can use cbind()
## from the discussion forum and README.txt, features.txt and etc in the raw data set we know that every row correspond a subject id, an activity id and readings for 561 different features

names(subject_test) <- "subject_no."
names(activity_test) <- "activity_no."
## add corresponding variable titles to the un-titled data.frames

features <- read.table(file = "C:/Users/Yong/Documents/features.txt", stringsAsFactors = FALSE)
names(features) <- c("no.", "features")
names(reading_test) <- features$features
## read the features/variable names from features.txt and use head() to find out that the variable names are in the 2nd column
## add variable names to the reading data


activity_labels <- read.table(file = "C:/Users/Yong/Documents/activity_labels.txt", stringsAsFactors = FALSE)
names(activity_labels) <- c("activity_no.", "activity_labels")
## this is for later on that we refer the activity_labels to the activity_no.


subject_group <- rep("test", 2947)
names(subject_group) <- "subject_group"
## since we know reading from this folder are all in "test" group, create another list for cbind() to create a clean data set

test <- cbind(subject_test, subject_group, activity_test, reading_test)
## this line should give us the data.frame that contains a clean data set for all "test" group before merge()




## Step 2: now we continue with the "train" group
## labels the data set with descriptive variable names in features.txt is done here too

subject_train <- read.table(file = "C:/Users/Yong/Documents/train/subject_train.txt", stringsAsFactors = FALSE)
activity_train <- read.table(file = "C:/Users/Yong/Documents/train/y_train.txt", stringsAsFactors = FALSE)
reading_train <- read.table(file = "C:/Users/Yong/Documents/train/X_train.txt", stringsAsFactors = FALSE)

## read the 3 txt files into R in 3 data.frames 
## I have used dim() and or notepad++ to check the dimension of these data.frames 
## All raw data consist of 7352 rows so we can use cbind()
## reading_train also contains 561 features of readings
## from the discussion forum and README.txt, features.txt and etc in the raw data set we know that every row correspond a subject id, an activity id and readings for 561 different features


names(subject_train) <- "subject_no."
names(activity_train) <- "activity_no."
## ditto, add corresponding variable titles to the un-titled data.frames

names(reading_train) <- features$features
## the variable names to the reading data are the same to the "test" group

subject_group <- rep("train", 7352)
names(subject_group) <- "subject_group"
## we also know this is all "train" group data, so create a corresponding list for cbind() to create a clean data set

train <- cbind(subject_train, subject_group, activity_train, reading_train)
## this line should give us the data.frame that contains a clean data set for all "train" group before merge()

df <- rbind(test, train)
## this gives us the data.frame contains all the complete data from "test" and "train"
## this is ok as all the names are consistent
## use dim(df) we can know the dimensions of the data set
## [1] 10299   564

df1 <- merge(activity_labels, df, by = "activity_no.")
## this is to add descriptive activity names to name the activities in the data set
## use dim(df1) and the data.frame grow by 1 column
## [1] 10299   565



## step 3: Extracts only the measurements on the mean and standard deviation for each measurement. 
## this step further cleans the data set as activity_no. is no longer needed

library(dplyr)
df2 <- select(df1, subject_no., subject_group, activity_labels, contains("mean"), contains('std'))
df2 <- arrange(df2, subject_no., subject_group, activity_labels)
## load the dplyr package
## select only columns that contains the measurements on mean and standard deviation
## including the subject_no., subject_group and activity_labels too
## use dim(df2) and the data set has only 89 columns/86 measurements now
## [1] 10299   89
## lastly use arrange() to tidy the data based on subject_no., subject_group and activity_labels


## step 4: From the data set in the previous step , creates a second, independent tidy data set 
## with the average of each variable for each activity and each subject.


df3 <- summarise_each(group_by(df2, subject_no., subject_group, activity_labels), funs(mean))
## summarise_each and group_by condense the measurement by subject_no., subject_group and activity_labels
## so that each subject, each activity and each subject_group returns only 1 mean value
## dim(df3) return the final tidy data set 
## [1] 180   89

## step 5: creat a tidy data txt file with write.table() using row.name=FALSE

write.table(df3, file ="tidy_data.txt", row.name=FALSE)
## this line generates the output for the submission tidy_data.txt

