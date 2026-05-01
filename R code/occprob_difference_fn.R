# FLEXSURV BOOTSTRAP  -----------------------------------------------------

# Function to pass to bootci.fmsm
occprob_difference <- function(x, t, n_simulate) {
  # REFERENCE
  library(rms)
  
  reference_preds <-
    flexsurv::pmatrix.simfs(
      x,
      trans = tmat,
      tcovs = "baseline.a",
      t = t,
      ci = FALSE,
      cores = parallel::detectCores(),
      newdata = reference_data,
      tidy = FALSE,
      M = n_simulate
    )
  
  # Reference predictions
  reference_preds <- data.frame(reference_preds)[1, ]
  
  
  # CONTRAST
  contrast_preds <-
    flexsurv::pmatrix.simfs(
      x,
      trans = tmat,
      tcovs = "baseline.a",
      t = t,
      ci = FALSE,
      cores = parallel::detectCores(),
      newdata = contrast_data,
      tidy = FALSE,
      M = n_simulate
    )
  # Contrast predictions
  contrast_preds <- data.frame(contrast_preds)[1, ]
  
  # Difference in probabilities (contrast versus reference)
  p_diff <- contrast_preds-reference_preds
  
}

# END ---------------------------------------------------------------------

