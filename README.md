---
title: "Getting and cleaning data - final project - README"
output: github_document
---

Getting and cleaning data course project

The goal is to prepare tidy data that can be used for later analysis. 

The data linked to from the course website represent data collected from the accelerometers from 
the Samsung Galaxy S smartphone.

=========================================

The dataset includes the following files:

- this "README.md"
- "run_analysis.R": R script to tidy data given in the assignment
- "CodeBook.md": code book to "tidy_data.txt"

=========================================

"run_analysis.R"

- downloads the "UCI HAR Dataset" linked in the assignment
- reads and merges data in test and train dataset
- adds to data columns to specify subject and type of activity for every observation
- renames activities and variables to make them more descriptive
- creates the "tidy_data" table according to instructions and saves it as a .txt file

Remark: I tried to create a self cointained script, that starts by downloading the data.
After running it, the working directory will contain:
- a folder called "temp_betta4242" conteining the original data, zipped and unzipped
- the final "tidy_data.txt" file

=========================================

"tidy_data.txt"

- 180 observations of  68 variables:
- first column: wich subject, from 1 to 30
- second column: wich activity, in a list of 6 possible activities
- colum from 3 to 68 averege for subject and activity given by the row, for variable given by the coulum name
(more details in "CodeBook.md")

