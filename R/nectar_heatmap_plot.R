nectar_heatmap_plot = function(nectar_by_species) {
  r = unique(nectar_by_species$region)
  
  ggplot(nectar_by_species %>%
           filter(total > 0.1), 
         aes(year, common_name, fill = total)) +
    geom_tile() + 
    # scale_y_discrete(limits = rev(levels(as.factor(s$common_name)))) +
    facet_grid(native ~ site, scales="free_y", space="free_y") + 
    scale_fill_gradient(low = "cornsilk", high = "darkgreen", trans = "log") +
    theme_bw() +
    theme(legend.position = "none",
          axis.text.x = element_text(angle=90),
          axis.text.y = element_text(hjust=0)) +
    labs(x = "", y = "", title = paste0(r," (< 0.1 observations removed)")) 
}
