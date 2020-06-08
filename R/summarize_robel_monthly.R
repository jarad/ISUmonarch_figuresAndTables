summarize_robel_monthly = function(robel) {
  robel %>%
    group_by_at(vars(-censored, -height)) %>%
    summarize(height = mean(height)) %>%
    ungroup()
}
