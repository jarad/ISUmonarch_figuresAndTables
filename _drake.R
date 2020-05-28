library("drake")
library("tidyverse")
library("xtable")
options(xtable.include.rownames = FALSE,
        xtable.comment = FALSE,
        xtable.caption.placement = "top")
library("HabitatRestoration")

# library("kableExtra")
# options(knitr.table.format = "latex")

source("R/max_length.R")
source("R/palette.R")
source("R/new_colnames.R")

source("R/get_robel.R")
source("R/get_cover.R")
source("R/get_nectar.R")
source("R/get_monarch.R")

source("R/get_ncig_sites.R")

source("R/summarize_robel_monthly.R")
source("R/summarize_robel_yearly.R")
source("R/summarize_cover_yearly.R")
source("R/summarize_nectar_monthly.R")
source("R/summarize_nectar_by_species.R")

source("R/robel_monthly_plot.R")
source("R/robel_monthly_table.R")
source("R/robel_yearly_plot.R")
source("R/robel_yearly_table.R")

source("R/cover_yearly_table.R")
source("R/cover_yearly_plot.R")
source("R/cover_yearly_cumulative_plot.R")

source("R/nectar_monthly_table.R")
source("R/nectar_monthly_plot.R")
source("R/nectar_heatmap_plot.R")

source("R/monarch_table.R")
source("R/monarch_plot.R")
