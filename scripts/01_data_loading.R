# 01_data_loading.R
# Load NHANES 2017-2018 modules and merge into a single dataset

library(nhanesA)
library(dplyr)

# Load individual modules
demo    <- nhanes("DEMO_J")  # Demographics
diab    <- nhanes("DIQ_J")   # Diabetes questionnaire
glucose <- nhanes("GLU_J")   # Fasting plasma glucose
hba1c   <- nhanes("GHB_J")   # HbA1c
bmi     <- nhanes("BMX_J")   # Body measures
bp      <- nhanes("BPX_J")   # Blood pressure

# Merge all modules by participant ID (SEQN)
data <- demo %>%
  left_join(diab,    by = "SEQN") %>%
  left_join(glucose, by = "SEQN") %>%
  left_join(hba1c,   by = "SEQN") %>%
  left_join(bmi,     by = "SEQN") %>%
  left_join(bp,      by = "SEQN")


