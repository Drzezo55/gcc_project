library(survey)
# Combine all datasets into one pooled dataset
gcc_common <- bind_rows(all_data_common)
# Make PSU and Stratum unique across countries and years
gcc_common <- gcc_common |> 
  mutate(
    PSU = interaction(country, year, PSU, drop = TRUE),
    Stratum = interaction(country, year, Stratum, drop = TRUE)
  )

# Create the survey design object
gcc_design <- svydesign(
  id = ~PSU,
  strata = ~Stratum,
  weights = ~FinalWgt,
  data = gcc_common,
  nest = TRUE
)

# Quick sanity check
summary(gcc_design)

# Example: survey mean of CR1
svymean(~CR1, gcc_design, na.rm = TRUE)


cr_vars <- c("CR1","CR2","CR14","CR16","CR31","CR32","CR33",
             "CR34","CR35","CR41","CR42")


view(gcc_common)


