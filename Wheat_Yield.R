
setwd("C:/Users/Kanha/Desktop/Coursera")

wheat_2013 <- read.csv('wheat-2013-supervised.csv', sep=",", header=TRUE, stringsAsFactors = FALSE)

wheat_2014 <- read.csv('wheat-2014-supervised.csv', sep=",", header=TRUE, stringsAsFactors = FALSE)


wheat<-rbind(wheat_2013,wheat_2014)

sum(is.na(wheat))

wheat<-na.omit(wheat)

class(wheat$Date)

wheat$Date<- sub(" 0:00", "", wheat$Date)

wheat$Date<- sub(" 00:00", "", wheat$Date)

library(lubridate)
wheat$Date<-parse_date_time(x = wheat$Date,
                orders = c("m/d/y", "m-d-y"),
                locale = "eng")


class(wheat$precipTypeIsRain)

wheat$precipTypeIsRain<-as.factor(wheat$precipTypeIsRain) 
wheat$precipTypeIsSnow<-as.factor(wheat$precipTypeIsSnow)
wheat$precipTypeIsOther<-as.factor(wheat$precipTypeIsOther)


# Think About Algo


library(caret)

set.seed(122515)

featureCols <- c("Yield", "Latitude", "Longitude", "Date","apparentTemperatureMax","apparentTemperatureMin","cloudCover","dewPoint","humidity","precipIntensity","precipIntensityMax","precipProbability","precipAccumulation","precipTypeIsRain","precipTypeIsSnow","precipTypeIsOther","pressure","temperatureMax","temperatureMin","visibility","windBearing","windSpeed","NDVI","DayInSeason")

specificWheat <- wheat[,featureCols]

inTrainRows <- createDataPartition(specificWheat$Yield, p=0.10, list=FALSE)

head(inTrainRows,10)

trainDataFiltered <- specificWheat[inTrainRows,]
 
testDataFiltered <- specificWheat[-inTrainRows,]


library(randomForest)
model <- randomForest(Yield ~ ., data = trainDataFiltered)
                         