
# START -------------------------------------------------------------------

# Produces 10 year state occupation probabilities over 10 year baseline age bands
# DO NOT USE IN RSTUDIO - CALL FROM TERMINAL (MCLAPPLY)

# SETUP -------------------------------------------------------------------

# Clear the workspace
rm(list = ls())
# Set the WD
setwd("")
# Load packages
library(flexsurv)

# STEP 1: Generate data ---------------------------------------------------

  # REFERENCE DATA
reference_data <-
  data.frame(
    "baseline.a" = 40,
    "gender" = "Male",
    "ethnicity" = "Bangladeshi",
    "IMD" = "1",
    "icmm_pgs" = 0,
    "smoking_status" = "Never"
  )


# Step 2: read in the models ----------------------------------------------

# Model paths to read in
model_paths <-
  list.files(path = paste0(""),
             pattern="*.rda",
             full.names = TRUE)

# model_paths<-model_paths[-1]

# Load helper functions
source("code/functions/transition_matrix_fn.R")
source("code/functions/model_load_fn.R")
# library(rms)

# predict 10 years + per baseline a --------------------------------------------
ages_LX<-list(20,30,40,50,60,70)


ages_LX<-lapply(ages_LX, function(x) reference_data <-
  data.frame(
    "baseline.a" = x,
    "gender" = "Male",
    "ethnicity" = "Bangladeshi",
    "IMD" = "1",
    "icmm_pgs" = 0,
    "smoking_status" = "Never"
  ))

# Write the function ------------------------------------------------------

state_occ_lx<-function(x){
  require(rms)
  
  states<-pmatrix.simfs(
    my_msm,
    trans = tmat,
    t = c(seq(0,10,by=0.1)),
    ci=TRUE,
    M=10000,
    B = 400,
    newdata = x,
    tcovs = "baseline.a",
    tidy = TRUE
  )
  return(states)
}


# RUN THE LOOP ------------------------------------------------------------
cat(paste(reference_data$gender))
cat(paste("Starting the loop at",Sys.time()))


total_time<-system.time(ages_lx_results<-parallel::mclapply(ages_LX, state_occ_lx, mc.cores = parallel::detectCores(),mc.preschedule = FALSE))
cat(total_time)
cat(paste("Finishing the loop at",Sys.time()))


# Munge the results -------------------------------------------------------

require(tidyverse)
names(ages_lx_results)<-c("20","30","40","50","60","70")

ages_results_df_lx<-bind_rows(ages_lx_results, .id="baseline.a")
ages_results_df_lx<-ages_results_df_lx %>%
  ungroup()%>%
  mutate(baseline.a = as.numeric(baseline.a))%>%
  mutate(t2 = baseline.a+t)


ages_results_df_lx$from_ordered <-
  factor(
    ages_results_df_lx$from,
    levels = c("CMD->INT", "CMD", "Healthy", "INT", "INT->CMD"),
    labels = c("CMD -> INT", "CMD","Otherwise healthy","INT","INT->CMD")
  )



# save the results --------------------------------------------------------


saveRDS(ages_results_df_lx,"final_state_predictions_10_age_bands_LX_MALE.rds")


print(paste("DONE at",Sys.time()))
print(paste("Total run time",total_time))

# END ---------------------------------------------------------------------


