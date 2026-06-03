

# START -------------------------------------------------------------------

# This script produces a plot contrasting the probability of CVR at 10 years
# given two different paths to ICM-MM, along with the CIs for that contrast
# across 10 year age bands


library(tidyverse)
rm(list=ls())
setwd("")

ages_results_df_lx<-readRDS("cvr_contrast.rds")

num_only<-ages_results_df_lx %>%
  mutate(baseline_age = factor(baseline_age)) %>%
  filter(to == "CVR" | to == "Death")


ages_results_df_lx %>%
  mutate(baseline_age = factor(baseline_age))

# Multimorbid contrast ----------------------------------------------------

geom_size<-3
dodge_width<-0.5
alpha_value<-0.75
common_legend<-"Absorbing state"

ages_results_df_lx %>%
  mutate(baseline_age = factor(baseline_age)) %>%
  filter(to == "CVR" | to == "Death")


ages_results_df_lx %>%
  mutate(baseline_age = factor(baseline_age)) %>%
  filter(to == "CVR" | to == "Death") %>%
  ggplot(aes(
    x = baseline_age,
    y = est,
    ymin = lower,
    ymax = upper,
    colour = to,
    lty=to,
    shape=to,
    group = interaction(to,baseline_age)
  )) +
  geom_point(
    size = geom_size,
    position = position_dodge(width = dodge_width)) +
  geom_errorbar(
    # aes(),
    alpha = alpha_value,
    width = 0.5,
    size = geom_size / 3,
    position = position_dodge(width = dodge_width)
  ) +
  geom_hline(yintercept = 0, lty = "dashed") +
  coord_flip() +
  scale_y_continuous(limits=c(-0.5,0.75)) +
  labs(x = "Age ICM-MM onset",
       y = "Contrast p(CVR [OR Death] | CMD to INT) vs p(CVR [OR Death] | INT to CMD)",
       colour=common_legend,
       shape=common_legend,
       group=common_legend,
       lty=common_legend
       )+
  theme_minimal(base_size = 12, base_family = "sanserif")+
  scale_colour_manual(values = c("black","darkgrey"))


ggsave("CVR_contrast.png",bg = "white")                      

# END ----------------------------------------------------
