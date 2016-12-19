---
title: "README"
author: Robert Ruiter
---

## Introduction

In this repository is the course project for Getting and Cleaning data.

### run_analysis.R

The file consists of the code for reading the files and processing and analyzing the data.
R packages `dployr` and `tidyr` are required and will be loaded when running the code.

Two csv files will be saved at the end of the code, `mergeddata.csv` and `tidydata.csv`:  
1. mergeddata.csv contains the data with variables for subject and activity.  
2. tidydata.csv contains the tidy data with the mean of each variable for subject and activity.  

### Processing steps

1. Read `features.txt`  
2. Use `grep` to select only features with mean or std
3. Use `gsub` to clean features (remove `(`, `)` and `-`) and make names CamelCase
4. Convert feature_id to match with the columnnames from the test and training data
5. Read the testdata
6. Select the variables from the testdata according to previous selected features
7. Name the columns with the selected features
8. Read the subjects
9. Read the activity id's
10. Read the activity labels
11. Convert the activity labels to lowercase
12. Merge the activity labels to the activity id's
13. Merge the subject and activities to the testdata
14. Repeat step 5 to 14 for the traing data
15. Add a column to designate the origin of the data
16. Merge the test and training data with `bind_rows`
17. Remove unused objects
18. Tidy data and calculate the mean of each variable for each subject and activity
19. Write the merged data to `mergeddata.csv` and the tidy data to `tidydata.csv`

### CodeBook.md

The variables used in the processed data you can find in the CodeBook.md
