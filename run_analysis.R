# ________________________________________________________________________
# Project for Getting and cleaning data
# Author : Khurram Majeed
# Course Iteration : August 2014
# ________________________________________________________________________
# Problem Description : The aim of this script file is to perform following:
# 0. Down the data file (optional)
# 1. Merge the training and the test sets to create one data set.
# 2. Extract only the measurements on the mean and standard deviation 
#    for each measurement.
# 3. Use descriptive activity names to name the activities in the data set
# 4. Appropriately label the data set with descriptive activity names.
# 5. Create a second, independent tidy data set with the average of each 
#    variable for each activity and each subject.
# ________________________________________________________________________

#=========================================================================
# Method for printing a message
#=========================================================================

# A helper method for printing to the console.
showMsg <- function(msg) {
  #args <- list(msg)
   #if( !is.null(args[['z']]) ){
  if( !is.null(msg) ){
     cat("[run_analysis.R]", msg, "\n"); 
   }
}

#=========================================================================
# Method to load/install necessary packages and crerate output directory
#=========================================================================
setupEnv = function(){
  
  showMsg ("Checking if data.table package is installed");
  if (!require("data.table")) {
    install.packages("data.table")
  }
  require("data.table");
}
#=========================================================================
# Main Function to perform the analysis
#=========================================================================
run_analysis = function () {
 
  showMsg("Setting the working directory");
  
  setwd('/Users/kmajeed/Development/Coursera/Gits/gacdproject');
  # Load the needed packages 
  setupEnv();
  
  # Download the dataset if not already present
  downloadData();  
  #_________________________________________________________________
  # Read the names of the features
  #_________________________________________________________________
  
  showMsg("Processing features");
  
  featureFile = './data/UCI HAR Dataset/features.txt';
  featureSet = read.table(featureFile, 
                           col.names = c('index', 'name')
                          #,stringsAsFactors = FALSE
                          );
  
  #Subset the data to only include records that have mean or std
  features = subset(featureSet, grepl('-(mean|std)[(]', featureSet$name));
  #_________________________________________________________________
  # Read the activity labels
  #_________________________________________________________________
  
  showMsg("Processing activity data");
  
  activityFile = './data/UCI HAR Dataset/activity_labels.txt';
  activityLabels = read.table(activityFile, 
                               col.names = c('level', 'label')
                              #,stringsAsFactors = FALSE
                              );
  #_________________________________________________________________
  # Read the training and testdataset
  #_________________________________________________________________
  
  showMsg("Processing training data");
  
  trainingDir = 'train';
  trainingData = loadTrainAndTestData(trainingDir, features, activityLabels);
  
  showMsg("Processing test data");
  
  testDir = 'test';
  testData = loadTrainAndTestData(testDir, features, activityLabels);
  
  #_________________________________________________________________
  # Combine the training and test datasets
  #_________________________________________________________________
  dataset = rbind(trainingData, testData);
  
  #_________________________________________________________________
  # Generate the tidy data set
  #_________________________________________________________________
  showMsg("Generating tidy data");
  
  tidyDataSet = dataset[, 
                        lapply(.SD, mean),
                        by=list(subject,label)];
  #_________________________________________________________________
  # Now change the names to pretty readable names
  #_________________________________________________________________
  names = names(tidyDataSet);
  
  # Set Mean
  names = gsub('-mean', 'Mean', names); 
  
  # Set Std
  names = gsub('-std', 'Std', names); 
  
  # Remove the parenthesis and dashes
  names = gsub('[()-]', '', names); 
  
  # Fix BodyBody duplicate
  names = gsub('BodyBody', 'Body', names); 
  
  # Replace existing the names to prety names
  setnames(tidyDataSet, names);
  
  # Write the raw and the tidy data sets to files
  ######## #setwd('..')
  # Check if the output directory doesn't exist then create it
  if (!file.exists("output")){
    dir.create("output")
  }
  
  #_____________________________________________________________________
  #  Write output to text files
  #_____________________________________________________________________
  
  showMsg("Writing merged data");
  
  # Merged data set
  write.table(dataset,
              file = './output/rawdata.txt',  
              row.names = FALSE
    );
  
  showMsg("Writing tidy data");
  #Tidy dataset
  write.table(tidyDataSet,
              file = './output/tidyData.txt',  
              row.names = FALSE, 
              quote = FALSE
  );
  #_____________________________________________________________________
  #  Optional: write the output to CSV files
  #_____________________________________________________________________
  #write.csv(tidyDataSet, file = './output/rawdata.csv', row.names = FALSE);
  
  #write.csv(tidyDataSet, file = './output/tidydata.csv',row.names = FALSE,  quote = FALSE);
  
  # Return the tidy data set
  tidyDataSet;
}
#=========================================================================
# Function to download data and extract it it into data directory
#=========================================================================
downloadData = function () {
  showMsg("Downloading data");
  # Check if the data directory doesn't exist then craete it
  if (!file.exists("data")){
    dir.create("data")
  }
  
  # The url of the dataset
  zipUrl = 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
  # The name for downloaded zip file
  zipFile = './data/dataset.zip'
  
  #Only download if the file doean't exist
  if (!file.exists(zipFile)){
    # download the file
    download.file(zipUrl, destfile = zipFile, method="curl");
    
    #Now unzip the file
    unzip(zipFile,exdir = "./data")
  }
}

#=========================================================================
# Function to load test/training data
#=========================================================================
loadTrainAndTestData = function (set, features, activityLabels) {
  
  #_________________________________________________________________
  # Create paths of files in test or training directory
  #_________________________________________________________________
  dirPath = paste('./data/UCI HAR Dataset/',set, '/', sep = '');  
  xFile = paste(dirPath, 'X_', set, '.txt', sep = '');
  yFile = paste(dirPath, 'y_', set, '.txt', sep = '');
  subjectFile = paste(dirPath, 'subject_', set, '.txt', sep = '');
  
  #_________________________________________________________________
  # Read the data into a data.frame
  #_________________________________________________________________
  xData = read.table(xFile)[, features$index];
  
  #Set the names for the xData using names from features list
  names(xData) = features$name;
  
  #Get Data from y
  yData = read.table(yFile)[, 1];
  
  # Set the xData labels
  xData$label = factor(yData, levels=activityLabels$level, labels=activityLabels$label);
  
  # read the data about subjects
  subjectData = read.table(subjectFile)[, 1];
  
  #Set the subject in xData
  xData$subject = factor(subjectData);
  
  # convert to data table
  data.table(xData);
}
