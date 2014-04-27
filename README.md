## run_analysis.R

There is one script for this project. It is called run_analysis.R.

It requires the working directory to be the \getdata_projectfiles_UCI HAR Dataset\UCI HAR Dataset directory with the \test and \train subdirectories present.

The folllwong files are expected to be in the working directory:

activity_labels.txt
features.txt

The following files are expected to be in the /test subdirectory below the working directory:

* subject_test.txt
* X_test.txt
* y_test.txt

The following files are expected to be in the /train subdirectory below the working directory:

* subject_test.txt
* X_train.txt
* y_test.txt

The function is called from the command line with no parameters:

* run_analysis()

The function outputs two csv files in the working directory:

* comboMeasurements.csv
* tidyMeasurements.csv

The contents of these files is described in the accompanying run_analysis.R code book, CodeBook.md.

