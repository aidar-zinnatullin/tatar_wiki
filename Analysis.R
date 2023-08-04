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
encodeString(tat_most_test$article[997])
table(Encoding(tat_most_test$article))

library(stringi)
stri_enc_mark(tat_most_test$article)
all(stri_enc_isutf8(tat_most_test$article))


another_one <- read.csv2(file("attempt.csv", encoding="Latin-1"))
tat_most_test$article <- stri_encode(tat_most_test$article, "", "windows-1251") # re-mark encodings
stri_trans_general(tat_most_test$article, "Latin-1")
df <- read.table("attempt.csv", sep = ",", fileEncoding = "UTF-8", header = TRUE)



