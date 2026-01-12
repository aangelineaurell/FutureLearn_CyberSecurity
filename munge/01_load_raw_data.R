

# =====================================================
# 01_load_raw_data.R
# Purpose: to load all FutureLearn Cyber Security raw data (Course 6 & 7)
# =====================================================

library(readr)

enrolments_6 <- read_csv("data/cyber-security-6_enrolments.csv", show_col_types = FALSE)
enrolments_7 <- read_csv("data/cyber-security-7_enrolments.csv", show_col_types = FALSE)

step_activity_6 <- read_csv("data/cyber-security-6_step-activity.csv", show_col_types = FALSE)
step_activity_7 <- read_csv("data/cyber-security-7_step-activity.csv", show_col_types = FALSE)

leaving_survey_6 <- read_csv("data/cyber-security-6_leaving-survey-responses.csv", show_col_types = FALSE)
leaving_survey_7 <- read_csv("data/cyber-security-7_leaving-survey-responses.csv", show_col_types = FALSE)

weekly_sentiment_6 <- read_csv("data/cyber-security-6_weekly-sentiment-survey-responses.csv", show_col_types = FALSE)
weekly_sentiment_7 <- read_csv("data/cyber-security-7_weekly-sentiment-survey-responses.csv", show_col_types = FALSE)

team_members_6 <- read_csv("data/cyber-security-6_team-members.csv", show_col_types = FALSE)
team_members_7 <- read_csv("data/cyber-security-7_team-members.csv", show_col_types = FALSE)

enrolments <- bind_rows(
  enrolments_6 %>% mutate(run = 6),
  enrolments_7 %>% mutate(run = 7)
)

step_activity <- bind_rows(
  step_activity_6 %>% mutate(run = 6),
  step_activity_7 %>% mutate(run = 7)
)

leaving_survey <- bind_rows(
  leaving_survey_6 %>% mutate(run = 6),
  leaving_survey_7 %>% mutate(run = 7)
)

weekly_sentiment <- bind_rows(
  weekly_sentiment_6 %>% mutate(run = 6),
  weekly_sentiment_7 %>% mutate(run = 7)
)

team_members <- bind_rows(
  team_members_6 %>% mutate(run = 6),
  team_members_7 %>% mutate(run = 7)
)
