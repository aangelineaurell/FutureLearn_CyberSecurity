
# =====================================================
# 04_leaving_and_sentiment.R
# Purpose: Cycle 2 analysis dataset:
# 1) Individual-level: leaving reasons vs early dropout
# 2) Weekly-level: weekly sentiment vs drop-off counts
# =====================================================

library(dplyr)
library(readr)

# -----------------------------------------------------
# A) INDIVIDUAL-LEVEL: leaving survey vs early dropout
# -----------------------------------------------------

# 1.Create "last_week" and "early_dropout" from retention_data (Cycle 1 output)
# Definition: early dropout = stops at week 0 or week 1
retention_cycle2 <- retention_data %>%
  mutate(
    last_week = ifelse(is.na(max_week_completed), 0, max_week_completed),
    early_dropout = case_when(
      started_course & last_week <= 1 ~ "Early",
      started_course & last_week > 1  ~ "Later",
      TRUE                            ~ "Not started"
    )
  )
#Early: started the course but dropped out in week 0–1
#Later: started the course and stayed longer (beyond week 1)
#Not started: never started the course (started_course = FALSE)


# 2.Combine leaving surveys with retention
cycle2_individual <- retention_cycle2 %>%
  left_join(leaving_survey, by = c("run", "learner_id"))
#lots of NA : That is normal and not an error. 
#Many NAs appear because most learners did not complete the leaving survey.


# 3.Summarize the reasons for early_dropout vs. later_dropouts
leaving_reason_by_dropout <- cycle2_individual %>%
  filter(early_dropout %in% c("Early","Later")) %>%
  filter(!is.na(leaving_reason)) %>%
  count(run, early_dropout, leaving_reason, name = "n") %>%
  group_by(run, early_dropout) %>%
  mutate(prop = n / sum(n)) %>%
  ungroup() %>%
  arrange(early_dropout, desc(n))


# -----------------------------------------------------
# B) WEEKLY-LEVEL: weekly sentiment vs drop-off
# -----------------------------------------------------


# 4.Summarize weekly sentiment per week
# (weekly_sentiment does NOT have a learner_id, so it can only be per week)
sentiment_by_week <- weekly_sentiment %>%
  group_by(run, week_number) %>%
  summarise(
    avg_sentiment = mean(experience_rating, na.rm = TRUE),
    n_responses = n(),
    .groups = "drop"
  )

# 5.Weekly drop-offs from Cycle 1 (dropoff_by_week)
dropoff_weekly <- dropoff_by_week %>%
  rename(week_number = last_week)

# 6.Combine sentiment per week with drop-off counts per week
cycle2_weekly <- sentiment_by_week %>%
  left_join(dropoff_weekly, by = c("run","week_number")) %>%
  mutate(n_learners = ifelse(is.na(n_learners), 0, n_learners)) %>%
  arrange(run, week_number)

# Save processed outputs (for report)
dir.create("data/processed", showWarnings = FALSE)
write_csv(cycle2_individual, "data/processed/cycle2_individual.csv")
write_csv(leaving_reason_by_dropout, "data/processed/leaving_reason_by_dropout.csv")
write_csv(cycle2_weekly, "data/processed/cycle2_weekly.csv")

# Output objects to be used in the report:
# cycle2_individual: combined retention + leaving data (per learner)
# leaving_reason_by_dropout: table of leaving reasons (Early vs. Later)
# sentiment_by_week: summary of sentiment per week
# cycle2_weekly: sentiment per week + drop-off per week
