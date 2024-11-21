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
library(janitor)

#### Simulate data ####
# Set seed for reproducibility
set.seed(42)

# Define the number of observations
num_obs <- 1000

# Create a tibble with simulated data for interviews
simulated_interview_data <- tibble(
  # Simulate interview condition (how it was conducted)
  vdcond = sample(c("face-to-face", "telephone", "online"), 
                  num_obs, replace = TRUE),
  
  # Simulate respondent's willingness to answer (1: willing, 2: reluctant)
  resrelq = sample(1:2, num_obs, replace = TRUE),
  
  # Simulate whether there were any interferences during the interview
  preinf = sample(c("none", "spouse", "child", "parent", "other"), 
                  num_obs, replace = TRUE),
  
  # Simulate respondent's age
  intagea = sample(18:80, num_obs, replace = TRUE),
  
  # Simulate respondent's gender
  intgndr = sample(c("male", "female"), num_obs, replace = TRUE),
  
  # Simulate whether the respondent understood the question (1: yes, 0: no)
  resundq = sample(0:1, num_obs, replace = TRUE),
  
  # Simulate if respondent tried to answer questions to the best of ability (1: yes, 0: no)
  resbab = sample(0:1, num_obs, replace = TRUE),
  
  # Simulate the production date of the data
  proddate = sample(seq(as.Date('2022-01-01'), as.Date('2024-12-31'), by="day"), num_obs, replace = TRUE),
  
  # Simulate the country conducting the interview
  cntry = sample(c("AT", "BE", "CH", "DE", "DK", "ES", "FI", "FR", "GB", "IE", "IT", "NL", "NO", "PT", "SE"), 
                 num_obs, replace = TRUE),
  
  # Simulate the respondent's identification number
  idno = sample(10000:99999, num_obs, replace = TRUE),
  
  # Simulate if anyone interfered with the interview (1: yes, 0: no)
  prewhp = sample(0:1, num_obs, replace = TRUE),
  presd = sample(0:1, num_obs, replace = TRUE),
  preppil = sample(0:1, num_obs, replace = TRUE),
  preorel = sample(0:1, num_obs, replace = TRUE),
  prenrel = sample(0:1, num_obs, replace = TRUE),
  predk = sample(0:1, num_obs, replace = TRUE),
  prenap = sample(0:1, num_obs, replace = TRUE),
  prena = sample(0:1, num_obs, replace = TRUE),
  
  # Simulate interview questionnaire language
  intlnga = sample(c("ENG", "GER", "FRE", "SPA", "ITA", "NOR"), num_obs, replace = TRUE),
  
  # Simulate interviewer's identification number
  intnum = sample(1000:9999, num_obs, replace = TRUE)
)

#### Save data ####
# Define the correct folder inside starter_folder-main 2
output_folder <- "starter_folder-main 2/data/00-simulated_data"

# Create the folder if it doesn't exist
if (!dir.exists(output_folder)) {
  dir.create(output_folder, recursive = TRUE)
}

# Save the data to the correct location
write_csv(simulated_interview_data, file.path(output_folder, "simulated_interview_data.csv"))






