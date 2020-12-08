#install.packages("fpp2")
#library(fpp2)
require("fpp2")

############################################################
######### Time Series Cross Validation #####################
############################################################

# Get Data from CSV-File
testMonth <- read.csv(file = 'data/monthlyTestData.csv', header=TRUE, sep=";")

# Convert to time series object
tsCsvMonth <- ts(testMonth, start=2011, frequency=12)

# forecast period
h <- 24

# split data in training and test data
train <- window(tsCsvMonth, end=2016)
test <- window(tsCsvMonth, start=2016)

# forecast-method (general method to generate forecasts)
forecast(train, h)

##############################################################################
########################### Usage of RMSE ####################################
##############################################################################

# Time series cross-validation is implemented with the tsCV() function
eNaiveDriftForecast <- tsCV(train, rwf, drift=TRUE, h)
eSNaiveForecast <- tsCV(train, snaive, h)

############### Comparison CV RMSE and residuals RMSE #######
# naive bayes with drift - RMSE obtained via time series cross-validation
sqrt(mean(eNaiveDriftForecast^2, na.rm=TRUE))
#> [1] 370.7951

# naive bayes with drift - residual RMSE
sqrt(mean(residuals(rwf(train, drift=TRUE))^2, na.rm=TRUE))
#> [1] 138.1601

############### Comparison CV RMSE and residuals RMSE #######
# seasonal naive bayes - RMSE obtained via time series cross-validation
sqrt(mean(eSNaiveForecast^2, na.rm=TRUE))
#> [1] 78.53059

# seasonal naive bayes - residual RMSE
sqrt(mean(residuals(snaive(train))^2, na.rm=TRUE))
#> [1] 19.63961

############### CV Comparison ###############################
# A good way to choose the best forecasting model is to find the model 
# with the smallest RMSE computed using time series cross-validation
# e.g. 78.53059 from the seasonal naive bayes is better than 370.7951

### --- Pipe Operator: alternative way to join R-functions --- ###
train %>% tsCV(forecastfunction=snaive, h) -> e
e^2 %>% mean(na.rm=TRUE) %>% sqrt()
#> [1] 78.53059

train %>% snaive %>% residuals() -> res
res^2 %>% mean(na.rm=TRUE) %>% sqrt()
#> [1] 19.63961

##############################################################################
########################### Usage of MSE #####################################
##############################################################################

# seasonal naive bayes forecast
eSNaiveForecast <- tsCV(train, forecastfunction=snaive, h=4)

# Compute the MSE values and remove missing values
mse <- colMeans(eSNaiveForecast^2, na.rm = T)

# Plot the MSE values against the forecast horizon
# 1- to 4-step-ahead
data.frame(h = 1:4, MSE = mse) %>%
  ggplot(aes(x = h, y = MSE)) + geom_point()

############################################################
############### Remove Data Objects ########################
############################################################
rm(tsCsvMonth, testMonth, h, test, train, mse)
rm(e, eNaiveDriftForecast, eSNaiveForecast, res)
