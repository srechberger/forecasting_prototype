############################################################
############### Data Aggregation ###########################
############################################################

#install.packages("dplyr")
library("dplyr")

# Get Data from CSV-File
agg <- read.csv(file = 'data/aggregation.csv', header=TRUE, sep=";")

# Transform (Type Cast --> INT / Numeric)
agg <- transform(agg, val = as.numeric(val))

# count elements by group
countData <- agg %>%
  group_by(group) %>%
  summarize(n = n())

# sum up values by group
sumData <- agg %>%
  group_by(group) %>%
  summarize(Total = sum(val))

############################################################
############### Remove Data Objects ########################
############################################################
rm(agg, countData, sumData)
