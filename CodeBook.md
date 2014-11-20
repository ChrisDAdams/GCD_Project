The run_analysis.R script assumes that the input files have been downloaded and unzipped into a directory in 
the working directory.

The script reads the training and test data files into seperate data.tables than merges the subject/activity/data 
for each set.

Merges the training and test data.tables.  

Subsets the means and standard deviation data annotating the activity and cleaning the column/variable names.

Returns the cleaned data.table.
