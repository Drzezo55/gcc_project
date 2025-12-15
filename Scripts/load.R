library(tidyverse)
# Bahrain
bahrain_2002 <- read_csv(
  "~/GCC/GCC Data/Bahrain/CSV/BAHRAIN2002.csv",
  show_col_types = FALSE
) |> mutate(country = "Bahrain", year = 2002)

bahrain_2015 <- read_csv(
  "~/GCC/GCC Data/Bahrain/CSV/BAHRAIN2015.csv",
  show_col_types = FALSE
) |> mutate(country = "Bahrain", year = 2015)
# Kuwait
kuwait_2001 <- read_csv(
  "~/GCC/GCC Data/Kuwait/CSV/KUWAIT 2001.csv",
  show_col_types = FALSE
) |> mutate(country = "Kuwait", year = 2001)

kuwait_2005 <- read_csv(
  "~/GCC/GCC Data/Kuwait/CSV/KUWAIT2005.csv",
  show_col_types = FALSE
) |> mutate(country = "Kuwait", year = 2005)

kuwait_2009 <- read_csv(
  "~/GCC/GCC Data/Kuwait/CSV/KUWAIT2009.csv",
  show_col_types = FALSE
) |> mutate(country = "Kuwait", year = 2009)

kuwait_2016 <- read_csv(
  "~/GCC/GCC Data/Kuwait/CSV/KUWAIT2016.csv",
  show_col_types = FALSE
) |> mutate(country = "Kuwait", year = 2016)
# Oman
oman_2002 <- read_csv(
  "~/GCC/GCC Data/Oman/CSV/OMAN2002.csv",
  show_col_types = FALSE
) |> mutate(country = "Oman", year = 2002)

oman_2007 <- read_csv(
  "~/GCC/GCC Data/Oman/CSV/OMAN2007.csv",
  show_col_types = FALSE
) |> mutate(country = "Oman", year = 2007)

oman_2010 <- read_csv(
  "~/GCC/GCC Data/Oman/CSV/OMAN2010.csv",
  show_col_types = FALSE
) |> mutate(country = "Oman", year = 2010)

oman_2016 <- read_csv(
  "~/GCC/GCC Data/Oman/CSV/OMAN2016.csv",
  show_col_types = FALSE
) |> mutate(country = "Oman", year = 2016)
# Qatar
qatar_2004 <- read_csv(
  "~/GCC/GCC Data/Qatar/CSV/QATAR2004.csv",
  show_col_types = FALSE
) |> mutate(country = "Qatar", year = 2004)

qatar_2007 <- read_csv(
  "~/GCC/GCC Data/Qatar/CSV/QATAR2007.csv",
  show_col_types = FALSE
) |> mutate(country = "Qatar", year = 2007)

qatar_2013 <- read_csv(
  "~/GCC/GCC Data/Qatar/CSV/QATAR2013.csv",
  show_col_types = FALSE
) |> mutate(country = "Qatar", year = 2013)

qatar_2018 <- read_csv(
  "~/GCC/GCC Data/Qatar/CSV/QATAR2018.csv",
  show_col_types = FALSE
) |> mutate(country = "Qatar", year = 2018)
# Saudi Arabia 
saudi_2001 <- read_csv(
  "~/GCC/GCC Data/Saudi/CSV/SAU2001.csv",
  show_col_types = FALSE
) |> mutate(country = "Saudi Arabia", year = 2001)

saudi_2007 <- read_csv(
  "~/GCC/GCC Data/Saudi/CSV/SAU2007.csv",
  show_col_types = FALSE
) |> mutate(country = "Saudi Arabia", year = 2007)

saudi_2010 <- read_csv(
  "~/GCC/GCC Data/Saudi/CSV/SAU2010.csv",
  show_col_types = FALSE
) |> mutate(country = "Saudi Arabia", year = 2010)

saudi_2022 <- read_csv(
  "~/GCC/GCC Data/Saudi/CSV/SAU2022.csv",
  show_col_types = FALSE
) |> mutate(country = "Saudi Arabia", year = 2022)
# UAE 
uae_2002 <- read_csv(
  "~/GCC/GCC Data/UAE/CSV/UNITEDARABEMIRATES2002.csv",
  show_col_types = FALSE
) |> mutate(country = "UAE", year = 2002)

uae_2005 <- read_csv(
  "~/GCC/GCC Data/UAE/CSV/UNITEDARABEMIRATES2005.csv",
  show_col_types = FALSE
) |> mutate(country = "UAE", year = 2005)

uae_2013 <- read_csv(
  "~/GCC/GCC Data/UAE/CSV/UNITEDARABEMIRATES2013.csv",
  show_col_types = FALSE
) |> mutate(country = "UAE", year = 2013)
