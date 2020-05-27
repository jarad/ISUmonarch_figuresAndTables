max_length = function(sections) {
  max(as.integer(unlist(regmatches(sections, gregexpr("[[:digit:]]+", sections)))))
}
