#### Preamble ####
# Purpose: Cleans the raw plane data recorded by two observers..... [...UPDATE THIS...]
# Author: Rohan Alexander [...UPDATE THIS...]
# Date: 6 April 2023 [...UPDATE THIS...]
# Contact: rohan.alexander@utoronto.ca [...UPDATE THIS...]
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]

# Load required libraries
library(arrow)
library(dplyr)
library(rsample)

# Load the dataset
raw_data <- read.csv("data/01-raw_data/raw_data.csv", stringsAsFactors = FALSE)


# Step 1: Drop columns with more than 80% missing values
threshold <- 0.8 * nrow(raw_data)
cleaned_data <- raw_data %>% select_if(function(col) sum(is.na(col)) < threshold)

# Step 2: Fill missing values
# Fill numeric columns with median and categorical columns with mode
cleaned_data <- cleaned_data %>% mutate_all(function(col) {
  if (is.numeric(col)) {
    ifelse(is.na(col), median(col, na.rm = TRUE), col)
  } else {
    ifelse(is.na(col), names(which.max(table(col))), col)
  }
})

# Step 3: Additional data cleaning steps
# 3.1 Remove duplicate rows
cleaned_data <- cleaned_data %>% distinct()

# 3.2 Remove outliers from numeric columns using Z-score method
# Calculate Z-scores and filter out rows with Z-score greater than 3
# Step: Remove outliers from numeric columns in cleaned data using Z-score method per column
remove_outliers_per_column <- function(data, threshold = 3) {
  numeric_cols <- data %>% select_if(is.numeric)
  for (col_name in names(numeric_cols)) {
    col <- numeric_cols[[col_name]]
    z_scores <- scale(col)
    data <- data[abs(z_scores) <= threshold | is.na(z_scores), ]
  }
  return(data)
}

# Apply the function to remove outliers from cleaned data
cleaned_data <- remove_outliers_per_column(cleaned_data)

# Step 4: Rename columns for better readability
cleaned_data <- cleaned_data %>% rename(
  dataset_title = name,
  ess_round = essround,
  edition_number = edition,
  production_date = proddate,
  country = cntry,
  respondent_id = idno,
  interviewer_age = intagea,
  interviewer_gender = intgndr,
  interview_conduct_method = vdcond,
  question_clarification = resclq,
  respondent_reluctant = resrelq,
  respondent_tried_best = resbab,
  respondent_understood = resundq,
  interference_present = preintf,
  partner_interference = prewhp,
  child_interference = presd,
  parent_interference = preppil,
  relative_interference = preorel,
  non_relative_interference = prenrel,
  unknown_interference = predk,
  interference_not_applicable = prenap,
  interference_no_answer = prena,
  questionnaire_language = intlnga,
  interviewer_id = intnum
)
# Step: Recode 'respondent_understood' to binary during data cleaning
cleaned_data <- cleaned_data %>%
  mutate(respondent_understood_binary = case_when(
    respondent_understood %in% c(1, 2, 3) ~ "Not_understood",  # 将等级 1, 2, 3 归为 "不理解"
    respondent_understood %in% c(4, 5) ~ "Understood",         # 将等级 4, 5 归为 "理解"
    TRUE ~ NA_character_                                       # 对缺失值保持为 NA
  )) %>%
  mutate(respondent_understood_binary = as.factor(respondent_understood_binary))

# Step: Simplify categories for variables with more than or equal to 5 categories, excluding 'country'
cleaned_data <- cleaned_data %>%
  mutate(
    interview_conduct_method = ifelse(interview_conduct_method %in% names(sort(table(interview_conduct_method), decreasing = TRUE))[1:5],
                                      interview_conduct_method, "Other"),
    question_clarification = ifelse(question_clarification %in% names(sort(table(question_clarification), decreasing = TRUE))[1:5],
                                    question_clarification, "Other"),
    respondent_reluctant = ifelse(respondent_reluctant %in% names(sort(table(respondent_reluctant), decreasing = TRUE))[1:5],
                                  respondent_reluctant, "Other"),
    respondent_tried_best = ifelse(respondent_tried_best %in% names(sort(table(respondent_tried_best), decreasing = TRUE))[1:5],
                                   respondent_tried_best, "Other"),
    partner_interference = ifelse(partner_interference %in% names(sort(table(partner_interference), decreasing = TRUE))[1:5],
                                  partner_interference, "Other"),
    child_interference = ifelse(child_interference %in% names(sort(table(child_interference), decreasing = TRUE))[1:5],
                                child_interference, "Other"),
    parent_interference = ifelse(parent_interference %in% names(sort(table(parent_interference), decreasing = TRUE))[1:5],
                                 parent_interference, "Other"),
    relative_interference = ifelse(relative_interference %in% names(sort(table(relative_interference), decreasing = TRUE))[1:5],
                                   relative_interference, "Other"),
    non_relative_interference = ifelse(non_relative_interference %in% names(sort(table(non_relative_interference), decreasing = TRUE))[1:5],
                                       non_relative_interference, "Other"),
    interviewer_gender = ifelse(interviewer_gender %in% names(sort(table(interviewer_gender), decreasing = TRUE))[1:5],
                                interviewer_gender, "Other")
  ) %>%
  mutate(
    interview_conduct_method = as.factor(interview_conduct_method),
    question_clarification = as.factor(question_clarification),
    respondent_reluctant = as.factor(respondent_reluctant),
    respondent_tried_best = as.factor(respondent_tried_best),
    partner_interference = as.factor(partner_interference),
    child_interference = as.factor(child_interference),
    parent_interference = as.factor(parent_interference),
    relative_interference = as.factor(relative_interference),
    non_relative_interference = as.factor(non_relative_interference),
    interviewer_gender = as.factor(interviewer_gender)
  )

cleaned_data <- cleaned_data %>% drop_na()
cleaned_data  <- cleaned_data  %>%
  distinct(respondent_id, .keep_all = TRUE)
# Step 5: Split the dataset into training and testing sets
# Perform a stratified split based on the 'country' variable to ensure all levels are present in both sets
set.seed(123) # Set seed for reproducibility
split <- initial_split(data = cleaned_data, prop = 0.7)


# Create training and testing sets
analysis_data_train <- training(split)
analysis_data_test <- testing(split)

# Step 6: Save data
write.csv(cleaned_data, "data/02-analysis_data/analysis_data.csv", row.names = FALSE)
write_parquet(cleaned_data, "data/02-analysis_data/analysis_data.parquet")
write_parquet(analysis_data_train, "data/02-analysis_data/train_data.parquet")
write_parquet(analysis_data_test, "data/02-analysis_data/test_data.parquet")

