############################################################
################### STL Decomposition ######################
############################################################

#install.packages("ggfortify")
#library(ggfortify)
#require("ggfortify")

#install.packages("fpp2")
#library(fpp2)
require("fpp2")

#install.packages("seasonal")
require("seasonal")

# Get database
db <- read.csv(file = 'data/Beispiel_Grundlagen.csv', header=TRUE, sep=";")

# Initialize Time Series
tsDB <- ts(db, start=c(2018,1), frequency=12)
autoplot(tsDB)

tsDB %>% seas() %>%
  autoplot() +
  ggtitle("SEATS Komponentenzerlegung der Absatzmenge") +
  xlab("Zeit")

autoplot(tsDB) +
  ggtitle("Sales per Year") +
  xlab("Year") +
  ylab("Sales")

ggseasonplot(tsDB, year.labels=TRUE, year.labels.left=TRUE) +
  ylab("Sales") +
  ggtitle("Seasonal plot: sales")

