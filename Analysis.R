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
tat_most_countries_aggregate$year <- unlist(tat_most_countries_aggregate$year)
class(tat_most_countries_aggregate$country)
class(tat_most_countries_aggregate$year)

check_countries <- tat_most_countries_aggregate %>% group_by(country, year) %>% transmute(n_views=sum(views_ceil)) %>% 
  slice_head(n=1) %>% filter(country !="--")
n_distinct(check_countries$country)
save(check_countries, file = "Figures/check_countries.RData")
load(here("Figures", "check_countries.RData"))

check_countries$year <- as.integer(check_countries$year)
table(check_countries$year)
sorted_countries <- check_countries %>% group_by(year) %>% arrange(desc(n_views)) %>% slice_head(n=10)
save(sorted_countries, file = "Figures/sorted_countries_10.RData")

# https://ru.wikipedia.org/wiki/ISO_3166-1 for country codes

### Which articles are the most popular by year?
load(here("data", "tat_most_test_2015_2023.RData")) # here, I have to focus on titles without "word:"
# write_csv(tat_most_test, file = "attempt.csv")
pattern <- ":"
tat_most_test$to_remove <- grepl(pattern, tat_most_test$article)
tat_most_test <- tat_most_test %>% filter(to_remove==FALSE)

tat_most_test$year <- str_extract_all(pattern = "(\\d{4})", string = tat_most_test$period)
tat_most_test$year <- unlist(tat_most_test$year)

check_articles_by_year_10 <- tat_most_test %>% group_by(article, year) %>% transmute(n_views = sum(views)) %>% 
  filter(article!="Баш_бит") 

check_articles_by_year_10 <- check_articles_by_year_10 %>% 
  filter(article!="xss") 

check_articles_by_year_10 <- check_articles_by_year_10 %>% 
  filter(article!="Bötendönya_kileşterelgän_waqıtı") 

sorted_articles <- check_articles_by_year_10 %>% group_by(article, year) %>% arrange(desc(n_views)) %>% slice_head(n=10)

sorted_articles <- check_articles_by_year_10 %>% group_by(article, year) %>% arrange(desc(n_views)) %>% slice_head(n=10)


