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

# let's do it from here:
class(tat_most_test)
class(tat_most_test$article)
class(tat_most_test$views)
class(tat_most_test$year)
class(tat_most_test$period)
class(tat_most_test$year)
table(tat_most_test$year)

check_articles_by_year_10 <- tat_most_test %>% group_by(year, article) %>% transmute(n_views = sum(views)) %>% 
  filter(article!="Баш_бит") 

check_articles_by_year_10 <- check_articles_by_year_10 %>% 
  filter(article!="xss") 

# check_articles_by_year_10 <- check_articles_by_year_10 %>% 
#   filter(article!="Bötendönya_kileşterelgän_waqıtı") 

check_articles_by_year_10 <- check_articles_by_year_10 %>% 
  filter(article!="RSS") 

check_articles_by_year_10 <- check_articles_by_year_10 %>% 
  filter(article!="Wiki") 
check_articles_by_year_10 <- check_articles_by_year_10 %>% 
  filter(article!="K")

check_articles_by_year_10 <- check_articles_by_year_10 %>% 
  filter(article!="M")

check_articles_by_year_10 <- check_articles_by_year_10 %>% 
  filter(article!="Z")

check_articles_by_year_10 <- check_articles_by_year_10 %>% 
  filter(article!="C")

check_articles_by_year_10 <- check_articles_by_year_10 %>% 
  filter(article!=".ne")

check_articles_by_year_10 <- check_articles_by_year_10 %>% 
  filter(article!="V")

check_articles_by_year_10 <- check_articles_by_year_10 %>% 
  filter(article!="H")

check_articles_by_year_10 <- check_articles_by_year_10 %>% 
  filter(article!="J")

check_articles_by_year_10 <- check_articles_by_year_10 %>% 
  filter(article!="P")

check_articles_by_year_10 <- check_articles_by_year_10 %>% 
  filter(article!="W")

check_articles_by_year_10 <- check_articles_by_year_10 %>% 
  filter(article!="Q")

check_articles_by_year_10 <- check_articles_by_year_10 %>% 
  filter(article!="X")

check_articles_by_year_10 <- check_articles_by_year_10 %>% 
  filter(article!="U")

check_articles_by_year_10 <- check_articles_by_year_10 %>% 
  filter(article!="F")

check_articles_by_year_10 <- check_articles_by_year_10 %>% 
  filter(article!="Y")

check_articles_by_year_10 <- check_articles_by_year_10 %>% 
  filter(article!="L")

check_articles_by_year_10 <- check_articles_by_year_10 %>% 
  filter(article!=".au")

check_articles_by_year_10 <- check_articles_by_year_10 %>% 
  filter(article!="O")

check_articles_by_year_10 <- check_articles_by_year_10 %>% 
  filter(article!="A")

check_articles_by_year_10 <- check_articles_by_year_10 %>% 
  filter(article!="N")

check_articles_by_year_10 <- check_articles_by_year_10 %>% 
  filter(article!="R")

check_articles_by_year_10 <- check_articles_by_year_10 %>% 
  filter(article!="S")

check_articles_by_year_10 <- check_articles_by_year_10 %>% 
  filter(article!="B")

check_articles_by_year_10 <- check_articles_by_year_10 %>% 
  filter(article!="T")

check_articles_by_year_10 <- check_articles_by_year_10 %>% 
  filter(article!="G")

check_articles_by_year_10 <- check_articles_by_year_10 %>% 
  filter(article!="D")

check_articles_by_year_10 <- check_articles_by_year_10 %>% 
  filter(article!="I")

check_articles_by_year_10 <- check_articles_by_year_10 %>% 
  filter(article!="E")

check_articles_by_year_10 <- check_articles_by_year_10 %>% 
  filter(article!=".sb")

check_articles_by_year_10 <- check_articles_by_year_10 %>% 
  filter(article!=".cx")

check_articles_by_year_10 <- check_articles_by_year_10 %>% 
  filter(article!=".jp")

check_articles_by_year_10 <- check_articles_by_year_10 %>% 
  filter(article!=".aq")

check_articles_by_year_10 <- check_articles_by_year_10 %>% 
  filter(article!=".mx")

check_articles_by_year_10 <- check_articles_by_year_10 %>% 
  filter(article!=".dj")

check_articles_by_year_10 <- check_articles_by_year_10 %>% 
  filter(article!=".ax")

check_articles_by_year_10 <- check_articles_by_year_10 %>% 
  filter(article!=".lb")

check_articles_by_year_10 <- check_articles_by_year_10 %>% 
  filter(article!=".tr")

check_articles_by_year_10 <- check_articles_by_year_10 %>% 
  filter(article!=".bb")


check_articles_by_year_10$year <- as.factor(check_articles_by_year_10$year)
class(check_articles_by_year_10$year)

test_for_2023 <- check_articles_by_year_10 %>% filter(year=="2023") %>% slice_head(n=1)

sorted_articles <- check_articles_by_year_10 %>% group_by(year, article) %>% 
  slice_head(n = 1)%>% arrange(desc(n_views))

sorted_articles_2 <- sorted_articles %>% group_by(year) %>% arrange(desc(year)) %>% slice_head(n=10)

### Now I need to visualize this.
facet_bar <- function(df, y, x, by, nrow = 2, ncol = 2, scales = "free") {
  mapping <- aes(y = reorder_within({{ y }}, {{ x }}, {{ by }}), 
                 x = {{ x }}, 
                 fill = {{ by }})
  
  facet <- facet_wrap(vars({{ by }}), 
                      nrow = nrow, 
                      ncol = ncol,
                      scales = scales) 
  
  ggplot(df, mapping = mapping) + 
    geom_col(show.legend = FALSE) + 
    scale_y_reordered() + 
    facet + 
    ylab("")
}

sorted_articles_2 %>% 
  group_by(year) %>% 
  top_n(10) %>%
  ungroup() %>%
  facet_bar(y = article, 
            x = n_views, 
            by = year, 
            nrow = 10)+
  xlab(label = "Количество просмотров")+
  theme_minimal()
ggsave(here("Figures", "Articles.jpeg"), width = 12, height = 9, dpi = 300)




