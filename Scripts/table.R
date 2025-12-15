library(dplyr)
library(purrr)
library(survey)
library(tidyr)
library(writexl)
cr_vars <- c("CR1","CR2","CR14","CR16","CR31","CR32","CR33",
             "CR34","CR35","CR41","CR42")

# Compute for each variable and bind into one long table
cr_summary <- map_dfr(cr_vars, function(var) {
  
  tab <- svyby(
    as.formula(paste0("~", var)),
    by = ~country + year,
    design = gcc_design,
    FUN = svymean,
    na.rm = TRUE
  )
  
  # Convert to tibble and rename columns reliably
  tab <- tab %>%
    as_tibble() %>%
    rename_with(~c("country","year","mean","SE"), .cols = c(1,2,3,4)) %>%
    mutate(variable = var) %>%
    select(country, year, variable, mean, SE)
  
  return(tab)
})
cr_summary_wide <- cr_summary %>%
  pivot_wider(
    names_from = variable,
    values_from = c(mean, SE),
    names_glue = "{variable}_{.value}"
  )
# Identify mean columns
mean_cols <- paste0(cr_vars, "_mean")

# Add LCI and UCI
cr_summary_wide <- cr_summary_wide %>%
  mutate(across(all_of(mean_cols), 
                .fns = list(
                  LCI = ~ . - 1.96 * get(sub("_mean$", "_SE", cur_column())),
                  UCI = ~ . + 1.96 * get(sub("_mean$", "_SE", cur_column()))
                ),
                .names = "{.col}_{.fn}"
  ))


# Save wide table
write_xlsx(cr_summary_wide, path = "CR_summary_wide.xlsx")