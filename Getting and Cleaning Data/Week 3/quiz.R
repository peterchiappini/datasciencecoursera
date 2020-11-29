library(jpeg)
library(data.table)
library(reshape2)


# Problem 1
housingData <- read.csv("ss06hid.csv")

agricultureLogical <- housingData$ACR == 3 & housingData$AGS == 6

print(which(agricultureLogical))


# Problem 2
jeffjpg <- readJPEG("jeff.jpg", native=TRUE)

print(quantile(jeffjpg, c(.3, .8)))


# Problem 3
gdp <- fread("GDP.csv", skip=4, nrows = 191, select = c(1, 2, 4, 5), 
             col.names=c("CountryCode", "Rank", "Economy", "Total"))

edstats <- fread("EDSTATS_Country.csv")

merged <- merge(gdp, edstats, by="CountryCode")
print(nrow(merged))

revSortByRank <- merged[order(-Rank)]
print(revSortByRank[13]$`Long Name`)


# Problem 4

splitByIg <- split(merged$Rank, merged$`Income Group`)
print(mean(splitByIg$`High income: OECD`))
print(mean(splitByIg$`High income: nonOECD`))

# Problem 5
breaks <- quantile(merged[, Rank], probs = seq(0, 1, 0.2), na.rm = TRUE)
merged$quantileGDP <- cut(merged[, Rank], breaks = breaks)

lowerMidIncome <- merged[`Income Group` == "Lower middle income"]

newTable <- lowerMidIncome[, .N, by=c("Income Group", "quantileGDP")]

print(newTable)


