#### Preamble ####
# Purpose: Downloads and saves the interview response data for analysis from ESS DATA.
# Author: Dezhen Chen
# Date: 26 November 2024
# Contact: dezhen.chen@mail.utoronto.ca
# License: MIT
# Pre-requisites: The `tidyverse` package must be installed
# Any other information needed? Make sure you are in the `The-Influence-of-Interview-Disruptions-on-Respondent-Data-Quality-in-Social-Surveys` rproj


#### Workspace setup ####
library(tidyverse)

#### Load downloaded data ####
raw_data <- read_csv(
  file = "data/01-raw_data/raw_data.csv",
  show_col_types = TRUE
)

#### Save data ####
write_csv(raw_data, "data/01-raw_data/raw_data.csv")




         
