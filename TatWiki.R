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
tat_most_visited <- GET('https://wikimedia.org/api/rest_v1/metrics/pageviews/top/tt.wikipedia/all-access/2022/01/all-days')
json_result_ru <- content(tat_most_visited, "text", encoding="UTF-8")
tat_most_visited <-jsonlite::fromJSON(txt = json_result_ru, flatten = TRUE)
str(tat_most_visited$items$articles)
tat_most_test <- as.data.frame(tat_most_visited$items$articles)
# save(tat_most_visited, file = "data/Most_Visited.RData")

# which countries are at the top?
tat_most_countries <- GET('https://wikimedia.org/api/rest_v1/metrics/pageviews/top-by-country/tt.wikipedia/all-access/2022/01')
json_result_ru <- content(tat_most_countries, "text", encoding="UTF-8")
tat_most_countries <-jsonlite::fromJSON(txt = json_result_ru, flatten = TRUE)
str(tat_most_countries$items$countries)
tat_most_countries <- as.data.frame(tat_most_countries$items$countries)

