################################################################################
#                       R Basics
################################################################################
#A comment looks like this
mean(x) #A comment can also come after a section of code and in the same line

#To install the package tidyverse:
install.packages("tidyverse")

#Call the package
library(tidyverse)

#Get information about the package
?tidyverse

#Set a working directory
setwd("file\\path\\goes\\here")

#Check working directory
getwd()

#Call up a dataset
women

install.packages("readxl") #Install package if you have not done so
library(readxl) #Call the package

#Pay attention to file extension!  Be sure what you type matches your file.
#.xlsx
df_excel_new <- read_excel("your_filename.xlsx") 

#.xls (file not in working directory)
df_excel_old <- read_excel("file\\path\\goes\\here\\data.xls")  

#Read in by sheet number
df_sheet2 <- read_excel("filename.xlsx", sheet = 2)

#Read in by sheet name
#Make sure to exactly match capitalization!
df_stud <- read_excel("filename.xls", sheet = Students) 

#To read in .tsv files, you need the readr package
#This can also be used to read in .csv files
#NOTE: if you have installed tidyverse, readr is contained within that package, and you won't need to reinstall it!
install.packages("readr")
library(readr)

#Read in TSV file; file in working directory
df_TSV <- read_tsv("filename.tsv") 

#Reading in a .csv file using the readr package
#Telling it that the first row should NOT be treated as column names 
df_CSV <- read_csv("filename.csv", col_names = FALSE)

#.csv files can also be read in using base R, with no external packages needed
df_CSV_v2 <- read.csv("filename.csv") 

#SAS
install.packages("haven")
library(haven)

df_SAS <- read_sas("filename.sas7bdat") 

#SPSS
install.packages("haven")
library(haven)

df_SPSS <- read_sav("filename.sav")