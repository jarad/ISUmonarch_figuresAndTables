cover_yearly_cumulative_plot <- function(s) {
  r = unique(s$region)
  
  ggplot(s %>%
           filter(region == r) %>%
           dplyr::mutate(class = factor(class, 
                                        levels = c("Milkweed","Forbs",
                                                   "Warm season grass",
                                                   "Cool season grass",
                                                   "Woody plants",
                                                   "Bare ground"))), 
         aes(year, percentage,
             fill = class, 
             # linetype = class, 
             group = class)) +
    geom_area(color=NA) + 
    facet_wrap(~ site) +
    labs(x = "Year", y = "Average Cover", 
         title = paste0("Cumulative Yearly Average Cover by Class: ", r)) +
    scale_fill_manual(values = class_col) +
    theme_bw() +
    theme(legend.position = "bottom", 
          axis.text.x = element_text(angle=90))
}
