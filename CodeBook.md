---
title: "CodeBook"
author: Robert Ruiter
---

## Data

The data comes from measurements of acceleration using a smartphone (Samsung Galaxy S II). The data is divided in a test and a training set, each consisting of several files. For a more detailed description of the measurements see the `features_info.txt` in the zip file. Information about the files you find in the `README.txt` file.

* The [data](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)  
* The [description](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)  

Files used in this project:  
1. `features.txt`: List of all features  
2. `activity_labels.txt`: Links the class labels with their activity name  
3. `train/X_train.txt`: Training set  
4. `train/y_train.txt`: Training labels  
5. `test/X_test.txt`: Test set  
6. `test/y_test.txt`: Test labels  
7. `subject_test.txt`: Test subjects, ranges from 1 to 30  
8. `subject_train.txt`: Training subjects, ranges from 1 to 30  

The resulting dataset is the combination of the test and training data and consists of 69 variables:

* subject  
* activity (in lowercase)   
* source (test or train, designating the origin of the data)  
* 66 features: only those with mean or std (standard deviation)  

For the sake of readability are the features in camelCase notation with the characters `(`, `)` and `-` removed from the orginal featurenames.  
I.e tBodyAcc-mean()-X becomes tBodyAccMeanX.

## Tidy data

The tidy dataset contains the mean of each feature for each subject and activity.

Both datasets are written to a csv file.
