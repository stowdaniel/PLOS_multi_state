# SETUP -------------------------------------------------------------------
library(tidyverse)
# Clear the workspace
rm(list = ls())
# Set the WD
setwd("your_wd")

# Set width
width=2250


# READ THE DATA BACK IN ---------------------------------------------------
contrast_name<-"icmm_pgs"

contrast_info<-readr::read_rds(paste0("results/predictions/",contrast_name,".rds"))


contrast_info[["reference_data"]]$gender


contrast_info[["contrast_probs"]]$state <-
  factor(
    contrast_info[["contrast_probs"]]$state,
    levels = c("Healthy", "INT","INT -> CMD",  "CVE", "CMD",  "CMD -> INT","Death")
  )

simple_states<-c(
  "Healthy" = "Otherwise healthy",
  "INT" = "Internalising (INT)",
  "CMD" = "Cardiometabolic (CMD)",
  "INT -> CMD" = "Multimorbid (INT->CMD)",
  "CMD -> INT" = "Multimorbid (CMD->INT)",
  "CVE" = "Cardiovascular or renal event (CVR)",
  "Death" = "Non-CVR death"
  #  
)

# plot_probs<-probs
contrast_probs<-contrast_info[["contrast_probs"]]

disease_states<-contrast_info[["contrast_probs"]]%>%
  filter(str_detect(state, "Healthy",negate=TRUE))%>%
  ggplot(aes(x=time, y=est))+
  geom_ribbon(aes(min=lci,ymax=uci),alpha=.25, fill ="#32449b")+
  geom_smooth(colour = "#32449b",se=FALSE,linewidth=1.0, method="gam")+
  # geom_line(colour = "#32449b",linewidth=1.2)+
  facet_wrap(~state, labeller = labeller(state = simple_states))+
  geom_hline(yintercept = 0, lty="dashed", alpha =0.5)+
  theme_mfx(text_size=8, font_name = "Arial")+
  scale_x_continuous(breaks = scales::pretty_breaks(n=5))+
  scale_y_continuous(breaks = scales::pretty_breaks(n=10))+
  labs(
       x = "Time (years)",
       y = "Difference in probabilities",
      )

healthy_state<-contrast_info[["contrast_probs"]]%>%
  filter(str_detect(state, "Healthy",negate=FALSE))%>%
  ggplot(aes(x=time, y=est))+
  geom_ribbon(aes(min=lci,ymax=uci),alpha=.25, fill ="#32449b")+
  geom_smooth(colour = "#32449b",se=FALSE,linewidth=1.0, method="gam")+
  # geom_line(colour="red")+
  facet_wrap(~state, labeller = labeller(state = simple_states))+
  geom_hline(yintercept = 0, lty="dashed", alpha =0.5)+
  theme_mfx(text_size=8, font_name = "Arial")+
  scale_x_continuous(breaks = scales::pretty_breaks(n=5))+
  scale_y_continuous(breaks = scales::pretty_breaks(n=10))+
  labs(x="",
       y=""
      )


combined_plot<-gridExtra::arrangeGrob(healthy_state, disease_states,ncol=2,nrow=1, widths=c(1,3))


# Save the plot with some sensible defaults
ggsave(
  combined_plot,
  file = paste0(
    "results/plots/contrasts/",
    contrast_info[["contrast_name"]],
    "_contrast_r1.tiff"
  ),
  bg = "white",
  width = width,
  height = width/2.5,
  units = "px",
  device="tiff",
  dpi=300
)


# END ---------------------------------------------------------------------


