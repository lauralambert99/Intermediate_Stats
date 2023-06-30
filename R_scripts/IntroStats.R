################################################################################
#                        INTRO STAT FUNCTIONS                                  #
################################################################################
#Many basic functions are intuitively named: mean, median, minimum, and maximum for example
#We can perform these operations on a column of a dataframe:
mean(df$height)

median(df$height)

min(df$height)

max(df$height)

#We can also assign the output to an object rather than just having it print to the console:
m <- mean(df$height)
