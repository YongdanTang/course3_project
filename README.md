Explanation to Getting and Cleaning Data - Course Project
-------------------

This project was done using the raw data from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
-------------------

The requirements of the project are:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

-------------------

The R programming was done on 
	Windows 8.1 (64bit)  
	R 3.1.2
	RStudio Version 0.98.1073 
	with dplyr package installed

The working directory was set to be "C:/Users/Yong/Documents"
And the required files and folders have been downloaded under this working directory.
-------------------

As per described in the descriptive documents from the original data. 
The full data set were stored in two folders:
	test folder
	train folder

The 1st section of the code in run_analysis.R read the data from "test" group into R in 3 data.frames
	subject_test
	activity_test
	reading_test	

We can add the variable names to these 3 data.frames. It is known that subject_test contains the subject IDs so I name it as "subject_no."
It is also known the activity_test contains the activity IDs that refers to the activity labels so I name it as "activity_no."
the reading_test data.frame contains 561 variables that corresponds well to the 561 variables in the features.txt so they are named after those

 
notepad++ and dim() function have been used regularly to understand the dimensions of the data read into R.
so it is known that all 3 data.frames contains 2947 rows which can be cbind() into the "test" data set
This is by itself a clean data set as
	Each variable measured is in one column
	Each different observation of the variable is in a different row
	Each variable in the same table is unique
	
cbind() the 3 test data.frams and we will get a clean "test" data set with 2947 rows

Then the same can be done for the "train" group as well to obtain the following data.frames
	subject_train
	activity_train
	reading_train

repeat the similar steps as described in comments in run_analysis.R we can get a "train" data.frame with 7352 rows.

rbind() test and train data.frames we will have a ## [1] 10299   564 data.frame that contains all the instances and respective variables

merge() can be used to link activity_no. to activity_labels

Then we need to use the dplyr package to manipulate the data set

I use the select() function to create another data.frame df2 that contains only the variables of interest, so basically the subject_no., subject_group, activity_labels and all measurements contains "mean" and "std". This generates a data.frame that contains ## [1] 10299   89 dimensions 
Use the arrange() function to sort the data.frame by subject_no., subject_group and activity_labels as well.

Then use summarise_each() and group_by() to aggregate the data set by subject_no., subject_group and activity_labels, apply the mean() to all the measurements. This will generate the target data.frame of ## [1] 180   89 dimension.

Finally use the write.table() function as required in the assignment page to generate the tidy_data.txt file.

I have used read.table() to test the tidy_data.txt locally on my laptop as well. And the data set is as clean. 








