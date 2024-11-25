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
library(dplyr)


# Load the dataset
analysis_data <- read_csv("data/02-analysis_data/analysis_data.csv")

# Set theme for better aesthetics
theme_set(theme_minimal())



# Plot  Interviewer Age Density by Top 5 Countries
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








#  Heatmap of Respondent Understanding by Age Group and Country
#   Shows patterns of understanding among respondents across different age groups and countries.

analysis_data <- analysis_data %>%
  filter(!is.na(interviewer_age), !is.na(country), !is.na(respondent_understood)) %>%
  mutate(age_group = cut(interviewer_age, breaks = c(10, 20, 30, 40, 50, 60, 70, 80, 90), include.lowest = TRUE))


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




#  Ridgeline Plot of Interviewer Age by Question Clarification Level
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





# Bar Plot of Interference Frequency by Respondent Tried Best

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



ggplot(analysis_data, aes(x = respondent_tried_best, fill = respondent_understood_binary)) +
  geom_bar(position = "fill") +
  scale_fill_manual(values = c("#619CFF", "#F8766D")) +
  labs(
    title = "Bar Plot of Response Understanding by Respondent Tried Best",
    x = "Respondent Tried Best",
    y = "Proportion",
    fill = "Response Understanding"
  ) +
  theme_minimal()


