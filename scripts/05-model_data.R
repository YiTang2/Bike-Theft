#### Preamble ####
# Purpose: Set a suitable model for the dataset
# Author: Yi Tang
# Date: 26 Novemeber 2024
# Contact: zachayr.tang@mail.utoronto.ca
# License: MIT
# Pre-requisites: No.
# Any other information needed? No.


#### Workspace setup ####
library(tidyverse)
library(rstanarm)

#### Read data ####
analysis_data <- read_csv("data/02-analysis_data/analysis_data.csv")

#### Model data ####
# Fit a Bayesian logistic regression model to predict Theft_Status
Bike_Theft_model <- 
  stan_glm(
    formula = Theft_Status ~ Occurrence_Hour + Premises_Type + Bike_Cost + Region,
    data = analysis_data,
    family = binomial(link = "logit"),  # Logistic regression for binary outcome
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
    seed = 304
  )

#### Save model ####
saveRDS(
  Bike_Theft_model,
  file = "models/Bike_Theft_model.rds"
)


