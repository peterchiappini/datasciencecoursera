library(httr)
library(sqldf)
# PROBLEM 1
oauth_endpoints("github")

myapp <- oauth_app("github",
                   key = "e60d1c464f658054d81a",
                   secret = "5fde2ac1529b22d3cf1d4b0b0a38005478a9ff3d"
)

# Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

gtoken <- config(token = github_token)

#  Use API
req <- with_config(gtoken, GET("https://api.github.com/users/jtleek/repos"))
con_request <- content(req)


find_create <- function(x,myurl) {
        if (x$html_url == myurl) {
                print(x$created_at)
        }
}

lapply(con_request, find_create, myurl ="https://github.com/jtleek/datasharing")

# Problem 2
acs <- read.csv("getdata_data_ss06pid.csv")
head(sqldf("select pwgtp1 from acs where AGEP < 50"))

# Problem 3
sqldf("select distinct AGEP from acs")

# Problem 4
con = url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode = readLines(con)
close(con)
nchar(htmlCode[100])

# Problem 5
data <- read.fwf("getdata_wksst8110.for", skip=4,
                 widths=c(12, 7, 4, 9, 4, 9, 4, 9, 4))
sum(data[,4])

      