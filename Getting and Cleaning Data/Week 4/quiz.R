library(quantmod)

# Problem 1
df <- read.csv("ss06hid.csv")
splitDf <- strsplit(paste(colnames(df)), "wgtp")
print(splitDf[123])

# Problem 2
gdp <- read.csv("GDP.csv")
totals <- as.integer(gsub(",", "", paste(gdp$Total)))
print(mean(totals, na.rm = TRUE))

# Problem 3
countryNames <- gdp$Economy
print(length(grep("^United", countryNames)))

# Problem 4

gdp <- fread("GDP.csv", skip=4, nrows = 191, select = c(1, 2, 4, 5), 
             col.names=c("CountryCode", "Rank", "Economy", "Total"))
edstats <- fread("EDSTATS_Country.csv")

merged <- merge(gdp, edstats, by="CountryCode")
print(length(grep("Fiscal year end: June", merged$`Special Notes`)))

# Problem 5
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)

amzn2012 <- sampleTimes[grep("2012", sampleTimes)]
print(length(amzn2012))

amzn2012Formated <- format(amzn2012, "%a %d")
amzn2012Monday <- amzn2012Formated[grep("Mon", amzn2012Formated)]
print(length(amzn2012Monday))
