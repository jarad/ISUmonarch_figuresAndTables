cover_yearly_plot <- function(s) {
  r = unique(s$region)
  
  ggplot(s, 
         aes(year, percentage, color=class, linetype = class, group = class)) +
    geom_line(size=1.1) + 
    facet_wrap( ~ site, scales = "free_y") +
    labs(x = "Year", y = "Average Cover", 
         title = paste0("Yearly Average Cover by Class: ", r)) +
    scale_color_manual(values = class_col) +
    scale_linetype_manual(values = class_linetype) +
    theme_bw() + 
    theme(legend.position = "bottom", 
          axis.text.x = element_text(angle=90),
          legend.key.width = unit(3, "line"))
}