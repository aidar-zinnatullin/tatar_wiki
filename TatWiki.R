#### Wikipedia
library(here)
library(httr)
library(jsonlite)
library(dplyr)
library(ggplot2)
library(lubridate)
library(scales)
library(grid)
library(ggpubr)
options(scipen = 999)
tat_wiki <- GET('https://wikimedia.org/api/rest_v1/metrics/pageviews/aggregate/tt.wikipedia/all-access/all-agents/daily/2013072700/2023072700')
json_result_ru <- content(tat_wiki, "text", encoding="UTF-8")
tat_wiki <-jsonlite::fromJSON(txt = json_result_ru, flatten = TRUE)
str(tat_wiki$items)
tat_wiki <- as.data.frame(tat_wiki$items)
save(tat_wiki, file = "data/Daily_Visits.RData")

# monthly
tat_wiki_monthly <- GET('https://wikimedia.org/api/rest_v1/metrics/pageviews/aggregate/tt.wikipedia/all-access/all-agents/monthly/2013072700/2023072700')
json_result_ru <- content(tat_wiki_monthly, "text", encoding="UTF-8")
tat_wiki_monthly <-jsonlite::fromJSON(txt = json_result_ru, flatten = TRUE)
str(tat_wiki_monthly$items)
tat_wiki_monthly <- as.data.frame(tat_wiki_monthly$items)
save(tat_wiki_monthly, file = "data/Monthly_Visits.RData")


# the most viewed articles of Tatar Wikipedia
### I need to loop
### so, it is possible to get data for the last 8 years
tat_most_visited <- GET('https://wikimedia.org/api/rest_v1/metrics/pageviews/top/tt.wikipedia/all-access/2023/06/all-days')
json_result_ru <- content(tat_most_visited, "text", encoding="UTF-8")
tat_most_visited <-jsonlite::fromJSON(txt = json_result_ru, flatten = TRUE)
str(tat_most_visited$items$articles)
tat_most_test <- as.data.frame(tat_most_visited$items$articles)
tat_most_test$period <- "2015-07"
# Using sprintf to create a vector from 01 to 12 with leading zeros

for (i in sprintf("%02d", 8:12)) {
  tat_most_visited <- GET(paste("https://wikimedia.org/api/rest_v1/metrics/pageviews/top/tt.wikipedia/all-access/2015", i, "all-days", sep = "/"))
  json_result_ru <- content(tat_most_visited, "text", encoding="UTF-8")
  tat_most_visited <-jsonlite::fromJSON(txt = json_result_ru, flatten = TRUE)
  str(tat_most_visited$items$articles)
  tat_most_visited <- as.data.frame(tat_most_visited$items$articles)
  tat_most_visited$period <- paste("2015", i, sep = "-")
  tat_most_test <- rbind(tat_most_test, tat_most_visited)
}
table(tat_most_test$period)
table_most_visited_2015 <- tat_most_test

# below is the period from 2016 to 2022
for(k in c(2016:2022)){
  for (i in sprintf("%02d", 1:12)) {
    tat_most_visited <- GET(paste("https://wikimedia.org/api/rest_v1/metrics/pageviews/top/tt.wikipedia/all-access", k,  i, "all-days", sep = "/"))
    json_result_ru <- content(tat_most_visited, "text", encoding="UTF-8")
    tat_most_visited <-jsonlite::fromJSON(txt = json_result_ru, flatten = TRUE)
    str(tat_most_visited$items$articles)
    tat_most_visited <- as.data.frame(tat_most_visited$items$articles)
    tat_most_visited$period <- paste(k, i, sep = "-")
    tat_most_test <- rbind(tat_most_test, tat_most_visited)
  }
}

# here, I focus on 2023
for (i in sprintf("%02d", 1:6)) {
  tat_most_visited <- GET(paste("https://wikimedia.org/api/rest_v1/metrics/pageviews/top/tt.wikipedia/all-access/2023", i, "all-days", sep = "/"))
  json_result_ru <- content(tat_most_visited, "text", encoding="UTF-8")
  tat_most_visited <-jsonlite::fromJSON(txt = json_result_ru, flatten = TRUE)
  str(tat_most_visited$items$articles)
  tat_most_visited <- as.data.frame(tat_most_visited$items$articles)
  tat_most_visited$period <- paste("2023", i, sep = "-")
  tat_most_test <- rbind(tat_most_test, tat_most_visited)
}
save(tat_most_test,file = "data/tat_most_test_2015_2023.RData")


# TOP COUNTRIES -----------------------------------------------------------


# which countries are at the top?
tat_most_countries <- GET('https://wikimedia.org/api/rest_v1/metrics/pageviews/top-by-country/tt.wikipedia/all-access/2015/06')
json_result_ru <- content(tat_most_countries, "text", encoding="UTF-8")
tat_most_countries <-jsonlite::fromJSON(txt = json_result_ru, flatten = TRUE)
str(tat_most_countries$items$countries)
tat_most_countries <- as.data.frame(tat_most_countries$items$countries)
tat_most_countries$period <- "2015-05"
tat_most_countries_aggregate <- tat_most_countries

for (i in sprintf("%02d", 6:12)) {
  tat_most_countries <- GET(paste("https://wikimedia.org/api/rest_v1/metrics/pageviews/top-by-country/tt.wikipedia/all-access/2015", i, sep = "/"))
  json_result_ru <- content(tat_most_countries, "text", encoding="UTF-8")
  tat_most_countries <-jsonlite::fromJSON(txt = json_result_ru, flatten = TRUE)
  str(tat_most_countries$items$articles)
  tat_most_countries <- as.data.frame(tat_most_countries$items$countries)
  tat_most_countries$period <- paste("2015", i, sep = "-")
  tat_most_countries_aggregate <- rbind(tat_most_countries_aggregate, tat_most_countries)
}
table(tat_most_countries_aggregate$period)

# below is the period from 2016 to 2022
for(k in c(2016:2022)){
  for (i in sprintf("%02d", 1:12)) {
    tat_most_countries <- GET(paste("https://wikimedia.org/api/rest_v1/metrics/pageviews/top-by-country/tt.wikipedia/all-access", k, i, sep = "/"))
    json_result_ru <- content(tat_most_countries, "text", encoding="UTF-8")
    tat_most_countries <-jsonlite::fromJSON(txt = json_result_ru, flatten = TRUE)
    str(tat_most_countries$items$articles)
    tat_most_countries <- as.data.frame(tat_most_countries$items$countries)
    tat_most_countries$period <- paste(k, i, sep = "-")
    tat_most_countries_aggregate <- rbind(tat_most_countries_aggregate, tat_most_countries)
  }
}

# here, I focus on 2023
for (i in sprintf("%02d", 1:6)) {
  tat_most_countries <- GET(paste("https://wikimedia.org/api/rest_v1/metrics/pageviews/top-by-country/tt.wikipedia/all-access/2023", i, sep = "/"))
  json_result_ru <- content(tat_most_countries, "text", encoding="UTF-8")
  tat_most_countries <-jsonlite::fromJSON(txt = json_result_ru, flatten = TRUE)
  str(tat_most_countries$items$articles)
  tat_most_countries <- as.data.frame(tat_most_countries$items$countries)
  tat_most_countries$period <- paste("2023", i, sep = "-")
  tat_most_countries_aggregate <- rbind(tat_most_countries_aggregate, tat_most_countries)
}

save(tat_most_countries_aggregate, file = "data/tat_most_countries_aggregate.RData")





