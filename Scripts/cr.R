kuwait_2001$FinalWgt <- kuwait_2001$finalwgt
uae_2002$FinalWgt <-uae_2002$finalwgt
all_data <- list(
  bahrain_2002, bahrain_2015,
  kuwait_2001, kuwait_2005, kuwait_2009, kuwait_2016,
  oman_2002, oman_2007, oman_2010, oman_2016,
  qatar_2004, qatar_2007, qatar_2013, qatar_2018,
  saudi_2001, saudi_2007, saudi_2010, saudi_2022,
  uae_2002, uae_2005, uae_2013
)
# applying pairwise intersection of variable names across all_data items
common_vars <- Reduce(
  intersect,
  lapply(all_data, names)
)
length(common_vars)
common_vars
# filter all_data names to only common variables 
all_data_common <- lapply(all_data, function(df) {
  df |> select(all_of(common_vars))
})






