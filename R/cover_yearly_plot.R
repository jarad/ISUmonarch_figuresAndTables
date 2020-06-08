cover_yearly_plot <- function(cover, region, palette) {
  
  ggplot(cover %>% filter(region == region), 
         aes(year, percentage, color = class, linetype = class, group = class)) +
    geom_line(size=1.1) + 
    facet_wrap( ~ site, scales = "free_y") +
    labs(x = "Year", y = "Average Cover", 
         title = paste0("Yearly Average Cover by Class: ", region)) +
    scale_color_manual(values = palette$class_col) +
    scale_linetype_manual(values = palette$class_linetype) +
    theme_bw() + 
    theme(legend.position = "bottom", 
          axis.text.x = element_text(angle=90),
          legend.key.width = unit(3, "line"))
}