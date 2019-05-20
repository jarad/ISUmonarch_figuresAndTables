library("tidyverse")
library("ISUmonarch")



d <- nectar %>%
  mutate(ymd = lubridate::ymd(paste(year,month,day,sep="-"))) %>%
  group_by(year, transectID) %>%
  summarize(inflorescence = sum(count),
            richness = sum(count>0)) %>%
  left_join(ISUmonarch::transect, by="transectID") %>%
  filter(!(transectID %in% c("tuth1", "tuth2", "tsie1")))




# Inflorescence

ggplot(d, aes(ymd, inflorescence)) + 
  geom_point() +
  facet_wrap(~siteID) +
  theme_bw() + 
  scale_y_log10() 

ggplot(d, aes(year, inflorescence)) + 
  geom_point(aes(color=transectID)) +
  geom_line(aes(color=transectID)) +
  facet_wrap(~grant) +
  theme_bw() + 
  scale_y_log10() 

# Richness

ggplot(d, aes(ymd, richness)) + 
  geom_point() +
  facet_wrap(~siteID) +
  theme_bw() + 
  scale_y_log10() 
