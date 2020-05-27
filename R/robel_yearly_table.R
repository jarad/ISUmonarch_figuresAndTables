robel_yearly_table <- function(s) {
  r  <- unique(s$region)
  
  d = s %>%
    select(site, year, height) %>%
    tidyr::pivot_wider(names_from = year,
                       values_from = height) %>%
    # select(site, year, June, July, August) %>%
    arrange(site) 
  
  d %>%
    xtable(digits = 0,
           caption = paste0("Yearly average vegetation height (cm): ", r)) %>%
    print(include.rownames = FALSE,
          comment = FALSE,
          caption.placement = "top")
}
