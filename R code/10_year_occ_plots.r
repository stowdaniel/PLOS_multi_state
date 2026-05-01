

# Start -------------------------------------------------------------------

# Creates the plots for state occupation probabilities across 10 year age bands (figures 3a and 3b)


# Setup -------------------------------------------------------------------

rm(list = ls())
setwd("")
source("plot_theme.R")
library(tidyverse)
library(viridis)
library(extrafont)
# extrafont::font_import()
# y
loadfonts()
# extrafont::fonts()
# Read in data ------------------------------------------------------------
women<-readRDS("final_state_predictions_10_age_bands_LX_FEMALE.rds")
men<-readRDS("final_state_predictions_10_age_bands_LX_MALE.rds")

# plot labels -------------------------------------------------------------


simple_ages <- c(
  "20" = "20 years old",
  "30" = "30 years old",
  "40" = "40 years old",
  "50" = "50 years old",
  "60" = "60 years old",
  "70" = "70 years old"
  #
)


# Plots -------------------------------------------------------------------



# HEALTHY  ----------------------------------------------------------------


plot_probs <- women


plot_probs$to <-
  factor(
    plot_probs$to,
    levels = c("Death", "CVE", "CMD->INT", "INT->CMD", "CMD", "INT", "Healthy"),
    labels = c(
      "Death",
      "CVR",
      "CMD -> INT",
      "INT->CMD",
      "CMD",
      "INT",
      "Otherwise healthy"
    )
  )



pre_colour_plot<-plot_probs %>%
  filter(from == "Healthy") %>%
  ggplot(aes(x = t, y = p, fill = to)) +
  geom_area(alpha = 0.95) +
  scale_x_continuous(breaks = scales::pretty_breaks()) +
  scale_y_continuous(breaks = scales::pretty_breaks(n = 10)) +
  
  theme_mfx(text_size = 8, font_name = "Arial") +
  theme(
    aspect.ratio = .75,
    plot.caption.position = "plot",
    plot.caption = element_text(hjust = 0)
  ) + facet_wrap( ~ baseline.a, labeller = labeller(baseline.a = simple_ages)) +
  labs(
    x = "Time (years)",
    y = "State occupation probability",
    legend = "State"
 
  )
pre_colour_plot

#add colour

pre_colour_plot+
  scale_fill_brewer(
    palette = "Spectral",
    direction = 1,
    name = "State",
    labels = c(
      "Non-CVR death",
      "Cardiovascular or renal event (CVR)",
      "Multimorbid (CMD->INT)",
      "Multimorbid (INT->CMD)",
      "Cardiometabolic",
      "Internalising",
      "Healthy"
    )
  )

#save women plot
ggsave(
  paste0("_stacked_probs_woman_plos_R1.tiff"),
  bg = "white",
  width = 2250,
  height = 2250/2,
  units = "px",
  device="tiff",
  dpi=300
)


# PLots for men -----------------------------------------------------------



plot_probs <- men


plot_probs$to <-
  factor(
    plot_probs$to,
    levels = c("Death", "CVE", "CMD->INT", "INT->CMD", "CMD", "INT", "Healthy"),
    labels = c(
      "Death",
      "CVR",
      "CMD -> INT",
      "INT->CMD",
      "CMD",
      "INT",
      "Otherwise healthy"
    )
  )


pre_colour_plot<-plot_probs %>%
  filter(from == "Healthy") %>%
  ggplot(aes(x = t, y = p, fill = to)) +
  geom_area(alpha = 0.95) +
  scale_x_continuous(breaks = scales::pretty_breaks()) +
  scale_y_continuous(breaks = scales::pretty_breaks(n = 10)) +
  
  theme_mfx(text_size = 8, font_name = "Arial") +
  theme(
    aspect.ratio = .75,
    plot.caption.position = "plot",
    plot.caption = element_text(hjust = 0)
  ) + facet_wrap( ~ baseline.a, labeller = labeller(baseline.a = simple_ages)) +
  labs(
    x = "Time (years)",
    y = "State occupation probability",
    legend = "State"
  )

#add colour

pre_colour_plot+
  scale_fill_brewer(
    palette = "Spectral",
    direction = 1,
    name = "State",
    labels = c(
      "Non-CVR death",
      "Cardiovascular or renal event (CVR)",
      "Multimorbid (CMD->INT)",
      "Multimorbid (INT->CMD)",
      "Cardiometabolic",
      "Internalising",
      "Healthy"
    )
  )

#save men plot
ggsave(
  paste0("_stacked_probs_men_plos_R1.tiff"),
  bg = "white",
  width = 2250,
  height = 2250/2,
  units = "px",
  device="tiff",
  dpi=300
)
# END ---------------------------------------------------------------------


