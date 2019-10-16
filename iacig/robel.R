library("tidyverse")
library("ISUmonarch")
library("xtable")

source("../ISUcolorPalette.R")

d <- robel %>% 
  left_join(transect, by=c("siteID","transectID")) %>%
  filter(grant == "iacig", !(siteID %in% c("uth1","uth2"))) %>%
  select(siteID, year, month, height, censored) %>%
  mutate(Month = recode(month, `6` = "June", `7` = "July", `8` = "August"),
         Month = factor(Month, levels = c("June","July","August")))

stopifnot(all(d$censored == "not"))

####################################################################
# Plot by month

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
       filename = "robel_monthly.png")

####################################################################
# Plot by year

s <- d %>%
  group_by(year, siteID) %>%
  summarize(height = mean(height))

s %>% 
  spread(year, height) %>%
  xtable(
    align = "ll|rrrr",
    caption = "Mean Robel heights",
    digits = 1) %>%
  print(
    file = "robel_yearly.tex",
    include.rownames = FALSE)

g <- ggplot(s, aes(year, height)) +
  geom_line() + 
  facet_wrap(~siteID) + 
  labs(x = "Year", 
       y = "Height (cm)",
       title = "Mean Robel Heights") + 
  theme(legend.position = "bottom") 

ggsave(plot = g,
       filename = "robel_yearly.png",
       width = 6, height = 4)




  
