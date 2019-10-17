library("tidyverse")
library("ISUmonarch")

source("../ISUcolorPalette.R")

d <- nectar %>% 
  left_join(transect, by=c("siteID","transectID")) %>%
  filter(grant == "iacig", !(siteID %in% c("uth1","uth2"))) %>%
  select(siteID, year, month, `Nectar Plant Species`, count) %>%
  mutate(month = recode(month, `6` = "June", `7` = "July", `8` = "August"),
         month = factor(month, levels = c("June","July","August"))) %>%
  rename(common_name = `Nectar Plant Species`) %>%
  left_join(species, by="common_name") %>%
  rename(native = native_introduced_both) %>%
  mutate(native = recode(native, 
                         native     = "Native",
                         both       = "Introduced",
                         introduced = "Introduced"))

s1 <- d %>% 
  group_by(year, siteID, month) %>%
  summarize(total = sum(count)) %>%
  mutate(native = "Combined")

s2 <- d %>% 
  group_by(year, siteID, month, native) %>%
  summarize(total = sum(count)) 

s_both <- bind_rows(s1,s2) %>%
  mutate(native = factor(native, levels = c("Combined","Native","Introduced")))


g <- ggplot(s_both , aes(year, total, 
              linetype = month, group = month, color = month)) +
  geom_line() + 
  facet_grid(native ~ siteID, scales="free_y") + 
  labs(x = "Year", y = "Inflorescence", linetype = "Month", color = "Month") +
  # scale_y_log10() +
  scale_color_manual(values = month_col) + 
  theme(legend.position = "bottom",
        axis.text.x = element_text(angle=90))

ggsave(file = "nectar_yearly.png",
       plot = g,
       width = 6, 
       height = 4)

##############################################################
# by native/both/introduced

s <- d %>% 
  # filter(`Nectar Plant Species` != "white clover") %>%
  group_by(year, siteID, month, common_name, native) %>%
  summarize(total = sum(count))
  
ggplot(s, aes(year, total, 
              color = common_name,
              linetype = native,
              group = common_name)) +
  geom_line() + 
  facet_grid(siteID ~ month) + 
  labs(x = "Year", y = "Inflorescence", linetype = "Species") +
  scale_y_log10() + 
  theme_bw() + 
  theme(legend.position = "bottom")

ss <- s %>%
  group_by(year, siteID, common_name, native) %>%
  summarize(total = sum(total)) %>%
  spread(year, total, fill = 0) %>%
  mutate(log_ratio = log10(`2019`+1) - log10(`2018`+1) ,
         log_ratio = round(log_ratio)) %>% 
  arrange(native, log_ratio, common_name, siteID)

ss %>% write_csv("nectar_ratio.csv")
