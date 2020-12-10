#install.packages("fpp2")
#library(fpp2)
require("fpp2")

############################################################
######### Evaluating forecast accuracy #####################
############################################################

# Get Data from CSV-File
testMonth <- read.csv(file = 'data/monthlyTestData.csv', header=TRUE, sep=";")
tsCsvMonth <- ts(testMonth, start=2011, frequency=12)

##################### Forecast errors ############################
# A forecast “error” is the difference between an observed value and its forecast. 
# Here “error” does not mean a mistake, it means the unpredictable part of an observation.

# forecast period
h <- 24

# split data in training and test data
train <- window(tsCsvMonth, end=2016)
test <- window(tsCsvMonth, start=2016)

# forecasts with different models
meanForecast <- meanf(train, h)
naiveForecast <- naive(train, h)
snaiveForecast <- snaive(train, h)
naiveDriftForecast <- rwf(train, h, drift=TRUE)

# plot forecasts
autoplot(tsCsvMonth) +
  autolayer(meanForecast, series="Mean", PI=FALSE, showgap=TRUE) +
  autolayer(naiveForecast, series="Naive", PI=FALSE, showgap=TRUE) +
  autolayer(snaiveForecast, series="Seasonal naive", PI=FALSE, showgap=TRUE) +
  autolayer(naiveDriftForecast, series="Drift naive", PI=FALSE, showgap=TRUE) +
  ggtitle("Methoden-Vergleich") +
  xlab("Jahre") + ylab("Absatzmenge") +
  guides(colour=guide_legend(title="Methode"))

# check accuracy
accuracy(meanForecast, test)
accuracy(naiveForecast, test)
accuracy(snaiveForecast, test)
accuracy(naiveDriftForecast, test)

############################################################
############### Remove Data Objects ########################
############################################################
rm(tsCsvMonth, testMonth, h, test, train)
rm(meanForecast, naiveDriftForecast, naiveForecast, snaiveForecast)
