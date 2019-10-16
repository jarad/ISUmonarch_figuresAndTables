library("tidyverse")
library("ISUmonarch")

d <- nectar %>% 
  left_join(transect, by=c("siteID","transectID")) %>%
  filter(grant == "iacig", !(siteID %in% c("uth1","uth2"))) %>%
  select(siteID, year, month, `Nectar Plant Species`, count) %>%
  mutate(month = recode(month, `6` = "June", `7` = "July", `8` = "August"),
         month = factor(month, levels = c("June","July","August"))) %>%
  rename(common_name = `Nectar Plant Species`) %>%
  left_join(species %>% 
              mutate(native_introduced_both = factor(native_introduced_both,
                                                     levels=c("native","both","introduced"))), 
            by="common_name") %>%
  mutate(native = ifelse(native_introduced_both == "native", "Yes", "No"))

s <- d %>% 
  # filter(`Nectar Plant Species` != "white clover") %>%
  group_by(year, siteID, month, native_introduced_both) %>%
  summarize(total = sum(count))

ggplot(s , aes(year, total, 
              linetype = month, group = month)) +
  geom_line() + 
  facet_grid(native_introduced_both ~ siteID) + 
  labs(x = "Year", y = "Inflorescence", linetype = "Month") +
  scale_y_log10() +
  theme_bw() + 
  theme(legend.position = "bottom")


##############################################################
# by native/both/introduced

s <- d %>% 
  group_by(year, siteID, month, `Nectar Plant Species`) %>%
  summarize(total = sum(count)) %>%
  rename(common_name = `Nectar Plant Species`) %>%
  left_join(species, by="common_name") %>%
  mutate(native_introduced_both = factor(native_introduced_both, 
                                         levels = c("native","both","introduced"))) %>%
  select(year, siteID, common_name, native_introduced_both, total)
  
ggplot(s, aes(year, total, 
              color = common_name, 
              linetype = native_introduced_both,
              group = common_name)) +
  geom_line() + 
  facet_grid(siteID ~ month) + 
  labs(x = "Year", y = "Inflorescence", linetype = "Species") +
  scale_y_log10() + 
  theme_bw() + 
  theme(legend.position = "bottom")

ss <- s %>%
  group_by(year, siteID, common_name, native_introduced_both) %>%
  summarize(total = sum(total)) %>%
  spread(year, total, fill = 0) %>%
  mutate(ratio = (`2019`+1) / (`2018`+1) ,
         ratio = round(ratio, 2)) %>% 
  arrange(native_introduced_both, common_name, siteID, ratio)

ss %>% write_csv("ratio.csv")
