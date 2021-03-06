library(tools)
library(devtools)
library(rga)

key_words = "diarypost/diary"
smart_pc_list = list(30593836, 26708871)
list_name = list("smart", "pc");

initial.options <- commandArgs(trailingOnly = FALSE)
file.arg.name <- "--file="
script.name <- sub(file.arg.name, "", initial.options[grep(file.arg.name, initial.options)])
file_name = script.name
dir_name = getwd()
dir_name
currentTime = format(Sys.time(), "%y%m%d%H%M%S")
currentTime
no_extension_name = basename(file_path_sans_ext(file_name))
csv_file = paste(no_extension_name ,'csv', sep = ".")

rga.open(instance="ga", where = "~/Documents/R/ga-api")
#ga$status()
# Use a call to the Management API to query your Profiles and select among them
profiles<-ga$getProfiles()
profiles
# Define the ids and web properties to work with. The web.proporties is reserved for
# the name of the ids for labeling reasons etc
ids<-profiles[1]
start.date = "2014-04-01"
end.date = "2014-04-30"
filter_words = paste("ga:nextPagePath=@", key_words, sep="")
filter_words
LL = list()
for (i in 1:2){
    LL[[i]] = ga$getData(smart_pc_list[[i]], start.date, end.date,
                       metrics = "ga:visits,ga:pageViews,ga:exits,ga:pageviewsPerVisit,ga:entranceRate,ga:avgTimeOnpage,ga:exitRate",dimensions = "ga:previousPagePath,ga:nextPagePath",
                       sort = "-ga:pageViews", filters = filter_words, segment = "",
                       start = 1, max = 150)
}
# Merge files, create metrics
merged.df <- merge(LL[[1]], LL[[2]], all=TRUE)

outputName = "smart_pc"
startTime = strsplit(start.date, "-")
endTime = strsplit(end.date, "-")
startTimeStamp = paste(startTime[[1]], collapse="")
startTimeStamp
endTimeStamp = paste(endTime[[1]], collapse="")
endTimeStamp
timeStamp = paste(startTimeStamp, endTimeStamp, sep="-")
nowPath = paste(outputName, csv_file, sep="-")
nowPath = paste(timeStamp, nowPath, sep="-")
nowPath
total_path = paste(dir_name, nowPath, sep= "/")
total_path
write.csv(LL[[1]], total_path)
write.table(LL[[2]], file = total_path, append=TRUE, sep=",", col.names=TRUE)
