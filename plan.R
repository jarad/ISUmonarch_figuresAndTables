source("_drake.R")

plan = drake_plan(
  palette = get_palette(),
  sites   = get_sites(file_in("data/sites.csv")),
  
  robel = get_robel() %>% left_join(sites, by = "site"),
  robel_monthly = summarize_robel_monthly(robel) ,
  robel_yearly  = summarize_robel_yearly( robel),
  # robel_monthly_plot = target(
  #   robel_monthly_plot(robel_monthly, palette),
  #   dynamic = map(region_monthly)
  # ),
  # 
  cover = get_cover(),
  cover_yearly = summarize_cover_yearly(cover),
  
  nectar = get_nectar(),
  nectar_monthly    = summarize_nectar_monthly(nectar),
  nectar_by_species = summarize_nectar_by_species(nectar),
  
  monarch = get_monarch()
  
  # ncig_sites = get_ncig_sites(),
  # ncig_report = target( 
  #   command = {
  #     rmarkdown::render(knitr_in("doc/ncig.Rmd"))
  #     file_out("doc/ncig.pdf")
  #   }
  # )
  
  
)

make(plan)
