get_robel = function() {
  HabitatRestoration::robel %>% 
    dplyr::left_join(HabitatRestoration::transect, by = "transectID") %>%
    dplyr::rename(site = siteID) %>%
    dplyr::mutate(site = as.character(site)) %>%
    filter(site %in% sites$site) %>%
    select(site, date, censored, height) %>%
    mutate(
      year = format(date, "%Y"),
      Month = factor(format(date, "%B"), levels = c("June","July","August")))
}
