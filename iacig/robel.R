library("tidyverse")
library("ISUmonarch")

d <- robel %>% 
  left_join(transect, by=c("siteID","transectID")) %>%
  filter(grant == "iacig") %>%
  select(siteID, year, month, height, censored) %>%
  mutate(month = recode(month, `6` = "June", `7` = "July", `8` = "August"),
         month = factor(month, levels = c("June","July","August")))

stopifnot(all(d$censored == "not"))

s <- d %>%
  group_by(year, siteID, month) %>%
  summarize(height = mean(height))

ggplot(s, aes(year, height, 
              linetype = month, group = month)) +
  geom_line() + 
  facet_wrap(~siteID) + 
  labs(x = "Year", y = "Height (cm)", linetype = "Month") +
  theme_bw() + 
  theme(legend.position = "bottom")


  
