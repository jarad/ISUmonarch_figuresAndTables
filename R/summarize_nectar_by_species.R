summarize_nectar_by_species = function(nectar) {
  s <- nectar %>% 
    # filter(`Nectar Plant Species` != "white clover") %>%
    group_by(year, site, month, common_name, native) %>%
    summarize(total = sum(count)) %>%
    ungroup() 
  
  abundance <- s %>%
    group_by(common_name) %>%
    summarize(total = sum(total)) %>%
    arrange(total)
  
  s %>%
    mutate(common_name = factor(common_name,
                                levels = abundance$common_name),
           native = factor(native, 
                           levels=c("Native (planted)",
                                    "Native (extant)",
                                    "Introduced/weed")))
}