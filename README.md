## Getting and Cleaning Data Project - Readme
I wrote this script for project of Getting and Cleaning Data course of John Hopkins University on Coursera.

## Purpose of the project
Create an R script called run_analysis.R that does the following.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names.
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## How to run the script
* Download the repo on your local computer
* Open the script in RStudio.
* Update line 48 of the script to set the path to the folder of the script. The command to update is 

```r
setwd('/Path/To/gacdproject');
```

* Source the script using 

```r
source('~/Path/to/gacdproject/run_analysis.R')
```

* Call function 

```r
run_analysis();
```

After running the script you should see the following messages

```
[run_analysis.R] Setting the working to directory 
[run_analysis.R] Checking if data.table package is installed 
Loading required package: data.table
data.table 1.9.2  For help type: help("data.table")
[run_analysis.R] Downloading data 
[run_analysis.R] Processing features 
[run_analysis.R] Processing activity data 
[run_analysis.R] Processing training data 
[run_analysis.R] Processing test data 
[run_analysis.R] Generating tidy data 
[run_analysis.R] Writing merged data 
[run_analysis.R] Writing tidy data
```

### Input Data
The input data that can be downloaded from `https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip`

### Cleaned Data
Once the scripts completes its execution, the resultant merged and tidy datasets are saved in `/output/rawdata.txt` and `/output/tidyData.txt` files.

### Dependencies
The only dependency of this script is `data.table` package that will be be automatically downloaded by this script if needed.