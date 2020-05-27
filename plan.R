source("_drake.R")

plan = drake_plan(
  robel = get_robel(),
  robel_monthly = summarize_robel_monthly(robel),
  robel_yearly  = summarize_robel_yearly( robel),
  
  cover = get_cover(),
  cover_yearly = summarize_cover_yearly(cover),
  
  nectar = get_nectar(),
  nectar_monthly    = summarize_nectar_monthly(nectar),
  nectar_by_species = summarize_nectar_by_species(nectar),
  
  monarch = get_monarch(),
  
  ncig_report = rmarkdown::render(
    knitr_in("doc/ncig.Rmd"),
    output_file = file_out("doc/ncig.pdf")
  )
  
  
)

make(plan)
