ncig_sites <- bind_rows(tibble(region = "Northwest Iowa Plains",
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


ncig_site_color <- c(ISU_secondary_palette, ISU_secondary_palette[1:6])
names(ncig_site_color) <- c("all1", "all2", "arm1", "arm2", "ber1", "ber3", "cre1",
                       "dun2", "dun3", "gro1", "gro2", "nkn1", "nkn2", "nor1",
                       "pio1", "pio2", "prd1", "prd2", "sie1", "sut2", "ver1")


ncig_site_linetype <- 2 - (sites$success == "Yes")
names(ncig_site_linetype) <- sites$site


ncig_regions = c("Northwest Iowa Plains","Des Moines Lobe","Southern Iowa Drift Plains")


