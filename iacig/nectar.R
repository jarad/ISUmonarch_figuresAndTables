library("tidyverse")
library("ISUmonarch")

d <- nectar %>% 
  left_join(transect, by=c("siteID","transectID")) %>%
  filter(grant == "iacig", !(siteID %in% c("uth1","uth2"))) %>%
  select(siteID, year, month, `Nectar Plant Species`, count) %>%
  mutate(month = recode(month, `6` = "June", `7` = "July", `8` = "August"),
         month = factor(month, levels = c("June","July","August")))

s <- d %>%
  group_by(year, siteID, month) %>%
  summarize(total = sum(count))

ggplot(s, aes(year, total, 
              linetype = month, group = month)) +
  geom_line() + 
  facet_wrap(. ~ siteID) + 
  labs(x = "Year", y = "Inflorescence", linetype = "Month") +
  theme_bw() + 
  theme(legend.position = "bottom")


  
