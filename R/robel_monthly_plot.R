robel_monthly_plot <- function(robel, palette) {
  region == unique(robel[[1]]$region)
  
  ggplot(robel[[1]], 
         aes(year, height, 
             linetype = Month, 
             group = Month,
             color = Month)) +
    geom_line() + 
    facet_wrap( ~ site) + 
    labs(x = "", y = "Height (cm)", 
         title=paste0("Monthly Average Vegetation Heights: ", region)) + 
    theme_bw() + 
    theme(legend.position = "bottom",
          axis.text.x = element_text(angle = 90)) +
    scale_color_manual(values = palette$month_col)
}
