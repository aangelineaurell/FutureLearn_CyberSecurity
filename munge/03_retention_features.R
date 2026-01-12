
# =====================================================
# 03_retention_features.R
# Purpose: create participant engagement & retention features (cycle 1)
# =====================================================

library(dplyr)
library(readr)


# 1.Summarize activities per learner (based on step_activity)
learner_summary <- step_activity %>%
  group_by(run, learner_id) %>%
  summarise(
    started_course = any(!is.na(first_visited_at)),
    steps_completed = sum(!is.na(last_completed_at)),
    max_week_completed = ifelse(
      steps_completed == 0, NA,
      max(week_number[!is.na(last_completed_at)], na.rm = TRUE)
    ),
    .groups = "drop"
  )

# 2.Combine with enrollments_clean to have one row per learner
retention_data <- enrolments_clean %>%
  select(run, learner_id, country, age_range, highest_education_level) %>%
  left_join(learner_summary, by = c("run","learner_id")) %>%
  mutate(
    started_course = ifelse(is.na(started_course), FALSE, started_course),
    steps_completed = ifelse(is.na(steps_completed), 0, steps_completed)
  )

# 3.Drop-offs per week
#Definition of drop-off: last completed week (NA -> 0 = did not complete anything)
dropoff_by_week <- retention_data %>%
  filter(started_course) %>%
  mutate(last_week = ifelse(is.na(max_week_completed), 0, max_week_completed)) %>%
  count(run, last_week, name = "n_learners") %>%
  arrange(run, last_week)

# Save processed outputs (for report)
dir.create("data/processed", showWarnings = FALSE)
write_csv(retention_data, "data/processed/retention_data.csv")
write_csv(dropoff_by_week, "data/processed/dropoff_by_week.csv")
