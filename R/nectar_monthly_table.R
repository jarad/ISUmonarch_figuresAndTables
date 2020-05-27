nectar_monthly_table <- function(nectar) {
  r = unique(nectar$region)
  
  d = nectar %>% 
    select(site, year, month, total, native) %>%
    unite("year_month", year, month, sep="_") %>%
    pivot_wider(names_from = year_month,
                values_from = total) %>%
    arrange(site, native) 
  
  nc = new_colnames(colnames(d))
  colnames(d) = nc$new_colnames
  
  d %>%
    xtable(digits = 0,
           caption = paste0("Total Monthly Inflorescence: ", r),
           align = "lll|rrr|rrr|rrr|rrr|") %>%
    print(include.rownames = FALSE,
          comment = FALSE,
          caption.placement = "top",
          # rotate.colnames = TRUE,
          sanitize.colnames.function = function(x) {
            rotated <- paste("\\begin{sideways}", x[-c(1:2)], "\\end{sideways}") 
            return(c(x[1:2], rotated))
          }, 
          add.to.row = list(pos = list(-1),
                            command = nc$new_header),
          hline.after = c(-1,0,unique(cumsum(table(d$site)))))
}
