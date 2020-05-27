get_cover = function() {
  HabitatRestoration::cover %>% 
    dplyr::left_join(HabitatRestoration::transect, by = "transectID") %>%
    dplyr::rename(site = siteID) %>%
    filter(site %in% sites$site) %>%
    select(site, date, class, percentage) %>%
    mutate(
      year = format(date, "%Y"),
      month = factor(format(date, "%B"), levels = c("June","July","August"))) %>%
    filter(class %in% c("bare_ground","csg","forbs","milkweed","wsg","woody_species"))
}
