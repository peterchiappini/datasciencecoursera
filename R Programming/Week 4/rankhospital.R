library(stringr)

rankhospital <- function(state, outcome, num="best") {
        ## Read outcome data
        data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
        
        ## The name of the outcome header in the spreadsheet
        outcome <- str_replace(str_to_title(outcome), " ", ".")
        outcome <- paste("Hospital.30.Day.Death..Mortality..Rates.from", 
                         outcome, sep='.')
        
        ## Check that state and outcome are valid
        if(!(state %in% data$State)){
                stop("invalid state")
        }
        if(!(outcome %in% colnames(data))){
                stop("invalid outcome")
        }
        
        hosp <- data.frame(data[data["State"]==state, ,drop=FALSE])
        hosp <- data.frame(hosp[c("Hospital.Name", outcome)])
        
        hosp <- hosp[order(hosp[["Hospital.Name"]]), ]
        hosp <- hosp[order(as.numeric(hosp[[outcome]])), ]
        hosp <- hosp[hosp[outcome] != "Not Available", ]
        
        if(num=="best"){
                num = 1
        }
        if(num=="worst"){
                num=length(hosp[,1])
        }
        # print(hosp)
        hosp[num, 1]
        
}