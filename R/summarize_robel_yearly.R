summarize_robel_yearly = function(robel) {
  robel %>%
    group_by(year, site) %>%
    summarize(height = mean(height)) %>%
    ungroup()
}
