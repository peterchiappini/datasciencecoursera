library(stringr)


getnum <- function(numb, v){
        if(numb=="best"){
                numb <- 1
        }
        if(numb=="worst"){
                numb <- length(v[,1])
        }
        print(numb)
        numb
}


rankall <- function(outcome, num="best") {
        ## Read outcome data
        data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
        
        ## The name of the outcome header in the spreadsheet
        outcome <- str_replace(str_to_title(outcome), " ", ".")
        outcome <- paste("Hospital.30.Day.Death..Mortality..Rates.from", 
                         outcome, sep='.')
        
        ## Check that outcome is valid
        if(!(outcome %in% colnames(data))){
                stop("invalid outcome")
        }
        
        # Relevant Columns
        data <- data[c("Hospital.Name", "State", outcome)]
        
        # Split each state into its own data frame
        data <- split(data, data$State)
        
        # Ordering
        ordered_by_hospital_names <- lapply(data, function(x) x[order(x[["Hospital.Name"]]), ])
        ordered_by_outcome <- lapply(ordered_by_hospital_names, function(x) x[order(as.numeric(x[[outcome]])), ])
        ordered_by_outcome <- lapply(ordered_by_outcome, function(x) x[x[outcome] != "Not Available", ])

        # Get the relevant entry from each state and put everything back into a single data frame
        hosps <- lapply(ordered_by_outcome, function(x) c(x[getnum(num, x), 1], x[1, 2]))
        hosps <- data.frame(matrix(unlist(hosps), nrow=length(hosps), byrow=T))
        colnames(hosps) <- c("hospital", "state")
        
        hosps
}