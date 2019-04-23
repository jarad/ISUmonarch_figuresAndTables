library("tidyverse")
library("ISUmonarch")



d <- nectar %>%
  mutate(ymd = lubridate::ymd(paste(year,month,day,sep="-"))) %>%
  group_by(ymd,siteID) %>%
  summarize(inflorescence = sum(count),
            richness = sum(count>0)) 

# Inflorescence

ggplot(d, aes(yearround, inflorescence)) + 
  geom_point() +
  facet_wrap(~siteID) +
  theme_bw() + 
  scale_y_log10() 

ggplot(d, aes(ymd, inflorescence)) + 
  geom_point() +
  facet_wrap(~siteID) +
  theme_bw() + 
  scale_y_log10() 

# Richness

ggplot(d, aes(ymd, richness)) + 
  geom_point() +
  facet_wrap(~siteID) +
  theme_bw() + 
  scale_y_log10() 
