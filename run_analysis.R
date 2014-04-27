run_analysis<-function() {
      #
      # Author Steve Petersen
      # stevencpetersen@yahoo.com
      # Created April 2014
      #
      
      # Must be in the "\getdata_projectfiles_UCI HAR Dataset\UCI HAR Dataset\" directory.

      # Read in the headers
      h<-readLines("features.txt")
      
      # Create an index of columns with "mean" or "std" in them.
      hi_headers<-grep("mean|std",h)
      
      # Set all to initially be excluded (w/ -16, the length of each column).
      h_index<-rep(-16,561)
      
      # Initializing the column heading table.
      col_head<-rep(" ", length(hi_headers)+2)
      col_head[1]<-"Subject"
      col_head[2]<-"Activity"
      ch_i<-2
      
      # Need 561 column widths for read.fwf...
      # Cruise over them and create an index for read.fwf to include (w/ +16) columns with
      # "mean" or "std" in them, indexed by hi_headers.
      # Also build a header row.
      for(i in 1:length(hi_headers)) {
            ch_i<-ch_i+1
            h_index[hi_headers[i]]=16
            col_head[ch_i]<-h[hi_headers[i]] #unlist(strsplit(h[hi_headers[i]]," f| t"))[2]
      }

      # Get the activity labels.
      a_labels<-readLines("activity_labels.txt")
      
      # Build test activity column readable labels, minus the numeric identifier.
      a_index<-readLines("./test/y_test.txt")
      for(i in 1:length(a_index)) {
            a_index[i]<-substr(a_labels[as.numeric(a_index[i])],3,nchar(a_labels[as.numeric(a_index[i])]))
      }
      
      # Read in the test data.
      test<-read.fwf("./test/X_test.txt",width=h_index)
      
      # Get subjects for test
      subj<-readLines("./test/subject_test.txt")
      
      # Add in the activity labels and subjects to test
      test<-cbind(test,a_index,subj) 

      # Put the activity and subjects on the left
      test<-test[c(81,80,1:79)]
      
      # Build train activity column readable labels, minus the numeric identifier.
      a_index<-readLines("./train/y_train.txt")
      for(i in 1:length(a_index)) {
            a_index[i]<-substr(a_labels[as.numeric(a_index[i])],3,nchar(a_labels[as.numeric(a_index[i])]))
      }
      
      # Read in the train data.
      train<-read.fwf("./train/X_train.txt",width=h_index)
      
      # Get subjects for train
      subj<-readLines("./train/subject_train.txt")
      
      # Add in the activity labels and subjects to train
      train<-cbind(train,a_index,subj) 
    
      # Put the activity and subjects on the left
      train<-train[c(81,80,1:79)]
      
      # Concatenate them together by row
      comboMeasurements<-rbind(test,train)
      
      # Add column names.
      colnames(comboMeasurements)<-col_head
      
      # Melt comboMeasurements into 3 columns - Subject, Avtivity, Measurement
      molten<-melt(t, id=c("Subject", "Activity"))
      
      # Dcast to create single line per Subject/ Activity with the mean of each measurement
      dmolten<-dcast(molten, Subject + Activity ~ variable, mean)
      
      # Write out measurements to a csv file
      write.csv(comboMeasurements,"comboMeasurements.csv", row.names=FALSE)
      
      # Write out summary data
      write.csv(dmolten,"tidyMeasurements.csv", row.names=FALSE)
}