library("tidyverse")
library("ISUmonarch")

d <- cover %>% 
  left_join(transect, by=c("siteID","transectID")) %>%
  filter(grant == "iacig", !(siteID %in% c("uth1","uth2"))) %>%
  select(siteID, year, month, section, class, percentage) %>%
  mutate(month = recode(month, `6` = "June", `7` = "July", `8` = "August"),
         month = factor(month, levels = c("June","July","August")))


##############################################################################
d1 <- d %>%
  filter(class %in% c("csg","forbs","milkweed","wsg","woody_species"))

s <- d1 %>%
  group_by(year, siteID, month, class) %>%
  summarize(percentage = mean(percentage)) %>%
  ungroup() %>%
  mutate(class = recode(class,
                        csg           = "Cool season grass",
                        wsg           = "Warm season grass",
                        milkweed      = "Milkweed",
                        woody_species = "Woody species",
                        forbs         = "Forbs"),
         class = factor(class, 
                        levels = c("Forbs","Cool season grass","Warm season grass","Milkweed","Woody species")))

ggplot(s, aes(year, percentage, 
              linetype = month, group = month)) +
  geom_line() + 
  facet_grid(class ~ siteID, scales = "free_y") + 
  labs(x = "Year", y = "Mean Cover (%)", linetype = "Month") +
  theme_bw() + 
  theme(legend.position = "bottom", 
        axis.text.x = element_text(angle=90))


##############################################################################
d1 <- d %>%
  filter(class %in% c("bare_ground","leaf_litter"))

s <- d1 %>%
  group_by(year, siteID, month, class) %>%
  summarize(percentage = mean(percentage)) %>%
  ungroup() %>%
  mutate(class = recode(class,
                        bare_ground           = "Bare ground",
                        leaf_litter           = "Leaf litter"),
         class = factor(class, 
                        levels = c("Bare ground","Leaf litter")))

ggplot(s, aes(year, percentage, 
              linetype = month, group = month)) +
  geom_line() + 
  facet_grid(class ~ siteID, scales = "free_y") + 
  labs(x = "Year", y = "Mean Cover (%)", linetype = "Month") +
  theme_bw() + 
  theme(legend.position = "bottom", 
        axis.text.x = element_text(angle=90))



###########################################################################
d <- litter %>% 
  left_join(transect, by=c("siteID","transectID")) %>%
  filter(grant == "iacig") %>%
  select(siteID, year, month, section, depth) %>%
  mutate(month = recode(month, `6` = "June", `7` = "July", `8` = "August"),
         month = factor(month, levels = c("June","July","August")))

s <- d %>%
  group_by(year, siteID, month) %>%
  summarize(depth = mean(depth))

ggplot(s, aes(year, depth, 
              linetype = month, group = month)) +
  geom_line() + 
  facet_grid(. ~ siteID, scales = "free_y") + 
  labs(x = "Year", y = "Mean Depth (cm)", linetype = "Month") +
  theme_bw() + 
  theme(legend.position = "bottom", 
        axis.text.x = element_text(angle=90))
