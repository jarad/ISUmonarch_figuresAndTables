library("tidyverse")
library("ISUmonarch")

source("../ISUcolorPalette.R")

d <- cover %>% 
  left_join(transect, by=c("siteID","transectID")) %>%
  filter(grant == "iacig", !(siteID %in% c("uth1","uth2"))) %>%
  select(siteID, year, month, section, class, percentage) %>%
  mutate(month = recode(month, `6` = "June", `7` = "July", `8` = "August"),
         month = factor(month, levels = c("June","July","August")))


##############################################################################
d1 <- d %>%
  filter(class %in% c("bare_ground","csg","forbs","milkweed","wsg","woody_species"))

s <- d1 %>%
  group_by(year, siteID, class) %>%
  summarize(percentage = mean(percentage)) %>%
  ungroup() %>%
  mutate(class = recode(class,
                        bare_ground   = "Bare ground",
                        csg           = "Cool season grass",
                        wsg           = "Warm season grass",
                        milkweed      = "Milkweed",
                        woody_species = "Woody plants",
                        forbs         = "Forbs"),
         class = factor(class, 
                        levels = c("Forbs",
                                   "Milkweed",
                                   "Warm season grass",
                                   "Cool season grass",
                                   "Woody plants",
                                   "Bare ground")))


###################################################################
# Create Daubenmire table

ss <- s %>%
  # Create table by ordering columns by class and then year
  arrange(siteID, class, year) %>%
  mutate(column = factor(paste(class, year, sep="@"),
                         levels = unique(paste(class, year, sep="@")))) %>%
  select(siteID, column, percentage) %>%
  tidyr::spread(column, percentage, fill=NA) 

# Fix column names and create additional row
nc <- ncol(ss)
tmp <- data.frame(nms = names(ss)[-1]) %>%
  tidyr::separate(nms, into=c("row1", "row2"), sep="@")
names(ss)[-1] <- tmp$row2
new_row <- paste(" & \\multicolumn{4}{c|}{",unique(tmp$row1),"}", 
                 collapse="")
new_row <- gsub("_", " ", new_row)
new_row <- paste(new_row, "\\\\", collapse=" ")

# Write table to file
ss %>%
  xtable(
    digits = 0,
    align = paste("rr|",paste(rep("rrrr|",floor(nc/4)),collapse=""),sep="",collapse=""),
    caption="Daubenmire: average land cover \\% across all rounds Caption 1234",
    label = "t:daubenmire") %>%
  print(
    file = "daubenmire.tex",
    include.rownames = FALSE, 
    # NA.string="na",
    add.to.row = list(pos = list(-1), 
                      command = new_row),
    caption.placement = "top",
    size="\\small",
    floating.environment = "sidewaystable",
    hline.after = c(-1,0,4)
    ) 


g <- ggplot(s, aes(year, percentage)) +
  geom_line() + 
  facet_grid(class ~ siteID, scales = "free_y") + 
  labs(x = "Year", y = "Mean Cover (%)") +
  theme_bw() + 
  theme(legend.position = "bottom", 
        axis.text.x = element_text(angle=90))

ggsave(filename = "daubenmire_yearly.png",
       plot = g,
       width = 6, 
       height = 4)


g <- ggplot(s, aes(year, percentage,
                   color = class, 
                   linetype = class, 
                   group = class)) +
  geom_line() + 
  facet_grid(. ~ siteID) +
  labs(x = "Year", y = "Mean Cover (%)") +
  # scale_color_manual(values = class_col) +
  theme(legend.position = "bottom", 
        axis.text.x = element_text(angle=90))

ggsave(filename = "daubenmire_yearly2.png",
       plot = g,
       width = 6, 
       height = 4)


##############################################################################
# d1 <- d %>%
#   filter(class %in% c("bare_ground","leaf_litter"))
# 
# s <- d1 %>%
#   group_by(year, siteID, month, class) %>%
#   summarize(percentage = mean(percentage)) %>%
#   ungroup() %>%
#   mutate(class = recode(class,
#                         bare_ground           = "Bare ground",
#                         leaf_litter           = "Leaf litter"),
#          class = factor(class, 
#                         levels = c("Bare ground","Leaf litter")))
# 
# ggplot(s, aes(year, percentage, 
#               linetype = month, group = month)) +
#   geom_line() + 
#   facet_grid(class ~ siteID, scales = "free_y") + 
#   labs(x = "Year", y = "Mean Cover (%)", linetype = "Month") +
#   theme_bw() + 
#   theme(legend.position = "bottom", 
#         axis.text.x = element_text(angle=90))



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
