### Introduction

This is the course project in the course Getting and Cleaning Data. The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set.

This repository contains the following files:
1. `README.md`, the markdown file that provide the overview of the project and the R script.
2. `CodeBook.md`, Code Book, the markdown file that indicate all the variables and summaries calculated in the output data. 
3. `run_analysis.R`, the R script for the project.
4. `tidy_data.txt`, the output data.

### Dataset Information

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.


### The preparation for this project

1. The R script required `dplyr` package.
2. Download the zip file containing data as provided in the project if it hasn't already been downloaded.
3. Unzip the zip file if data directory doesn't already exist.

### Create the dataset

1. Read the dataset for training and test set.
	a. `trainingsubject`
	b. `trainingset`
	c. `traininglabel`
	d. `testsubject`
	e. `testset`
	f. `testlabel`
2. Read the dataset fetures and activity set.
	a. `features`
	b. `activity`
3. Combine all the dataset for training and test set and name the dataset as `alldata`.
	a. `alldata`
4. Rename the measurement column names for `alldata` by using `features`.
5. Extracts only the measurements on the mean and standard deviation for each measurement and name the dataset as `alldata1`.
	a.`alldata1`
6. Use descriptive `activity` names to name the activities in the dataset `alldata1`.
7. Appropriately labels the dataset `alldata1` with descriptive variable names.
8. From the dataset `alldata1`, creates a second, independent tidy dataset with the average of each variable for each activity and each subject and name the dataset as `tidy_data`.
