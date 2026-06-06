# 02_data_cleaning.R
# Select relevant variables and clean the dataset

library(dplyr)

data_clean <- data %>%
  # Select relevant variables
  select(
    SEQN,
    RIAGENDR,   # Sex
    RIDAGEYR,   # Age
    RIDRETH3,   # Race/ethnicity
    DMDEDUC2,   # Education
    INDFMPIR,   # Income-to-poverty ratio
    DIQ010,     # Diabetes diagnosis
    LBXGLU,     # Fasting glucose
    LBXGH,      # HbA1c
    BMXBMI,     # BMI
    BMXWAIST,   # Waist circumference
    BPXSY1,     # Systolic blood pressure
    BPXDI1      # Diastolic blood pressure
  ) %>%
  # Adults only (20+)
  filter(RIDAGEYR >= 20) %>%
  # Keep only confirmed diabetes status
  filter(DIQ010 %in% c("Yes", "No")) %>%
  # Create binary outcome and factor variables
  mutate(
    diabetes = ifelse(DIQ010 == "Yes", 1, 0),
    gender   = factor(RIAGENDR, labels = c("Male", "Female")),
    race     = factor(RIDRETH3)
  ) %>%
  # Remove rows with missing BMI or outcome
  filter(!is.na(BMXBMI), !is.na(RIDAGEYR), !is.na(diabetes))

# Final sample
dim(data_clean)        # 5010 participants
table(data_clean$diabetes)  # 815 diabetes (16%) vs 4195 no diabetes (84%)

