#install.packages("fpp2")
#library(fpp2)
require("fpp2")

############################################################
######### Evaluating forecast accuracy #####################
############################################################

# Get monthly database
month <- read.csv(file = 'data/monthlyTestData.csv', header=TRUE, sep=";")

# Initialize Time Series
tsCsvMonth <- ts(month, start=2011, frequency=12)

########### Window Function ################################
# Function supports splitting of time series
tsSubsetStart <- window(tsCsvMonth, start=2016) # Alternative: tail(tsCsvMonth, 12*3)
tsSubsetEnd <- window(tsCsvMonth, end=2016) # Alternative: head(tsCsvMonth, 12*4+1)

autoplot(tsCsvMonth) +
  autolayer(tsSubsetStart, series="Start 2016") +
  autolayer(tsSubsetEnd, series="End 2016") +
  ggtitle("Splitting Time Series") +
  xlab("Year") + ylab("Sales") +
  guides(colour=guide_legend(title="Subset"))

########### Subset Function ################################
# extract the last 3 years (12 months x 3 years)
tsSubsetLast3Years <- subset(tsCsvMonth, start=length(tsCsvMonth)-12*3)

# extract only month june
tsSubsetOnlyJune <- subset(tsCsvMonth, month = 6)

############################################################
############### Remove Data Objects ########################
############################################################
rm(month, tsCsvMonth, tsSubsetStart, tsSubsetEnd)
rm(tsSubsetLast3Years, tsSubsetOnlyJune)
