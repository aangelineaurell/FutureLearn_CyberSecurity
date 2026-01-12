
# =====================================================
# 02_clean_learners.R
# Purpose: to clean participant data (learners only)
# =====================================================

library(dplyr)


# Summary of team composition
team_summary <- team_members %>%
  count(run, team_role, user_role, sort = TRUE)

# Team ID to be excluded from participant analysis
team_ids <- team_members %>%
  distinct(run, id)

# Clean enrolments: keep learners only & remove team members
enrolments_clean <- enrolments %>%
  anti_join(team_ids, by = c("run" = "run", "learner_id" = "id")) %>%  # remove team (run-specific)
  filter(role == "learner") %>%                                        # keep learners only
  mutate(
    country = na_if(country, "Unknown"),
    age_range = na_if(age_range, "Unknown"),
    highest_education_level = na_if(highest_education_level, "Unknown")
  )

