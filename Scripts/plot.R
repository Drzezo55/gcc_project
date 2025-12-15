library(ggplot2)
library(tidyr)

cr_long <- cr_summary_wide %>%
  pivot_longer(
    cols = matches("^CR\\d+_"),       # all CR-related columns
    names_to = c("variable", "stat"), # split into variable and statistic
    names_pattern = "(CR\\d+)_(.*)"   # everything after CR\d+_ goes into stat
  ) %>%
  pivot_wider(
    names_from = stat,
    values_from = value
  )
cr_long <- cr_long %>%
  rename(
    LCI = mean_LCI,
    UCI = mean_UCI
  )

library(ggplot2)

# Create the plot
cr_plot <- ggplot(cr_long, aes(x = factor(year), y = mean, color = country, group = country)) +
  geom_point() +
  geom_line() +
  geom_errorbar(aes(ymin = LCI, ymax = UCI), width = 0.2) +
  facet_wrap(~variable, scales = "free_y") +
  labs(x = "Year", y = "Weighted Mean", 
       title = "Survey Means of CR Variables by Country and Year") +
  theme_minimal()

# Display the plot
cr_plot
ggsave(filename = "CR_variables_plot.png", plot = cr_plot, width = 20, height = 12, dpi = 300)

