# PLOS multi-state analysis code

This repository contains R code accompanying a PLOS Medicine article using multi-state modelling to estimate transition hazards and state occupation probabilities.

The code fits transition-specific survival models, predicts 10-year state occupation probabilities, and generates manuscript figures.

## Repository contents

```text
PLOS_multi_state/
├── README.md
├── R/
│   ├── 01_main_model_fitting.Rmd
│   ├── 02_predict_state_occupation_probabilities.R
│   ├── 03_plot_state_occupation_probabilities.R
│   ├── 04_plot_cvr_contrasts.R
│   └── functions/
│       ├── load_fitted_models.R
│       ├── occurrence_probability_difference.R
│       └── transition_matrix.R
├── results/
│   └── README.md
├── figures/
│   └── README.md
└── session_info.txt
```

## Suggested workflow

Run the scripts in the following order.

### 1. Fit the multi-state models

```text
R/01_main_model_fitting.Rmd
```

This script prepares the multi-state analysis dataset, defines transition-specific models, selects spline complexity, fits flexible parametric survival models, and saves fitted model objects.

### 2. Predict state occupation probabilities

```text
R/02_predict_state_occupation_probabilities.R
```

This script loads the fitted transition models and generates predicted 10-year state occupation probabilities by baseline age group.

### 3. Plot state occupation probabilities

```text
R/03_plot_state_occupation_probabilities.R
```

This script creates the main state occupation probability plots for the manuscript.

### 4. Plot cardiovascular/renal contrasts

```text
R/04_plot_cvr_contrasts.R
```

This script creates contrast plots for cardiovascular/renal event probabilities.

## Data requirements

The analytic dataset is not included in this repository.

To run the code, users need an input data frame containing the variables referenced in the scripts. This includes transition times, event indicators, demographic variables, deprivation index, smoking status, and polygenic score variables.

### Expected transition time variables

```text
int.t
cmd.t
int.cmd.t
cmd.int.t
cve.t
death.t
```

### Expected transition indicator variables

```text
int.i
cmd.i
int.cmd.i
cmd.int.i
cve.i
death.i
```

### Expected covariates

```text
gender
ethnicity
smoking_status
baseline.a
int.a
cmd.a
int.cmd.a
cmd.int.a
cve.a
death.a
IMD
icmm_pgs
```

## Software requirements

The analysis is written in R.

The scripts use the following R packages:

```text
mstate
flexsurv
survival
rms
tidyverse
kableExtra
viridis
extrafont
```

For reproducibility, we recommend adding either:

```text
renv.lock
```

created using:

```r
renv::snapshot()
```

or a session information file:

```text
session_info.txt
```

created using:

```r
sessioninfo::session_info()
```

## Outputs

The code produces fitted model objects, predicted state occupation probabilities, and manuscript figures.

Recommended output folders are:

```text
results/models/
results/predictions/
figures/main/
figures/supplementary/
```

Generated model objects and figures may be large and do not necessarily need to be tracked by Git.

