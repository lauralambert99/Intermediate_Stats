#Assign data set to an object
df <- sleep

#See what it looks like
head(df)

#Get descriptives
library(psych)
describeBy(df$extra, group = df$group)
