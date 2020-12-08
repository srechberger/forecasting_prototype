#install.packages("fpp2")
#library(fpp2)
require("fpp2")

# Get Data from CSV-File
testMonth <- read.csv(file = 'data/monthlyTestData.csv', header=TRUE, sep=";")
tsCsvMonth <- ts(testMonth, start=2011, frequency=12)

############################################################
################### Mean Function ##########################
############################################################
# tsCsvQuarter contains the time series
# h is the forecast horizon

h <- 10

### mean function
meanForecast <- meanf(tsCsvMonth, h)

autoplot(meanForecast) +
  ggtitle("Mean Function") +
  xlab("Year") +
  ylab("Sales")

### naive bayes
naiveForecast <- naive(tsCsvMonth, h) # Equivalent alternative: rwf(tsCsvQuarter, h) 

autoplot(naiveForecast) +
  ggtitle("Naive Bayes") +
  xlab("Year") +
  ylab("Sales")

### seasonal naive bayes
snaiveForecast <- snaive(tsCsvMonth, h)

autoplot(snaiveForecast) +
  ggtitle("Seasonal Naive Bayes") +
  xlab("Year") +
  ylab("Sales")

### drift method (naive)
naiveDriftForecast <- rwf(tsCsvMonth, h, drift=TRUE)

autoplot(naiveDriftForecast) +
  ggtitle("Naive Bayes with Drift") +
  xlab("Year") +
  ylab("Sales")

##### method comparison (PI=False stands for "Logical flag indicating whether to plot PREDICTION INTERVALS")
# Plot some forecasts
autoplot(tsCsvMonth) +
  autolayer(meanForecast, series="Mean", PI=FALSE, showgap=TRUE) +
  autolayer(naiveForecast, series="Naive", PI=FALSE,showgap=TRUE) +
  autolayer(snaiveForecast, series="Seasonal naive", PI=FALSE, showgap=TRUE) +
  autolayer(naiveDriftForecast, series="Drift naive", PI=FALSE, showgap=TRUE) +
  ggtitle("Method Comparison") +
  xlab("Year") + ylab("Sales") +
  guides(colour=guide_legend(title="Forecast"))

############################################################
############### Remove Data Objects ########################
############################################################
rm(meanForecast, naiveForecast, naiveDriftForecast, snaiveForecast, testMonth)
rm(h, tsCsvMonth)
