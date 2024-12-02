#### Preamble ####
# Purpose: Simulates a dataset to explore potential patterns and values for analysis of the influence of interview disruptions on survey data quality.
# Author: Dezhen Chen
# Date: 26 November 2024
# Contact: dezhen.chen@mail.utoronto.ca
# License: MIT
# Pre-requisites: The `tidyverse` package must be installed
# Any other information needed? Make sure you are in the `The-Influence-of-Interview-Disruptions-on-Respondent-Data-Quality-in-Social-Surveys` rproj

#### Workspace setup ####
library(tidyverse)
library(janitor)

#### Simulate full data with interactions ####
# Set seed for reproducibility
set.seed(42)

# Define the number of observations
num_obs <- 1000

# Create a tibble with simulated data
simulated_interview_data <- tibble(
  # Simulate respondent's gender (1: male, 2: female)
  intgndr = sample(c(1, 2), num_obs, replace = TRUE),
  
  # Simulate respondent's age based on gender
  intagea = ifelse(
    intgndr == 1,
    round(rnorm(num_obs, mean = 50, sd = 10)), # Males: mean 50, sd 10
    round(rnorm(num_obs, mean = 45, sd = 12))  # Females: mean 45, sd 12
  ),
  
  # Simulate interview condition (depends on age group)
  vdcond = ifelse(
    intagea < 40,
    sample(c("online", "telephone"), num_obs, replace = TRUE, prob = c(0.7, 0.3)),
    sample(c("face-to-face", "telephone"), num_obs, replace = TRUE, prob = c(0.6, 0.4))
  ),
  
  # Simulate respondent's willingness to answer (depends on age and gender)
  resclq = ifelse(
    intgndr == 1 & intagea > 50,
    sample(1:3, num_obs, replace = TRUE, prob = c(0.2, 0.5, 0.3)), # Male and older
    sample(1:3, num_obs, replace = TRUE, prob = c(0.5, 0.3, 0.2))  # Others
  ),
  
  # Simulate production date
  proddate = sample(seq(as.Date('2022-01-01'), as.Date('2024-12-31'), by = "day"), num_obs, replace = TRUE),
  
  # Simulate country conducting the interview
  cntry = sample(c("AT", "BE", "CH", "DE", "DK", "ES", "FI", "FR", "GB", "IE", "IT", "NL", "NO", "PT", "SE"), 
                 num_obs, replace = TRUE),
  
  # Simulate respondent's identification number
  idno = sample(10000:99999, num_obs, replace = TRUE),
  
  # Simulate if there was interference during the interview
  prewhp = sample(0:1, num_obs, replace = TRUE, prob = c(0.8, 0.2)),
  presd = sample(0:1, num_obs, replace = TRUE, prob = c(0.9, 0.1)),
  preppil = sample(0:1, num_obs, replace = TRUE, prob = c(0.85, 0.15)),
  preorel = sample(0:1, num_obs, replace = TRUE, prob = c(0.9, 0.1)),
  prenrel = sample(0:1, num_obs, replace = TRUE, prob = c(0.7, 0.3)),
  predk = sample(0:1, num_obs, replace = TRUE, prob = c(0.95, 0.05)),
  prenap = sample(0:1, num_obs, replace = TRUE, prob = c(0.6, 0.4)),
  prena = sample(0:1, num_obs, replace = TRUE, prob = c(0.8, 0.2)),
  
  # Simulate understanding of the question (depends on willingness and condition)
  resundq = ifelse(
    vdcond == "face-to-face" & resclq == 1,
    1, # Face-to-face and most willing
    sample(0:1, num_obs, replace = TRUE, prob = c(0.4, 0.6))
  ),
  
  # Simulate effort to answer (depends on understanding)
  resbab = ifelse(
    resundq == 1,
    sample(0:1, num_obs, replace = TRUE, prob = c(0.3, 0.7)), # Tried harder if understood
    sample(0:1, num_obs, replace = TRUE, prob = c(0.7, 0.3))
  ),
  
  # Simulate interview language (depends on country)
  intlnga = ifelse(
    cntry %in% c("DE", "AT", "CH"), "GER",
    ifelse(cntry %in% c("FR", "BE"), "FRE",
           ifelse(cntry %in% c("ES", "PT"), "SPA", "ENG"))
  ),
  
  # Simulate interviewer's identification number
  intnum = sample(1000:9999, num_obs, replace = TRUE)
)

#### Save data ####
# Define the output folder
output_folder <- "starter_folder-main 2/data/00-simulated_data"

# Create the folder if it doesn't exist
if (!dir.exists(output_folder)) {
  dir.create(output_folder, recursive = TRUE)
}


# Save the data to the correct location
write_csv(simulated_interview_data, file.path(output_folder, "simulated_interview_data.csv"))






