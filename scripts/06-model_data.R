#### Preamble ####
# Purpose: Models the impact of various factors on interview data quality using stan_glm.
# Author: Dezhen Chen
# Date: 26 November 2024
# Contact: dezhen.chen@mail.utoronto.ca
# License: MIT
# Pre-requisites: The `tidyverse` package must be installed
# Any other information needed? Make sure you are in the `The-Influence-of-Interview-Disruptions-on-Respondent-Data-Quality-in-Social-Surveys` rproj



#### Workspace setup ####
library(tidyverse)
library(rstanarm)
library(arrow)
library(car)
library(brms)
library(rpart)  


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

summary(model)

#### Save model ####
saveRDS(
  model,
  file = "models/model.rds"
)

tree_model <- rpart(
  formula = respondent_understood_binary ~ interview_conduct_method + 
    partner_interference + child_interference + parent_interference + 
    relative_interference + non_relative_interference + interviewer_age + 
    interviewer_gender + as.factor(country) + question_clarification + 
    respondent_reluctant + respondent_tried_best,
  data = analysis_data_train,
  method = "class"  # 分类任务
)


summary(tree_model)



#### Save model ####
saveRDS(
  tree_model,
  file = "models/treemodel.rds"
)



