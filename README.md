# LINC multi-state analysis code

This repository contains R code to replicate the multi-state modelling analysis reported in doi: https://doi.org/10.1101/2025.10.13.25337676

The code fits transition-specific survival models, predicts 10-year state occupation probabilities based on a reference individual, and generates manuscript figures.

## Repository contents

```text
PLOS_multi_state/
├── README.md
├── R code/
│   ├── 01_main_model_fitting.Rmd
│   ├── 02_predict_state_occupation_probabilities.R
│   ├── 03_plot_state_occupation_probabilities.R
│   ├── 04_plot_state_occupation_contrasts.R
│   └── functions/
│       ├── make_transition_matrix.R
│       ├── load_fitted_models.R
│       ├── calculate_occupation_probability_contrasts.r
│       └── transition_matrix.R
├── minimal_dataset
│   ├── 10_year_trajectories_men.csv
│   ├── 10_year_trajectories_women.csv
│   ├── contrast_IMD.csv
│   ├── contrast_ethnicity.csv
│   ├── contrast_gender.csv
│   ├── contrast_icmm_pgs.csv
│   └── contrast_smoking.csv

```

## Suggested workflow

Run the scripts in the following order.

### 1. Fit the multi-state models

```text
R code/01_main_model_fitting.Rmd
```

This script prepares the multi-state analysis dataset, defines transition-specific models, selects spline complexity, fits flexible parametric survival models, and saves fitted model objects.

### 2. Predict state occupation probabilities

```text
R code/02_predict_state_occupation_probabilities.R
```

This script loads the fitted transition models and generates predicted 10-year state occupation probabilities by baseline age group.

### 3. Plot state occupation probabilities

```text
R code/03_plot_state_occupation_probabilities.R
```

This script creates the main state occupation probability plots for the manuscript.

### 4. Predict state occupation contrasts

```text
R code/functions/calculate_occupation_probability_contrasts.r
```
This script generates state occupation probability contrasts and associated confidence intervals via bootstrapping. 


### 5. Plot state occupation contrasts

```text
R code/04_plot_state_occupation_contrasts.R
```
This script creates plots contrasting state occupation probabilities by different covariate values.

## Data requirements

The analytic dataset is not included in this repository. Bona fide researchers may [apply to access Genes & Health data](https://www.genesandhealth.org/researchers/apply-for-access/), which is secured in an ISO27001 compliant Trusted Research Environment.

To run the code, users need an input data frame containing the variables referenced in the scripts. This includes transition times, event indicators, demographic variables, deprivation index, smoking status, and a polygenic risk score variable.

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

## Outputs

The code produces fitted model objects, predicted state occupation probabilities, and manuscript figures.

Recommended output folders are:

```text
results/models/
results/predictions/
figures/main/
figures/supplementary/
```
## Minimal dataset

The minimal dataset folder contains the data underlying the figures in the main article for reference. 

