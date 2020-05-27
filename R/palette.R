ISU_primary_palette   <- c("#C8102E", "#F1BE48", "#524727", 
                           "#9B945F", "#CAC7A7")

ISU_secondary_palette <- c("#3E4827", "#76881D", "#A2A569",
                           "#003D4C", "#006BA6", "#7A99AC",
                           "#7C2529", "#9A3324", "#BE531C",
                           "#8B5B29", "#B9975B", "#EED484",
                           "#6E6259", "#707372", "#ACA39A")

####################################################################

month_col <- c("June"   = ISU_primary_palette[3], 
               "July"   = ISU_primary_palette[2],
               "August" = ISU_primary_palette[1])

class_col <- c("Forbs"             = ISU_secondary_palette[4],
               "Milkweed"          = ISU_secondary_palette[9],
               "Warm season grass" = ISU_secondary_palette[1],
               "Cool season grass" = ISU_secondary_palette[2],
               "Woody plants"      = ISU_secondary_palette[11],
               "Bare ground"       = ISU_secondary_palette[10])

class_linetype <- c("Forbs"        = "solid",
                    "Milkweed"          = "solid",
                    "Warm season grass" = "dotdash",
                    "Cool season grass" = "dotted",
                    "Woody plants"      = "dashed",
                    "Bare ground"       = "dashed")
