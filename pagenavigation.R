library(devtools)
library(rga)
rga.open(instance="ga", where = "~/Documents/R/ga-api")
#ga$status()
# Use a call to the Management API to query your Profiles and select among them
profiles<-ga$getProfiles()
profiles
# Define the ids and web properties to work with. The web.proporties is reserved for
# the name of the ids for labeling reasons etc
ids<-profiles[1]
start.date = "2014-01-01"
end.date = today()-1
speed = ga$getData(30593836, start.date, end.date, 
                   metrics = "ga:visits,ga:pageViews", dimensions = "ga:previousPagePath,ga:nextPagePath",
                   sort = "-ga:pageViews", filters = "ga:previousPagePath=@recruits,ga:nextPagePath=@recruits", segment = "",
                   start = 1, max = 100)

#write.csv(speed,"/home/kamel/Data/Analytics/recruits_page_navigation.csv")

