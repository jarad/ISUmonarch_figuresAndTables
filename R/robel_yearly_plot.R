robel_yearly_plot <- function(robel, region, color, linetype) {
  ggplot(robel %>% filter(region == region), 
         aes(year, height, color = site, group = site, linetype = site)) +
    geom_line() + 
    # facet_grid(site ~ .) + 
    labs(x = "", 
         y = "Height (cm)",
         title = paste0("Yearly Average Vegetation Heights: ", region)) + 
    scale_color_manual(values = color) +
    scale_linetype_manual(values = linetype) +
    theme_bw() +
    theme(legend.position = "bottom") 
}
