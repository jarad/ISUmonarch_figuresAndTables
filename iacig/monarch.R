library("tidyverse")
library("ISUmonarch")
library("xtable")

source("../ISUcolorPalette.R")

d <- monarch %>% 
  left_join(transect, by=c("siteID","transectID")) %>%
  filter(grant == "iacig", 
         !(siteID %in% c("uth1","uth2")),
         type != "palmer amaranth") %>%
  mutate(month = recode(month, `6` = "June", `7` = "July", `8` = "August"),
         month = factor(month, levels = c("June","July","August"))) %>% 
  
  group_by(year, siteID, type, milkweed) %>%
  summarize(total = sum(count)) %>%
  ungroup() %>%
  
  # Create total columns
  mutate(type = recode(type, extra = "total", instar = "larvae")) %>%
  unite("type_milkweed", type, milkweed) %>%
  spread(type_milkweed, total, fill = 0) %>%
  mutate(total_NA = survey_NA + total_NA,
         eggs_NA   = eggs_NA   + eggs_common   + eggs_butterfly   + eggs_swamp,
         ramets_NA = ramets_NA + ramets_common + ramets_butterfly + ramets_swamp,
         larvae_NA = larvae_NA + larvae_common + larvae_butterfly + larvae_swamp) %>%
  gather("type_milkweed", "count", -year, -siteID) %>%
  separate(type_milkweed, c("type","milkweed"), sep="_") %>%
  
  mutate(
    milkweed = ifelse(type == "survey", "survey", milkweed),
    milkweed = ifelse(type == "total", "", milkweed),
    # milkweed = tools::toTitleCase(milkweed),
    milkweed = factor(milkweed, 
                      levels = c("butterfly","common","swamp","survey","total")),
    
    type = recode(type, survey = "adults", total = "adults"),
    type = tools::toTitleCase(type)) %>%
  unite("Monarch", type, milkweed, sep=", ") %>%
  mutate(
    Monarch = gsub(", NA", "", Monarch),
    Monarch = factor(Monarch, 
                     levels = c("Adults, survey", "Adults",
                                "Eggs, butterfly", "Eggs, common", "Eggs, swamp", "Eggs",
                                "Larvae, butterfly", "Larvae, common", "Larvae, swamp", "Larvae",
                                "Ramets, butterfly", "Ramets, common", "Ramets, swamp", "Ramets"))) 

d %>%
  spread(siteID, count) %>%
  arrange(Monarch, year) %>% 
  xtable(
    digits = 0,
    align = "lll|rrrr",
caption = "Monarch adults (total and during survey), milkweed ramets, monarch eggs on milkweed, and monarch larvae on milkweed. Note ramets, eggs,
and larvae were collected differently for 2016.") %>%
  print(
    file = "monarch.tex",
    include.rownames = FALSE)


g <- ggplot(d %>% filter(Monarch == "Adults, survey"), aes(year, count)) +
  geom_line() + 
  facet_grid(. ~ siteID, scales="free_y") + 
  labs(x = "Year", y = "Number of adult monarchs surveyed") +
  # scale_y_log10() + 
  theme(legend.position = "bottom",
        axis.text.x = element_text(angle=90))

ggsave(file = "monarch_yearly.png",
       plot = g,
       width = 6, 
       height = 4)
