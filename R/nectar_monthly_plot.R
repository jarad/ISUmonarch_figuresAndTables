nectar_monthly_plot <- function(nectar, region, palette) {
  ggplot(nectar %>% filter(region == region), 
         aes(year, total, 
             linetype = month, group = month, color = month)) +
    geom_line() + 
    facet_grid(site ~ native, scales="free_y") + 
    labs(x = "Year", y = "Total Inflorescence (count/100m2)", 
         title = paste0("Total Monthly Inflorescence: ", region),
         linetype = "Month", color = "Month") +
    # scale_y_log10() +
    scale_color_manual(values = palette$month_col) + 
    theme_bw() +
    theme(legend.position = "bottom",
          axis.text.x = element_text(angle=90))
}
