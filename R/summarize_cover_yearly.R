summarize_cover_yearly = function(cover) {
  cover %>%
    group_by(year, site, class) %>%
    summarize(percentage = mean(percentage)) %>%
    ungroup() %>%
    
    mutate(class = recode(class,
                          bare_ground   = "Bare ground",
                          csg           = "Cool season grass",
                          wsg           = "Warm season grass",
                          milkweed      = "Milkweed",
                          woody_species = "Woody plants",
                          forbs         = "Forbs"),
           class = factor(class, 
                          levels = c("Bare ground",
                                     "Cool season grass",
                                     "Warm season grass",
                                     "Forbs",
                                     "Milkweed",
                                     "Woody plants")
           )
    )
}