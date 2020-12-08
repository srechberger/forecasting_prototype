#install.packages("fpp2")
#library(fpp2)
require("fpp2")

############################################################
######### Transformation and Adjustments ###################
############################################################

# Get monthly database
month <- read.csv(file = 'data/monthlyTestData.csv', header=TRUE, sep=";")

tsCsvMonth <- ts(month, start=2011, frequency=12)

##### Calendar Adjustments #####
df_calendarAdj <- cbind(Monthly = tsCsvMonth,
                        DailyAverage = tsCsvMonth/monthdays(tsCsvMonth))

autoplot(df_calendarAdj, facet=TRUE) +
  xlab("Years") + ylab("Sales") +
  ggtitle("Calendar Adjustments")

##### Box-Cox-Transformations #####
# Kombination aus Potenz und Logaritmus
# Die Box-Cox-Transformation ist ein mathematisches Instrument der Regressionsanalyse und 
# der Zeitreihenanalyse, mit dem eine Stabilisierung der Varianz erreicht werden soll 

lambda <- BoxCox.lambda(tsCsvMonth)
boxCoxModel <- BoxCox(tsCsvMonth,lambda)

df_BoxCox <- cbind(Origin = tsCsvMonth,
                   BoxCox = boxCoxModel)

autoplot(df_BoxCox, facet=TRUE) +
  xlab("Years") + ylab("Sales") +
  ggtitle("Box-Cox-Transformation")

##### Bias adjustments #####
# Achtung: Parameter pr?fen
fcSimple <- rwf(tsCsvMonth, drift=TRUE, h=36, level=10)
fcBiasAdj <- rwf(tsCsvMonth, drift=TRUE, h=36, level=10, biasadj=TRUE)

autoplot(tsCsvMonth) +
  autolayer(fcSimple, series="Simple back transformation", PI=FALSE) +
  autolayer(fcBiasAdj, series="Bias adjusted", PI=FALSE) +
  guides(colour=guide_legend(title="Forecast"))

############################################################
############### Remove Data Objects ########################
############################################################
rm(fcBiasAdj, fcSimple, month, df_BoxCox, df_calendarAdj)
rm(boxCoxModel, lambda, tsCsvMonth)
