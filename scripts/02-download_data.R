#### Preamble ####
# Purpose: Downloads and saves the data from [...UPDATE THIS...]
# Author: Rohan Alexander [...UPDATE THIS...]
# Date: 11 February 2023 [...UPDATE THIS...]
# Contact: rohan.alexander@utoronto.ca [...UPDATE THIS...]
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]


#### Workspace setup ####
library(tidyverse)

#### Load downloaded data ####
raw_data <- read_csv(
  file = "data/01-raw_data/raw_data.csv",
  show_col_types = TRUE
)

#### Save data ####
write_csv(raw_data, "data/01-raw_data/raw_data.csv")




         
