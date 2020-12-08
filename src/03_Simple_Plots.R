############################################################
################### Time Series Plots ######################
############################################################

#install.packages("ggfortify")
#library(ggfortify)
#require("ggfortify")

#install.packages("fpp2")
#library(fpp2)
require("fpp2")

####### ts() - time series - manual input
tsManual <- ts(c(123,39,78,52,110), start=2012)

autoplot(tsManual) +
  ggtitle("Sales per Year") +
  xlab("Year") +
  ylab("Sales")

####### ts() - time series - data from csv-file
# Get Data from CSV-File
testYear <- read.csv(file = 'data/testData.csv', header=TRUE,sep=";")
testYear$Year <- NULL
testPlots <- testYear

tsCsvYear <- ts(testPlots, start=2011, frequency=1)

autoplot(tsCsvYear) +
  ggtitle("Sales per Year") +
  xlab("Year") +
  ylab("Sales")

############################################################
################### Seasonal Plots #########################
############################################################

# Get Data from CSV-File
testMonth <- read.csv(file = 'data/monthlyTestData.csv', header=TRUE, sep=";")
tsCsvMonth <- ts(testMonth, start=2011, frequency=12)

ggseasonplot(tsCsvMonth, year.labels=TRUE, year.labels.left=TRUE) +
  ylab("Sales") +
  ggtitle("Seasonal plot: sales")

ggsubseriesplot(tsCsvMonth) +
  ylab("Sales") +
  ggtitle("Seasonal plot: sales")

gglagplot(tsCsvMonth)

############################################################
################### Autocorrelation ########################
############################################################

ggAcf(tsCsvMonth)

############################################################
############### Remove Data Objects ########################
############################################################
rm(testMonth, testPlots, testYear)
rm(tsCsvMonth, tsCsvYear, tsManual)
