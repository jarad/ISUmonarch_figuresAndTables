summarize_robel_monthly = function(robel) {
  robel %>%
    group_by(year, Month, site) %>%
    summarize(height = mean(height)) %>%
    ungroup()
}
