library(here)
library(tidyverse)
load(here("data", "Daily_Visits.RData"))
load(here("data", "Monthly_Visits.RData"))
class(tat_wiki_monthly$views)
class(tat_wiki_monthly$timestamp)
as.integer(tat_wiki_monthly$timestamp[1])
options(scipen = 999)

tat_wiki_monthly$testing <- gsub("00$", "", tat_wiki_monthly$timestamp)
tat_wiki_monthly$testing  <- gsub("(\\d{4})(\\d{2})", "\\1-\\2-", tat_wiki_monthly$testing )
tat_wiki_monthly$testing <- as.Date(tat_wiki_monthly$testing)



ggplot(tat_wiki_monthly, aes(x = testing, y = views)) +
  geom_line(color="darkgreen") +
  scale_x_date(date_breaks = "3 months",
               date_labels = "%y-%m")+
  xlab("Год-Месяц")+
  ylab("Просмотры")+
  theme_minimal()
ggsave(here("Figures", "Figure Month.jpeg"), width = 14, height = 10, dpi = 300)


# Which countries are the most active? ------------------------------------

  
load(here("data", "tat_most_countries_aggregate.RData"))
class(tat_most_countries_aggregate$views_ceil)
class(tat_most_countries_aggregate)
tat_most_countries_aggregate$year <- str_extract_all(pattern = "(\\d{4})", string =  tat_most_countries_aggregate$period)
check_countries <- tat_most_countries_aggregate %>% group_by(country, year) %>% transmute(n_views= views_ceil)


### Which articles are the most popular by year?
load(here("data", "tat_most_test_2015_2023.RData")) # here, I have to focus on titles without "word:"




