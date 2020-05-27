robel_monthly_plot <- function(s, r) {
  r = unique(s$region)
  
  ggplot(s, 
         aes(year, height, 
             linetype = Month, 
             group = Month,
             color = Month)) +
    geom_line() + 
    facet_wrap( ~ site) + 
    labs(x = "", y = "Height (cm)", 
         title=paste0("Monthly Average Vegetation Heights: ", r)) + 
    theme_bw() + 
    theme(legend.position = "bottom",
          axis.text.x = element_text(angle = 90)) +
    scale_color_manual(values = month_col)
}
