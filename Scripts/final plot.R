############################################
## Libraries
############################################
library(tidyverse)
library(survey)
library(scales)
library(ggplot2)

############################################
## 1. Read data and harmonize
############################################

bahrain_2015 <- read_csv(
  "~/GCC/GCC Data/Bahrain/CSV/BAHRAIN2015.csv",
  show_col_types = FALSE
) |> mutate(country = "Bahrain", year = 2015)

kuwait_2016 <- read_csv(
  "~/GCC/GCC Data/Kuwait/CSV/KUWAIT2016.csv",
  show_col_types = FALSE
) |> mutate(country = "Kuwait", year = 2016)

oman_2016 <- read_csv(
  "~/GCC/GCC Data/Oman/CSV/OMAN2016.csv",
  show_col_types = FALSE
) |> mutate(country = "Oman", year = 2016)

qatar_2018 <- read_csv(
  "~/GCC/GCC Data/Qatar/CSV/QATAR2018.csv",
  show_col_types = FALSE
) |> mutate(country = "Qatar", year = 2018)

saudi_2022 <- read_csv(
  "~/GCC/GCC Data/Saudi/CSV/SAU2022.csv",
  show_col_types = FALSE
) |> mutate(country = "Saudi Arabia", year = 2022)

uae_2013 <- read_csv(
  "~/GCC/GCC Data/UAE/CSV/UNITEDARABEMIRATES2013.csv",
  show_col_types = FALSE
) |> mutate(country = "UAE", year = 2013)

############################################
## 2. Combine datasets
############################################

all_data_list <- list(
  bahrain_2015,
  kuwait_2016,
  oman_2016,
  qatar_2018,
  saudi_2022,
  uae_2013
)

# Find common variables
common_vars <- Reduce(intersect, lapply(all_data_list, names))

# Keep only common variables
all_data <- all_data_list |>
  map(~ select(.x, all_of(common_vars))) |>
  bind_rows()

############################################
## 3. Survey design
############################################

options(survey.lonely.psu = "adjust")

gcc_design_all <- svydesign(
  id = ~PSU,
  strata = ~Stratum,
  weights = ~FinalWgt,
  data = all_data,
  nest = TRUE
)

############################################
## 4. Function: proportions + CI by country
############################################

get_props_by_country <- function(var, design) {
  
  f <- as.formula(paste0("~factor(", var, ")"))
  
  res <- svyby(
    f,
    ~country,
    design,
    svymean,
    na.rm = TRUE,
    vartype = "ci"
  ) |> as.data.frame()
  
  mean_cols <- grep("^factor\\(", names(res), value = TRUE)
  
  map_dfr(mean_cols, function(m) {
    tibble(
      variable   = var,
      country    = res$country,
      level      = gsub(paste0("factor\\(", var, "\\)"), "", m),
      proportion = res[[m]],
      lci        = res[[paste0("ci_l.", m)]],
      uci        = res[[paste0("ci_u.", m)]]
    )
  })
}

############################################
## 5. Run for all common CR variables
############################################

analysis_vars <- setdiff(
  common_vars,
  c("FinalWgt", "PSU", "Stratum", "country", "year")
)

all_results_country <- map_dfr(
  analysis_vars,
  get_props_by_country,
  design = gcc_design_all
)

############################################
## 6. Bar plots (colored by country)
############################################

ggplot(all_results_country,
       aes(x = level, y = proportion, fill = country)) +
  geom_col(
    position = position_dodge(0.8),
    width = 0.7
  ) +
  geom_errorbar(
    aes(ymin = lci, ymax = uci),
    position = position_dodge(0.8),
    width = 0.2
  ) +
  facet_wrap(~ variable, scales = "free_x") +
  scale_y_continuous(labels = percent_format()) +
  labs(
    x = "Response category",
    y = "Proportion",
    fill = "Country",
    title = "Survey-weighted proportions by country (95% CI)"
  ) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1),
    strip.text = element_text(size = 9)
  )
