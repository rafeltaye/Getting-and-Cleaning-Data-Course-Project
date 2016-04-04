# Getting-and-Cleaning-Data-Course-Project

This is a project for Getting and Cleaning Data Coursera course.
The R script, `run_analysis.R`, accomplishes the following: all the necessary data sets are copied in to one working dirctory

1. Load the necessary libraries for analysis
2. Loads all the datasets, 
3. keeping only those columns which reflect a mean or standard deviation from train and test data 
4. merge activity and subject data sets
5. Merges the above two datasets
6. Converts the `activity` and `subject` columns into factors
7. Creates a tidy dataset that consists of the average (mean) value of each
   variable. 
8. Output a final_tidy_data
