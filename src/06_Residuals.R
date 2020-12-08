#install.packages("fpp2")
#library(fpp2)
require("fpp2")

############################################################
######### Residual Diagnostics #############################
############################################################

# Get monthly database
month <- read.csv(file = 'data/monthlyTestData.csv', header=TRUE, sep=";")

# Initialize Time Series
tsCsvMonth <- ts(month, start=2011, frequency=12)

# Plot monthly database
autoplot(tsCsvMonth) +
  xlab("Time") + ylab("Sales") +
  ggtitle("Database")

############# Residuals for naive method ###################
res <- residuals(naive(tsCsvMonth))

autoplot(res) + xlab("Day") + ylab("") +
  ggtitle("Residuals from naïve method")

gghistogram(res) + ggtitle("Histogram of residuals")

ggAcf(res) + ggtitle("ACF of residuals")

############# Residuals for seasonal naive method ##########
sres <- residuals(snaive(tsCsvMonth))

autoplot(sres) + xlab("Day") + ylab("") +
  ggtitle("Residuals from seasonal naïve method")

gghistogram(sres) + ggtitle("Histogram of residuals")

ggAcf(sres) + ggtitle("ACF of residuals")

############# Check Residuals ###############################
checkresiduals(naive(tsCsvMonth))
checkresiduals(snaive(tsCsvMonth))

