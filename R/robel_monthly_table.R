robel_monthly_table <- function(s) {
  r  <- unique(s$region)
  
  d = s %>%
    select(site, year, Month, height) %>%
    tidyr::pivot_wider(names_from = Month,
                       values_from = height) %>%
    select(site, year, June, July, August) %>%
    arrange(site, year) 
  
  # n <- table(d$site)
  
  d %>%
    
    xtable(digits = 0,
           caption = paste0("Monthly average vegetation height (cm): ", r)) %>%
    print(include.rownames = FALSE,
          comment = FALSE,
          caption.placement = "top",
          hline.after = c(-1,0,unique(cumsum(table(d$site)))))
}
