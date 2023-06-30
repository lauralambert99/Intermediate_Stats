################################################################################
#                   Lists and Dataframes
################################################################################

#MORE ABOUT LISTS 

#Make a list
odd <- c(1, 3, 5, 7, 9)  #A list with numbers (integers, specifically)
gender <- c("male", "female", "nonbinary", "prefer not to respond")  #A list of strings (words)

#You can easily make a sequence of numbers by using the seq() function
numbers <- seq(1:10)

#Also like this
numbers_v2 <- seq(10, 100, by = 10)
numbers_v2

#Or like this
odd_v2 <- seq(1, 97, by = 2)
odd_v2

#Picking a value out of a list
odd_v2[14] #We're asking for the 14th value out of the list named 'odd_v2'

#Saving the same value as an object
val <- odd_v2[14]

#DATAFRAMES

#Assign a pre-existing dataset to a dataframe object
df <- women

#With particularly large datasets, we may not want the entire dataset to print to the console, 
#but rather just the first few rows.  We accomplish this using the head() function
head(df)

#Similarly, we could look at the last few rows using tail()
tail(df)

#Referencing a column
#Using the '$' operator indicates you want that named column from the dataframe
df$height

#We can also reference a column by it's number:
df[,1] #The comma means we want all rows, and the 1 means we just want the first column
