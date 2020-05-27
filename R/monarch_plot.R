monarch_plot <- function(monarch) {
  r = unique(monarch$region)
  
  ggplot(monarch %>%
           mutate(Monarch = sub(", total","",Monarch)) %>%
           filter(Monarch %in% c("Adults","Eggs","Larvae","Ramets")), 
         aes(year, count, group = Monarch)) +
    # geom_point() + 
    geom_line() + 
    facet_grid(Monarch ~ site, scales="free_y") + 
    labs(x = "Year", y = "Count",
         title = paste0("Yearly Monarch Stages and Milkweed Ramets: ", r)) +
    # scale_y_log10() + 
    theme_bw() +
    theme(legend.position = "bottom",
          axis.text.x = element_text(angle=90))
}
