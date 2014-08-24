## Getting and Cleaning Data Project - Code Book

### Environment setup
Check if data.table package is installed, if not install the package.

### Download the untidy data 
The input data is available as a zip file from `https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip`
This zip file is downloaded and extracted in the data sub-directory.

### Read raw data set
The file `features.txt` contains data about features. This data is subsetted into `feature` variable grepl to choose only the records that contain containing `-mean(` or `-std(` in their names. `features.txt` contains feature indices and names. 

The file `activity_labels.txt` contains the information about activity `level` and `labels`. This data is loaded into `activityLabels` table.

The `test` and `training` data is laoded in tables using `loadTrainAndTestData` method.

In total there are 68 variables in the raw dataset: 
 * `subject` - An identifier of the subject who carried out the experiment.
 * `label` - An activity label.
 *  Plus 66 other filtered features were used to estimate variables of the feature vector for each pattern where by `-XYZ` is used to denote 3-axial signals in the X, Y and Z directions. Some of these features include the following
 * `tBodyAcc-XYZ`
 * `tGravityAcc-XYZ`
 * `tBodyAccJerk-XYZ`
 * `tBodyGyro-XYZ`
 * `tBodyGyroJerk-XYZ`
 * `tBodyAccMag`
 * `tGravityAccMag`
 * `tBodyAccJerkMag`
 * `tBodyGyroMag`
 * `tBodyGyroJerkMag`
 * `fBodyAcc-XYZ`
 * `fBodyAccJerk-XYZ`
 * `fBodyGyro-XYZ`
 * `fBodyAccMag`
 * `fBodyAccJerkMag`
 * `fBodyGyroMag`
 * `fBodyGyroJerkMag`

### Tidy data set

The feature variables in the tidy datset were renamed according to following rules:
 * The variables names were converted to satisfy `camlCase` rule.
 * The variable names were already descriptive.
 * The variable names were already unique.
 * Dashes, parentheses and repeating words were removed from variable names.
 
### Output file
The output text file containing the tiday datset has following feature variables

```subject label tBodyAccMeanX tBodyAccMeanY tBodyAccMeanZ tBodyAccStdX tBodyAccStdY tBodyAccStdZ tGravityAccMeanX tGravityAccMeanY tGravityAccMeanZ tGravityAccStdX tGravityAccStdY tGravityAccStdZ tBodyAccJerkMeanX tBodyAccJerkMeanY tBodyAccJerkMeanZ tBodyAccJerkStdX tBodyAccJerkStdY tBodyAccJerkStdZ tBodyGyroMeanX tBodyGyroMeanY tBodyGyroMeanZ tBodyGyroStdX tBodyGyroStdY tBodyGyroStdZ tBodyGyroJerkMeanX tBodyGyroJerkMeanY tBodyGyroJerkMeanZ tBodyGyroJerkStdX tBodyGyroJerkStdY tBodyGyroJerkStdZ tBodyAccMagMean tBodyAccMagStd tGravityAccMagMean tGravityAccMagStd tBodyAccJerkMagMean tBodyAccJerkMagStd tBodyGyroMagMean tBodyGyroMagStd tBodyGyroJerkMagMean tBodyGyroJerkMagStd fBodyAccMeanX fBodyAccMeanY fBodyAccMeanZ fBodyAccStdX fBodyAccStdY fBodyAccStdZ fBodyAccJerkMeanX fBodyAccJerkMeanY fBodyAccJerkMeanZ fBodyAccJerkStdX fBodyAccJerkStdY fBodyAccJerkStdZ fBodyGyroMeanX fBodyGyroMeanY fBodyGyroMeanZ fBodyGyroStdX fBodyGyroStdY fBodyGyroStdZ fBodyAccMagMean fBodyAccMagStd fBodyAccJerkMagMean fBodyAccJerkMagStd fBodyGyroMagMean fBodyGyroMagStd fBodyGyroJerkMagMean fBodyGyroJerkMagStd```

The tidy data file contains, 180 records for 30 subjects and 6 different activities.  
 
