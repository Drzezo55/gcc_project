library(tidyverse)
library(dplyr)
library(purrr)
library(survey)
library(tidyr)
library(writexl)
library(ggplot2)

# Bahrain

bahrain_2015 <- read_csv(
  "~/GCC/GCC Data/Bahrain/CSV/BAHRAIN2015.csv",
  show_col_types = FALSE
) |> mutate(country = "Bahrain", year = 2015)
# Kuwait

kuwait_2016 <- read_csv(
  "~/GCC/GCC Data/Kuwait/CSV/KUWAIT2016.csv",
  show_col_types = FALSE
) |> mutate(country = "Kuwait", year = 2016)
# Oman

oman_2016 <- read_csv(
  "~/GCC/GCC Data/Oman/CSV/OMAN2016.csv",
  show_col_types = FALSE
) |> mutate(country = "Oman", year = 2016)
# Qatar


qatar_2018 <- read_csv(
  "~/GCC/GCC Data/Qatar/CSV/QATAR2018.csv",
  show_col_types = FALSE
) |> mutate(country = "Qatar", year = 2018)
# Saudi Arabia 


saudi_2022 <- read_csv(
  "~/GCC/GCC Data/Saudi/CSV/SAU2022.csv",
  show_col_types = FALSE
) |> mutate(country = "Saudi Arabia", year = 2022)
# UAE 


uae_2013 <- read_csv(
  "~/GCC/GCC Data/UAE/CSV/UNITEDARABEMIRATES2013.csv",
  show_col_types = FALSE
) |> mutate(country = "UAE", year = 2013)

#

data_list <- list(
  bahrain_2015 = bahrain_2015,
  kuwait_2016  = kuwait_2016,
  oman_2016    = oman_2016,
  qatar_2018   = qatar_2018,
  saudi_2022  = saudi_2022,
  uae_2013    = uae_2013
)

common_vars <- Reduce(intersect, lapply(data_list, names))

filtered_data_list <- lapply(data_list, function(df) {
  df |> select(all_of(common_vars))
})

gcc_design <- svydesign(
  id = ~PSU,
  strata = ~Stratum,
  weights = ~FinalWgt,
  data = filtered_data_list$bahrain_2015,
  nest = TRUE
)
cr33_prop <- svymean(~factor(CR33), gcc_design, na.rm = TRUE)
gcc_all <- bind_rows(filtered_data_list, .id = "dataset")
gcc_design_all <- svydesign(
  id = ~PSU,
  strata = ~Stratum,
  weights = ~FinalWgt,
  data = gcc_all,
  nest = TRUE
)
analysis_vars <- common_vars |>
  setdiff(c("FinalWgt", "PSU", "Stratum", "country", "year"))
#

get_svy_props <- function(var, design) {
  
  f <- as.formula(paste0("~factor(", var, ")"))
  
  est <- svymean(f, design, na.rm = TRUE)
  ci  <- confint(est)
  
  tibble(
    variable   = var,
    level      = gsub(paste0("factor\\(", var, "\\)"), "", names(coef(est))),
    proportion = as.numeric(coef(est)),
    se         = as.numeric(SE(est)),
    lci        = ci[, 1],
    uci        = ci[, 2]
  )
}
all_results <- map_dfr(
  analysis_vars,
  get_svy_props,
  design = gcc_design_all
)
write_xlsx(
  all_results,
  path = "GCC_all_variables_proportions.xlsx"
)











#
# Create the survey design object
gcc_design <- svydesign(
  id = ~PSU,
  strata = ~Stratum,
  weights = ~FinalWgt,
  data = filtered_data_list$bahrain_2002,
  nest = TRUE
)
# Example: survey mean of CR1
svymean(~CR33, gcc_design, na.rm = TRUE)
# Compute proportion for each level of CR33
cr33_prop <- svymean(~factor(CR33), gcc_design, na.rm = TRUE)

# Show results
cr33_prop









