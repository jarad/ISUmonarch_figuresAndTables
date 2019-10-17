library("tidyverse")
library("ISUmonarch")
library("xtable")

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
  
# ggplot(s, aes(year, total, 
#               color = common_name,
#               linetype = native,
#               group = common_name)) +
#   geom_line() + 
#   facet_grid(siteID ~ month) + 
#   labs(x = "Year", y = "Inflorescence", linetype = "Species") +
#   scale_y_log10() + 
#   theme_bw() + 
#   theme(legend.position = "bottom")

ss <- s %>%
  group_by(year, siteID, common_name, native) %>%
  summarize(total = sum(total)) %>%
  spread(year, total, fill = 0) %>%
  mutate(log_ratio = log10(`2019`+1) - log10(`2018`+1) ,
         log_ratio = round(log_ratio)) %>% 
  arrange(native, log_ratio, common_name, siteID)

ss %>% write_csv("nectar_ratio.csv")


###################################################################
# Create 

ss <- s %>%
  group_by(year, siteID, common_name, native) %>%
  summarize(density = mean(total)) %>%
  ungroup() %>%
  mutate(native = factor(native, levels=c("Native","Introduced"))) %>%
  
  # cra1 has a 70m transect, so adjust to 100m density
  mutate(density = ifelse(siteID == "cra1", density/.7, density)) %>%
  unite("site_year", siteID, year, sep="@") %>%
  spread(site_year, density, fill = NA) %>%
  arrange(native, common_name) %>%
  rename(`Common name` = "common_name")

n_native = sum(ss$native == "Native")
ss$native <- NULL

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
    align = paste("rl|",paste(rep("rrrr|",floor(nc/4)),collapse=""),sep="",collapse=""),
    caption="Nectar: density (per 100m2) across all rounds. Species above the line are native and below the line are introduced.",
    label = "t:nectar") %>%
  print(
    file = "nectar.tex",
    include.rownames = FALSE, 
    # NA.string="na",
    add.to.row = list(pos = list(-1), 
                      command = new_row),
    caption.placement = "top",
    size="\\small",
    # floating.environment = "sidewaystable",
    hline.after = c(-1,0,n_native,nrow(ss))
  ) 
