---
output:
  html_document: default
  pdf_document: default
---


######################
## FutureLearn_CyberSecurity ##
######################

# FutureLearn Cyber Security Retention Analysis
# Author: Angeline Aurel Efendy
# Date: 11th January 2026

# This project analyses learner engagement, retention, and dropout
# patterns in the FutureLearn Cyber Security course (Runs 6 and 7)
# using the CRISP-DM framework.

# The analysis is aimed at course designers, educators, and platform
# stakeholders who want to understand when learners disengage and
# which factors are associated with early dropout in online courses.

# The main research questions are:
# Cycle 1: When do learners drop out, and what are the overall
#          engagement and retention patterns?
# Cycle 2: What factors are associated with early dropout, based on
#          leaving survey responses and weekly sentiment data?

########################
## DATA DESCRIPTION  ##
########################
# The project uses learning analytics data from the FutureLearn
# Cyber Security course (Runs 6 and 7). The raw datasets include:
# - Enrolment data (learner demographics and roles)
# - Step activity logs (learner engagement over weeks)
# - Team member data (used to exclude non-learners)
# - Leaving survey responses (reasons for leaving)
# - Weekly sentiment survey responses (experience ratings)

# Raw data are stored in the 'data' folder in CSV format.
# Processed and analysis-ready datasets are written to
# 'data/processed' by the munging scripts.

###################
## PROJECT SETUP ##
###################
# This project uses the ProjectTemplate system.
# The user must have R and RStudio installed, along with the
# following R packages:
# tidyverse, dplyr, readr, knitr, kableExtra, ProjectTemplate

# All raw data should be placed in the 'data' folder.
# Project settings are controlled via the 'config/global.dcf' file.
# The 'munge' folder contains scripts that clean and prepare the data.
# If the munging scripts are unchanged, 'munging' can be set to FALSE
# to speed up project loading.
 
#######################
## PROJECT EXECUTION ##
#######################
# To reproduce the analysis:
# 1. Open the R Markdown file
#    'FutureLearn_Cyber_Security_Retention_Analysis.Rmd'
#    located in the 'reports' folder.
# 2. Set the working directory to the 'reports' folder.
# 3. Click 'Knit' in RStudio.

# This will run the preprocessing pipeline, execute the analysis,
# and produce the final report in HTML and PDF formats.
 
###################
## DIRECTORY MAP ##
###################
   # - cache
   ##     Stores cached data loaded by ProjectTemplate.
   # - config
   ##     Contains global.dcf for project configuration.
   # - data
   ##     Raw course data and processed outputs.
   # - data/processed
   ##     Cleaned and aggregated datasets for analysis.
   # - munge
   ##     R scripts for data loading, cleaning, and feature creation.
   # - reports
   ##     R Markdown file and knitted report outputs.
   # - logs
   ##     (Unused)
   # - src
   ##     (Unused)
   # - tests
   ##     (Unused)
