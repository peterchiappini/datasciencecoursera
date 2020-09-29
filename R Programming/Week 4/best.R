library(stringr)

best <- function(state, outcome) {
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

        bst <- data.frame(data[data["State"]==state, ,drop=FALSE])
        bst <- data.frame(bst[c("Hospital.Name", outcome)])

        bst <- bst[order(bst[["Hospital.Name"]]), ]
        bst <- bst[order(as.numeric(bst[[outcome]])), ]

        bst[1, 1]

}

