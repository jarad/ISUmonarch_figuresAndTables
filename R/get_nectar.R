get_nectar = function() {
  transect_length <- HabitatRestoration::nectar_surveys %>%
    
    dplyr::group_by(date, transectID) %>%
    dplyr::summarize(transect_length = max_length(section)) %>%
    dplyr::ungroup()
  
  
  d <- HabitatRestoration::nectar %>% 
    
    dplyr::left_join(HabitatRestoration::transect %>% 
                       select(siteID, transectID),
                     by = "transectID") %>%
    
    dplyr::left_join(transect_length, by = c("date","transectID")) %>%
    
    dplyr::rename(
      site = siteID,
      common_name = `Nectar Plant Species`) %>%
    
    dplyr::left_join(HabitatRestoration::species %>% 
                       select(common_name, planted_non_planted, native_introduced_both), 
                     by="common_name") %>%
    # # removes white campion and yellow clover
    # dplyr::filter(!is.na(planted_non_planted)) %>%
    
    rename(native = native_introduced_both) %>%
    mutate(native = recode(native, 
                           native     = "Native (extant)",
                           both       = "Introduced/weed",
                           introduced = "Introduced/weed"),
           native = ifelse(planted_non_planted == "planted",
                           "Native (planted)", native),
           
           native = ifelse(common_name == "marestail",
                           "Introduced/weed", native))  %>%
    mutate(
      year  = format(date, "%Y"),
      month = factor(format(date, "%B"), levels = c("June","July","August"))) %>%
    
    select(year, month, site, transect_length, common_name, native, count) 
}
