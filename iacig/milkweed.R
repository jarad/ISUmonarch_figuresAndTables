library("tidyverse")
library("ISUmonarch")

source("../ISUcolorPalette.R")

d <- milkweed %>% 
  left_join(transect, by=c("siteID","transectID")) %>%
  filter(grant == "iacig", !(siteID %in% c("uth1","uth2"))) %>%
  select(siteID, year, month, height, censored) %>%
  mutate(Month = recode(month, `6` = "June", `7` = "July", `8` = "August"),
         Month = factor(Month, levels = c("June","July","August")))

stopifnot(all(d$censored == "not"))

s <- d %>%
  group_by(year, siteID, Month) %>%
  summarize(height = mean(height))

g <- ggplot(s, aes(year, height, 
              linetype = Month, 
              group = Month,
              color = Month)) +
  geom_line() + 
  facet_wrap(~siteID) + 
  labs(x = "Year", y = "Height (cm)") + 
  theme(legend.position = "bottom") +
  scale_color_manual(values = month_col)

ggsave(plot = g,
       filename = "robel.png")


  
