summarize_nectar_monthly = function(nectar) {
  combined <- nectar %>% 
    group_by(year, month, site, transect_length) %>%
    summarize(total = sum(count)) %>%
    ungroup() %>%
    
    mutate(native = "Combined",
           total = total / transect_length * 100)
  
  
  separate <- nectar %>% 
    mutate(native = recode(native, 
                           `Native (planted)` = "Native",
                           `Native (extant)`  = "Native",
                           `Introduced/weed`  = "Introduced")) %>%
    
    group_by(year, site, month, native, transect_length) %>%
    summarize(total = sum(count)) %>%
    ungroup() %>%
    
    mutate(total = total / transect_length * 100) 

  
  s_both <- bind_rows(combined, separate) %>%
    mutate(native = factor(native, levels = c("Combined",
                                              "Native",
                                              "Introduced"))) 
}