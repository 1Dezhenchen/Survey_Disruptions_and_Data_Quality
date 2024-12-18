# Factors Influencing Respondent Comprehension in Social Survey Interviews

## Overview

The repository contains a study that examines the factors influencing respondent comprehension during social survey interviews.
The focus of this study is on understanding how different forms of interference—such as partner, child, or relative involvement—affect respondents' ability to accurately process interview questions.
Additionally, the study explores how various interview methods and interviewer characteristics impact comprehension.
The repository includes all necessary scripts for data preparation, model analysis, and result visualization, along with detailed steps for reproducibility.
## File Structure

The repo is structured as follows: 
- **data/00-simulated_data**: Contains simulated datasets created to test and validate the modeling pipeline. These datasets mimic realistic survey conditions and include disruptions, respondent demographics, and other relevant variables.
- **data/01-raw_data**: Contains the raw dataset from the European Social Survey, including data on respondent demographics and interview circumstances.
- **data/02-clean_data**: Contains the cleaned dataset, prepared for analysis after performing variable recoding and addressing missing values.
- **model**: Includes fitted Bayesian logistic regression models that examine respondent comprehension.
- **paper**: Contains the Quarto files used for generating the paper, along with all references and supplementary materials.
- **scripts**: Contains R scripts for data cleaning, model fitting, diagnostics, and visualization.
- **reports**: Includes reports and diagnostic plots that summarize the model checks and posterior predictive checks conducted during the study.

## Statement on LLM Usage
The ChatGPT-4 model contributed to data validation, test creation, data cleaning,build model , plot creation, and providing descriptions and annotations for visualizations, along with offering recommendations and perspectives on model design. The entire chat history is available in other/llm_usage/usage.txt.
