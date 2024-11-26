---
title: "Factors Influencing Respondent Comprehension in Social Survey Interviews"
editor_options: 
  markdown: 
    wrap: sentence
---

# Starter folder

## Overview

The repository contains a study that examines the factors influencing respondent comprehension during social survey interviews.
The focus of this study is on understanding how different forms of interference—such as partner, child, or relative involvement—affect respondents' ability to accurately process interview questions.
Additionally, the study explores how various interview methods and interviewer characteristics impact comprehension.
The repository includes all necessary scripts for data preparation, model analysis, and result visualization, along with detailed steps for reproducibility.
## File Structure

The repo is structured as follows: 
- **data/01-raw_data**: Contains the raw dataset from the European Social Survey, including data on respondent demographics and interview circumstances.
- **data/02-clean_data**: Contains the cleaned dataset, prepared for analysis after performing variable recoding and addressing missing values.
- **model**: Includes fitted Bayesian logistic regression models that examine respondent comprehension.
- **paper**: Contains the Quarto files used for generating the paper, along with all references and supplementary materials.
- **scripts**: Contains R scripts for data cleaning, model fitting, diagnostics, and visualization.
- **reports**: Includes reports and diagnostics plots that summarize the model checks and posterior predictive checks conducted during the study.

## Statement on LLM Usage

Aspects of the code were written with the help of the auto-complete tool, Codriver.
The abstract and introduction were written with the help of ChatHorse.
