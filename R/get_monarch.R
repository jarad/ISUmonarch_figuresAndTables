get_monarch = function() {
  HabitatRestoration::monarch %>% 
    dplyr::left_join(HabitatRestoration::transect %>% 
                       select(siteID,transectID), 
                     by = "transectID") %>%
    filter(type != "palmer amaranth") %>%
    rename(site = siteID) %>%
    mutate(
      year = format(date, "%Y"),
      month = factor(format(date, "%B"), levels = c("June","July","August"))) %>%
    
    group_by(year, site, type, milkweed) %>%
    summarize(total = sum(count)) %>%
    ungroup() %>%
    
    # Create total columns
    mutate(type = recode(type, extra = "total", instar = "larvae")) %>%
    unite("type_milkweed", type, milkweed) %>%
    spread(type_milkweed, total, fill = 0) %>%
    mutate(total_NA = survey_NA + total_NA,
           eggs_NA   = eggs_NA   + eggs_common   + eggs_butterfly   + eggs_swamp,
           ramets_NA = ramets_NA + ramets_common + ramets_butterfly + ramets_swamp,
           larvae_NA = larvae_NA + larvae_common + larvae_butterfly + larvae_swamp) %>%
    tidyr::gather("type_milkweed", "count", -year, -site) %>%
    separate(type_milkweed, c("type","milkweed"), sep="_") %>%
    
    mutate(
      milkweed = ifelse(type == "survey", "survey", milkweed),
      milkweed = ifelse(type == "total", "", milkweed),
      # milkweed = tools::toTitleCase(milkweed),
      milkweed = factor(milkweed, 
                        levels = c("butterfly","common","swamp","survey","total")),
      
      type = recode(type, survey = "adults", total = "adults"),
      type = tools::toTitleCase(type)) %>%
    unite("Monarch", type, milkweed, sep=", ") %>%
    mutate(
      Monarch = gsub(", NA", ", total", Monarch),
      Monarch = factor(Monarch, 
                       levels = c("Adults, survey", "Adults, total",
                                  "Eggs, butterfly", "Eggs, common", "Eggs, swamp", "Eggs, total",
                                  "Larvae, butterfly", "Larvae, common", "Larvae, swamp", "Larvae, total",
                                  "Ramets, butterfly", "Ramets, common", "Ramets, swamp", "Ramets, total"))) %>%
    ungroup() 
}