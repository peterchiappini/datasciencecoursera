library(xlsx)
library(XML)
library(data.table)

# Problem 1
housing_data <- read.csv("getdata_data_ss06hid.csv")

housing_values = housing_data$VAL[!is.na(housing_data$VAL) & housing_data$VAL == 24]
length(housing_values)

# Problem 3
dat <- read.xlsx("getdata_data_DATA.gov_NGAP.xlsx", sheetIndex = 1, rowIndex = 18:23, colIndex = 7:15)
sum(dat$Zip*dat$Ext,na.rm=T)

# Problem 4
fileUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
doc <- xmlTreeParse(fileUrl, useInternal=TRUE)
rootNode <- xmlRoot(doc)
xmlName(rootNode)
zipcodes <- xpathSApply(rootNode, "//zipcode", xmlValue)

sum(zipcodes=="21231")

# Problem 5
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv", destfile = "getdata_data_ss06pid.csv")
DT <- fread("getdata_data_ss06pid.csv")

system.time(DT[,mean(pwgtp15),by=SEX])
# system.time(rowMeans(DT)[DT$SEX==1];rowMeans(DT)[DT$SEX==2])
# system.time(print(tapply(DT$pwgtp15,DT$SEX, mean)))
# system.time(print(mean(DT$pwgtp15, by=DT$SEX)))
# system.time(print(sapply(split(DT$pwgtp15, DT$SEX), mean)))

