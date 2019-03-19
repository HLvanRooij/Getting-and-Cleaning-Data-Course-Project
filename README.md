# Getting-and-Cleaning-Data-Course-Project

# Step 1: Load data in R environment

# Step 2: Merge datasets 
  * Merge Y and X by column 
  * Merge train and testdata by row 
 
# Step 3: Tidy variable names and add to data 
  * Tidy variable names
      - In the variable names, write out "freq" and "time" in full 
      -   Remove "-" and replace with dots 
    
  * Activity factor variable to name the activity performed (Walking etc...) 

  * Change column names of dataset to the actual variable names 
      
# Step 4: Select relevant variables 
  * Select columns that contain the string "mean()" and "std()" 
  * Select the identifier columns, "Subject" and "Activity"
  * Merge these two dataframes so that only the identifier items and the mean/std items are left 
   
# Step 5: Summarize data 
  * Get the mean of all variables, grouped by the combination of Subject and Activity 
  * Export data to a .txt file 
    
