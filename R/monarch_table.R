monarch_table <- function(monarch) {
  r = unique(monarch$region)
  
  d = monarch %>% 
    dplyr::select(site, year, Monarch, count) %>%
    dplyr::arrange(site, year, Monarch) %>%
    dplyr::mutate(Monarch = gsub(", ","_",Monarch)) %>%
    tidyr::pivot_wider(names_from = Monarch,
                       values_from = count) 
  
  nc = new_colnames(colnames(d))
  colnames(d) = nc$new_colnames
  
  d %>%  
    xtable(digits = 0, 
           align = "cll|rr|rrrr|rrrr|rrrr|",
           caption = paste0("Yearly monarch stages and milkweed ramets: ", r)) %>%
    
    print(comment = FALSE,
          include.rownames=FALSE,
          caption.placement = "top",
          # rotate.colnames = TRUE,
          sanitize.colnames.function = function(x) {
            rotated <- paste("\\begin{sideways}", x[-c(1:2)], "\\end{sideways}") 
            return(c(x[1:2], rotated))
          }, 
          # floating.environment = "sidewaystable",
          add.to.row = list(pos = list(-1),
                            command = nc$new_header),
          hline.after = c(-1,0,unique(cumsum(table(d$site)))))
}
