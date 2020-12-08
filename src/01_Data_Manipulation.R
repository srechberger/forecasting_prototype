############################################################
################# Data Manipulation ########################
############################################################

# Get Data from CSV-File
testYear <- read.csv(file = 'data/testData.csv', header=TRUE,sep=";")

# Data manipulation with loop
for (i in 1:nrow(testYear)) {
  if(as.numeric(testYear[i, "Year"]) <= 2015) {
    testYear[i, "Observation"] <- as.numeric(testYear[i, "Observation"]) + 300
  }
}

# Reduce Rows by Condition
testYear <- subset(testYear, testYear$Year > 2010)

# Transform (Type Cast --> INT / Numeric)
testYear <- transform(testYear, 
                      Year = as.integer(Year),
                      Observation = as.numeric(Observation)
)

# Remove Columns from Dataset
testYear$Year <- NULL

############################################################
############### Remove Data Objects ########################
############################################################
rm(testYear, i)
