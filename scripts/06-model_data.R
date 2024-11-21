#### Preamble ####
# Purpose: Models... [...UPDATE THIS...]
# Author: Rohan Alexander [...UPDATE THIS...]
# Date: 11 February 2023 [...UPDATE THIS...]
# Contact: rohan.alexander@utoronto.ca [...UPDATE THIS...]
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]

install.packages("loo")

#### Workspace setup ####
library(tidyverse)
library(rstanarm)
library(arrow)
library(car)
library(brms)

#### Read data ####
analysis_data_train <- read_parquet("data/02-analysis_data/train_data.parquet")

model <-
  stan_glm(
    formula = respondent_understood_binary ~ interview_conduct_method + partner_interference +
      child_interference + parent_interference + relative_interference +
      non_relative_interference + interviewer_age + interviewer_gender +
      as.factor(country) + question_clarification + respondent_reluctant + respondent_tried_best,
    data = analysis_data_train,
    family = binomial(),
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
    seed = 853
  )


vif(model)
summary(model)

#### Save model ####
saveRDS(
  model,
  file = "models/model.rds"
)


