library(stringr)

pollutantmean <- function(directory, pollutant, id = 1:332) {
        vals = c()
        for (i in id) {
                path <- sprintf("Week 2/%s/%s.csv", directory, str_pad(i, 3, pad = "0"))
                x <- read.csv(file=path)[pollutant]
                x<-x[!is.na(x)]
                
                vals <- c(vals, x)
        }
        mean(vals)
}

complete <- function(directory, id = 1:332) {
        nobs = c()
        for (i in id) {
                path <- sprintf("Week 2/%s/%s.csv", directory, str_pad(i, 3, pad = "0"))
                x <- read.csv(file=path)
                
                good_rows <- !is.na(x["sulfate"]) & !is.na(x["nitrate"])
                
                nobs <- c(nobs, length(good_rows[good_rows==TRUE]))
        }
        data.frame(id, nobs)
}

corr <- function(directory, threshold = 0){
        cors = c()
        for (i in 1:332) {
                path <- sprintf("Week 2/%s/%s.csv", directory, str_pad(i, 3, pad = "0"))
                x <- read.csv(file=path)
                
                if (complete(directory, i)["nobs"] > threshold) {
                        
                        cors <- c(cors, cor(x["sulfate"], x["nitrate"], use = "pairwise.complete.obs"))
                }
        }
        cors
}

