################################################################################
#                       R Basics
################################################################################

#HOW TO LOAD AND CALL A PACKAGE

#Many things can be done in "base R" - what is installed with the basic R installation.
#Some specialized functions or upgrades to base R come in packages
#You install these from CRAN, and then call them when you want to use them

#If you don't have the package yet:
install.packages("package_name")
#Pay careful attention to capitalization and spelling!

#If you've already installed the package on your machine and just need to call it:
library(package_name)

#Once you have a package, you can get information about it in the help window:
?package_name_here

#An actual working example of the above lines of code can be seen below, as we install
#ggplot2, a useful package for visualizing your data
install.packages("ggplot2")
library(ggplot2)
?ggplot2

#HOW TO SET A WORKING DIRECTORY

#Notice the double "\" - when you copy the file path of your folder (shift + right click for PC users)
#It will paste with only one "\".  You need to add in the extra.
setwd("file\\path\\goes\\here")

#Check what your working directory is
getwd()

#HOW TO READ IN A DATASET FROM R

#R has built-in datasets that can be used to illustrate different analysis techniques
#If you wanted to see a list and brief description of them you could do:
library(help = "datasets")

#If we just call a dataset, it will print to our console:
women

#We can assign one of the datasets to an object, which will then allow us to perform 
#other operations on it
df <- women

#If we wanted to then see the dataset, we would call the object 
df


#HOW TO READ IN A DATASET FROM A DIFFERNT FILE
install.packages("readxl") #Install package if you have not done so
library(readxl) #Call the package

#Pay attention to file extension!  
#File is already in your working directory
df_excel_new <- read_excel("your_filename.xlsx") 

#File is not in your working directory
df_excel_old <- read_excel("file\\path\\goes\\here\\data.xls")  


#To read in .tsv files, you need the readr package
#This can also be used to read in .csv files
install.packages("readr")
library(readr)

#Read in TSV file; file in working directory
df_TSV <- read_tsv("filename.tsv") 

#Reading in a .csv file using the readr package
df_CSV <- read_csv("filename.csv")

#.csv files can also be read in using base R, with no external packages needed
#Read in a CSV file; file not in working directory
df_CSV_v2 <- read.csv("file\\path\\goes\\here\\filename.csv") 


#SAS
install.packages("haven")
library(haven)

df_SAS <- read_sas("filename.sas7bdat") 

#SPSS
install.packages("haven")
library(haven)

df_SPSS <- read_sav("filename.sav")

#WHEN TO USE QUOTES

#If something is a 'string' or characters (ie, words), it is denoted by quotes. 
install.packages("ggplot2") #R recognizes this as a package name

#Making a list as below, each of the items will be treated as words; we cannot perform
#any mathematical operations on these
fruits <- c("apples", "oranges", "bananas")

#Numbers are not put in quotes
#This is also a list, but with numbers and R recognizes it as numbers
#We could perform operations on this list
odd <- c(1, 3, 5, 7, 9)


