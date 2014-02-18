library(tools)
library(devtools)
library(rga)

initial.options <- commandArgs(trailingOnly = FALSE)
file.arg.name <- "--file="
script.name <- sub(file.arg.name, "", initial.options[grep(file.arg.name, initial.options)])
file_name = script.name
dir_name = getwd()
dir_name
no_extension_name = basename(file_path_sans_ext(file_name))
csv_file = paste(no_extension_name ,'csv', sep = ".")
total_path = paste(dir_name, csv_file, sep= "/")
total_path

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
                   metrics = "ga:visits,ga:pageViews,ga:exits,ga:pageviewsPerVisit,ga:entranceRate,ga:avgTimeOnpage,ga:exitRate", dimensions = "ga:pagePath",
                   sort = "-ga:pageViews", filters = "ga:pagePath=@board", segment = "",
                   start = 1, max = 150)

#write.csv(speed,"/home/kamel/Data/Analytics/recuits_page_path")

write.csv(speed,total_path)
