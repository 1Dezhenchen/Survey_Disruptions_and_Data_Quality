#### Preamble ####
# Purpose: Tests the structure and validity of the simulated Australian 
  #electoral divisions dataset.
# Author: Rohan Alexander
# Date: 26 September 2024
# Contact: rohan.alexander@utoronto.ca
# License: MIT
# Pre-requisites: 
  # - The `tidyverse` package must be installed and loaded
  # - 00-simulate_data.R must have been run
# Any other information needed? Make sure you are in the `starter_folder` rproj


#### Test simulated interview data ####

library(tidyverse)
library(testthat)

# Load the simulated data for testing
output_folder <- "starter_folder-main 2/data/00-simulated_data"
simulated_data <- read_csv(file.path(output_folder, "simulated_interview_data.csv"))

# Test if the data was successfully loaded
test_that("dataset was successfully loaded", {
  expect_true(exists("simulated_data"))
})

# Check if the dataset has 1000 rows
test_that("dataset has 1000 rows", {
  expect_equal(nrow(simulated_data), 1000)
})

# Check if the dataset has 20 columns
test_that("dataset has 20 columns", {
  expect_equal(ncol(simulated_data), 20)
})

# Check if there are no missing values in the dataset
test_that("dataset contains no missing values", {
  expect_true(all(!is.na(simulated_data)))
})

# Check if 'intagea' (age) is within a realistic range (e.g., 18 to 80)
test_that("'intagea' values are within the range 18 to 80", {
  expect_true(all(simulated_data$intagea >= 18 & simulated_data$intagea <= 80))
})

# Check if 'intgndr' contains only 'male' or 'female'
test_that("'intgndr' contains only 'male' or 'female'", {
  expect_true(all(simulated_data$intgndr %in% c("male", "female")))
})

# Check if 'resrelq' values are either 1 or 2
test_that("'resrelq' values are either 1 or 2", {
  expect_true(all(simulated_data$resrelq %in% c(1, 2)))
})

# Check if 'preinf' contains only valid interference types
test_that("'preinf' contains only valid interference types", {
  valid_interferences <- c("none", "spouse", "child", "parent", "other")
  expect_true(all(simulated_data$preinf %in% valid_interferences))
})

# Check if 'resundq' values are either 0 or 1
test_that("'resundq' values are either 0 or 1", {
  expect_true(all(simulated_data$resundq %in% c(0, 1)))
})

# Check if 'cntry' contains only valid country codes
test_that("'cntry' contains only valid country codes", {
  valid_countries <- c("AT", "BE", "CH", "DE", "DK", "ES", "FI", "FR", "GB", "IE", "IT", "NL", "NO", "PT", "SE")
  expect_true(all(simulated_data$cntry %in% valid_countries))
})

# Check if 'intlnga' contains only valid languages
test_that("'intlnga' contains only valid language codes", {
  valid_languages <- c("ENG", "GER", "FRE", "SPA", "ITA", "NOR")
  expect_true(all(simulated_data$intlnga %in% valid_languages))
})

# Check if 'intnum' is a 4-digit number
test_that("'intnum' is a 4-digit number", {
  expect_true(all(simulated_data$intnum >= 1000 & simulated_data$intnum <= 9999))
})
