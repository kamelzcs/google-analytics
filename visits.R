install.packages("devtools")
library(devtools)
install_github("rga", "skardhamar")
library(rga)
rga.open(instance="ga",  where = "~/Documents/R/ga-api")
ga$status()
# Use a call to the Management API to query your Profiles and select among them
profiles<-ga$getProfiles()
# Define the ids and web properties to work with. The web.proporties is reserved for
# the name of the ids for labeling reasons etc
ids<-profiles[1]
start.date = "2014-01-01"
end.date = today()-1
speed = ga$getData(349180, start.date, end.date, 
           metrics = "ga:visits", dimensions = "ga:date",
           sort = "", filters = "", segment = "",
           start = 1, max = 1000)
speed

