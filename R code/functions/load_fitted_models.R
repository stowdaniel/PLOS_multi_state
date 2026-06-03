
# MODEL LOAD FN -----------------------------------------------------------

model_paths <-
  list.files(path = paste0("results_folder_location"),
             full.names = TRUE)

# Read in the models
model_list <- lapply(model_paths, readRDS)
# Reformat the names of the models
names(model_list) <- gsub(".rda", "", basename(model_paths))
# add to environment
list2env(model_list, globalenv())

my_msm <-
  flexsurv::fmsm(
    t1_rcs,
    t2_rcs,
    t3_rcs,
    t4_rcs,
    t5_rcs,
    t6_rcs,
    t7_rcs,
    t8_rcs,
    t9_rcs,
    t10_rcs,
    t11_rcs,
    t12_rcs,
    t13_rcs,
    t14_rcs,
    trans = tmat
  )


# END ---------------------------------------------------------------------
