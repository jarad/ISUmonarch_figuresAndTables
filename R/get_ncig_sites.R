get_ncig_sites <- function() {
  bind_rows(tibble(region = "Northwest Iowa Plains",
                   site = c("prd1","prd2","sut2","all1","all2"),
                   success = c(T,T,T,F,F),
                   color = ISU_secondary_palette[1:5]),
            tibble(region = "Des Moines Lobe",
                   site = c("dun2","dun3","pio1","pio2","nor1","ber1","ber3"),
                   success = c(T,T,T,T,T,F,F),
                   color = ISU_secondary_palette[1:7]),
            tibble(region = "Southern Iowa Drift Plains",
                   site = c("arm1","arm2","nkn1","nkn2",
                            "cre1","gro1","gro2","ver1"),
                   success = c(T,T,T,T,T,T,T,F),
                   color = ISU_secondary_palette[1:8])) %>%
    mutate(success = ifelse(success, "Yes","No"),
           success = factor(success, levels = c("Yes","No")))
}
