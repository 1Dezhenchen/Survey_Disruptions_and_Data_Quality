#### Preamble ####
# Purpose: Simulates a dataset of Australian electoral divisions, including the 
#state and party that won each division.
# Author: Dezhen Chen
# Date: 26 November 2024
# Contact: dezhen.chen@mail.utoronto.ca
# License: MIT
# Pre-requisites: The `tidyverse` package must be installed
# Any other information needed? Make sure you are in the `The-Influence-of-Interview-Disruptions-on-Respondent-Data-Quality-in-Social-Surveys` rproj




#### Workspace setup ####
library(tidyverse)
library(testthat)

# Load the dataset
analysis_data <- read_csv("data/02-analysis_data/analysis_data.csv")
analysis_data <- analysis_data %>%
  mutate(across(c(country, interview_conduct_method, questionnaire_language, question_clarification, respondent_reluctant, respondent_tried_best, respondent_understood), as.factor))
# Test analysis data ####

# Test 1: The dataset should have rows and columns greater than zero
test_that("dataset has rows and columns greater than zero", {
  expect_gt(nrow(analysis_data), 0)
  expect_gt(ncol(analysis_data), 0)
})

# Test 2: The dataset should have the expected number of columns (e.g., 24)
test_that("dataset has 24 columns", {
  expect_equal(ncol(analysis_data), 24)
})

# Test 3: No missing values in the dataset
test_that("no missing values in dataset", {
  expect_true(all(!is.na(analysis_data)))
})

# Test 4: Specific columns should have correct data types
test_that("specific columns have correct types", {
  expect_type(analysis_data$interviewer_age, "double")
  expect_type(analysis_data$respondent_understood, "double")
  expect_type(analysis_data$country, "character")
  expect_type(analysis_data$interview_conduct_method, "double")
})



# Test 6: Categorical columns should be of type factor (updated based on renamed columns)
test_that("categorical columns are factors", {
  categorical_columns <- c("country", "interview_conduct_method", "questionnaire_language", "question_clarification", "respondent_reluctant", "respondent_tried_best", "respondent_understood")
  for (col in categorical_columns) {
    expect_true(is.factor(analysis_data[[col]]))
  }
})

# Test 7: Respondent understanding should be between 1 and 5 (based on categories shown)
# Filtering out the special values (8 and 9) before running the test
test_that("respondent_understood is between 1 and 5", {
  filtered_data <- analysis_data %>%
    filter(!respondent_understood %in% c(8, 9)) %>%
    mutate(respondent_understood = as.numeric(as.character(respondent_understood)))  # Convert factor to numeric for comparison
  expect_true(all(filtered_data$respondent_understood >= 1 & filtered_data$respondent_understood <= 5, na.rm = TRUE))
})


# Test 8: Interviewer age should be within a reasonable range (e.g., 18 to 99)
test_that("interviewer_age is within the range 18 to 99", {
  expect_true(all(analysis_data$interviewer_age >= 18 & analysis_data$interviewer_age <= 99, na.rm = TRUE))
})

# Test 9: Production date should be valid and correctly formatted
test_that("production_date is in valid format", {
  expect_s3_class(as.Date(analysis_data$production_date, format = "%d.%m.%Y"), "Date")
})

# Test 10: Ensure no duplicate respondent IDs
test_that("no duplicate respondent IDs", {
  expect_equal(n_distinct(analysis_data$respondent_id), nrow(analysis_data))
})
