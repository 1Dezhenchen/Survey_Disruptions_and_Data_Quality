#### Preamble ####
# Purpose: Performs exploratory data analysis on the cleaned interview dataset.
# Author: Dezhen Chen
# Date: 26 November 2024
# Contact: dezhen.chen@mail.utoronto.ca
# License: MIT
# Pre-requisites: The `tidyverse` package must be installed
# Any other information needed? Make sure you are in the `The-Influence-of-Interview-Disruptions-on-Respondent-Data-Quality-in-Social-Surveys` rproj
#### Workspace setup ####
library(tidyverse)
library(GGally)
library(ggplot2)


# Load the dataset
analysis_data <- read_csv("data/02-analysis_data/analysis_data.csv")

# Set theme for better aesthetics
theme_set(theme_minimal())

# Plot 1: Distribution of Interviewer Age
ggplot(analysis_data, aes(x = interviewer_age)) +
  geom_histogram(bins = 20, fill = "skyblue", color = "black") +
  labs(title = "Distribution of Interviewer Age", x = "Interviewer Age", y = "Count")

# Plot 2: Distribution of Respondent Understanding
ggplot(analysis_data, aes(x = respondent_understood)) +
  geom_histogram(bins = 20, fill = "lightgreen", color = "black") +
  labs(title = "Distribution of Respondent Understanding", x = "Respondent Understanding", y = "Count")

# Plot 3: Interview Conduct Method vs Respondent Understanding
ggplot(analysis_data, aes(x = interview_conduct_method, y = respondent_understood)) +
  geom_boxplot(fill = "lightblue") +
  labs(title = "Interview Conduct Method vs Respondent Understanding", x = "Conduct Method", y = "Respondent Understanding") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Plot 4: Country vs Respondent Understanding (Top 10 countries)
top_countries <- analysis_data %>% 
  count(country, sort = TRUE) %>% 
  top_n(10) %>% 
  pull(country)

filtered_data <- analysis_data %>% 
  filter(country %in% top_countries)

ggplot(filtered_data, aes(x = country, y = respondent_understood)) +
  geom_boxplot(fill = "lightpink") +
  labs(title = "Country-wise Respondent Understanding (Top 10 Countries)", x = "Country", y = "Respondent Understanding") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Plot 5: Relationship between Interviewer Age and Respondent Understanding
ggplot(analysis_data, aes(x = interviewer_age, y = respondent_understood)) +
  geom_point(alpha = 0.6) +
  geom_smooth(method = "lm", color = "red") +
  labs(title = "Interviewer Age vs Respondent Understanding", x = "Interviewer Age", y = "Respondent Understanding")

# Plot 6: Distribution of Respondent Tried Best (Likert Scale Response)
ggplot(analysis_data, aes(x = respondent_tried_best)) +
  geom_bar(fill = "purple", color = "black") +
  labs(title = "Distribution of Respondent Tried Best", x = "Respondent Tried Best (Likert Scale)", y = "Count")

# Plot 7: Parent Interference vs Respondent Understanding
ggplot(analysis_data, aes(x = parent_interference, y = respondent_understood)) +
  geom_boxplot(fill = "steelblue") +
  labs(title = "Parent Interference vs Respondent Understanding", x = "Parent Interference", y = "Respondent Understanding") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Plot 8: Respondent Reluctance vs Respondent Understanding
ggplot(analysis_data, aes(x = respondent_reluctant, y = respondent_understood)) +
  geom_boxplot(fill = "orange") +
  labs(title = "Respondent Reluctance vs Respondent Understanding", x = "Respondent Reluctance", y = "Respondent Understanding") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Plot 9: Distribution of Questionnaire Language
ggplot(analysis_data, aes(x = questionnaire_language)) +
  geom_bar(fill = "darkgreen", color = "black") +
  labs(title = "Distribution of Questionnaire Language", x = "Questionnaire Language", y = "Count") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Plot 10: Interference Present vs Respondent Understanding
ggplot(analysis_data, aes(x = interference_present, y = respondent_understood)) +
  geom_boxplot(fill = "tomato") +
  labs(title = "Interference Present vs Respondent Understanding", x = "Interference Present", y = "Respondent Understanding") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))





# Plot 2: Interviewer Age Density by Top 5 Countries
top_countries <- analysis_data %>%
  count(country, sort = TRUE) %>%
  top_n(5, n) %>%
  pull(country)

filtered_data <- analysis_data %>%
  filter(country %in% top_countries)

ggplot(filtered_data, aes(x = interviewer_age, fill = country, color = country)) +
  geom_density(alpha = 0.4) +
  labs(title = "Density Plot of Interviewer Age by Top 5 Countries", x = "Interviewer Age", y = "Density") +
  theme_minimal()


#### Advanced Visualization Code ####
# Let's create some advanced visualizations using the dataset and column names provided earlier.

# Load necessary libraries
library(ggplot2)
library(dplyr)

# Assuming 'analysis_data' is your dataset

# 1. Density Plot of Interview Duration by Gender of Interviewer
#   This visualization helps understand the distribution of interview durations across interviewer genders.
ggplot(analysis_data, aes(x = interviewer_id, fill = interviewer_gender)) +
  geom_density(alpha = 0.5) +
  labs(
    title = "Density Plot of Interview Duration by Interviewer Gender",
    x = "Interview Duration (minutes)",
    y = "Density"
  ) +
  theme_minimal() +
  scale_fill_brewer(palette = "Set2")






# 5. Heatmap of Respondent Understanding by Age Group and Country
#   Shows patterns of understanding among respondents across different age groups and countries.
# 过滤缺失值
analysis_data <- analysis_data %>%
  filter(!is.na(interviewer_age), !is.na(country), !is.na(respondent_understood)) %>%
  mutate(age_group = cut(interviewer_age, breaks = c(10, 20, 30, 40, 50, 60, 70, 80, 90), include.lowest = TRUE))

# 创建热图
ggplot(analysis_data, aes(x = country, y = age_group, fill = respondent_understood)) +
  geom_tile(na.rm = TRUE) +
  labs(
    title = "Heatmap of Respondent Understanding by Age Group and Country",
    x = "Country",
    y = "Age Group"
  ) +
  scale_fill_gradient(low = "blue", high = "pink") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))




# 7. Ridgeline Plot of Interviewer Age by Question Clarification Level
#   This visualization helps understand the distribution of interviewer age across different levels of question clarification.
library(ggridges)
ggplot(analysis_data, aes(x = interviewer_age, y = as.factor(question_clarification), fill = ..x..)) +
  geom_density_ridges_gradient() +
  scale_fill_viridis_c() +
  labs(
    title = "Ridgeline Plot of Interviewer Age by Question Clarification Level",
    x = "Interviewer Age",
    y = "Question Clarification Level"
  ) +
  theme_minimal()





# 9. Bar Plot of Interference Frequency by Respondent Tried Best
#   A bar plot showing how interference types relate to respondents trying their best.
ggplot(analysis_data, aes(x = respondent_tried_best, fill = as.factor(interference_present))) +
  geom_bar(position = "fill") +
  labs(
    title = "Bar Plot of Interference Frequency by Respondent Tried Best",
    x = "Respondent Tried Best",
    y = "Proportion",
    fill = "Interference Present"
  ) +
  theme_minimal() +
  scale_fill_brewer(palette = "Paired")


