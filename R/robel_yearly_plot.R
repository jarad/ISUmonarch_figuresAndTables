robel_yearly_plot <- function(s) {
  r = unique(s$region)
  
  ggplot(s, 
         aes(year, height, color = site, group = site, linetype = site)) +
    geom_line() + 
    # facet_grid(site ~ .) + 
    labs(x = "", 
         y = "Height (cm)",
         title = paste0("Yearly Average Vegetation Heights: ", r)) + 
    scale_color_manual(values = site_color) +
    scale_linetype_manual(values = site_linetype) +
    theme_bw() +
    theme(legend.position = "bottom") 
}
