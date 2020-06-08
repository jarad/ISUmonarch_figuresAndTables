get_sites = function(file) {
  read_csv(file) %>% 
    filter(!is.na(region)) 
}
