new_colnames <- function(cn) {
  
  tmp <- gsub("_.*","",cn)
  n_col <- length(tmp)
  
  new_header = ""
  i = 1
  first = TRUE
  while (i <= n_col) {
    string = tmp[i]
    count = 0
    
    while (tmp[i] == string & i <= n_col) {
      # print(paste(i, count, string, tmp[i], "\n"))
      count = count + 1
      i = i+1
    }
    
    if (count == 1) {
      if (first) {
        first = FALSE
      } else {
        new_header = paste0(new_header, " & ")
      }
    }
    else
      new_header = paste0(new_header, 
                          " & \\multicolumn{",count,"}{c|}{", string, "}")
  }
  new_header = paste0(new_header, " \\\\")
  
  
  list(new_colnames = gsub(".*_","",cn),
       new_header   = new_header)
}
