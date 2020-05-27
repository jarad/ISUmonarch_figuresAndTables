cover_yearly_table <- function(s) {
  r = unique(s$region)
  
  d = s %>% 
    select(site, year, class, percentage) %>%
    dplyr::arrange(site, year, class) %>%
    pivot_wider(names_from = class,
                values_from = percentage) %>%
    arrange(site, year) 
  
  d %>%   
    xtable(caption = paste0("Yearly average cover by class: ", r),
           digits = c(0,0,0,rep(1,6))) %>%
    print(include.rownames = FALSE,
          comment = FALSE,
          caption.placement = "top",
          hline.after = c(-1,0,unique(cumsum(table(d$site)))))
}
