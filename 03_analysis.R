# 03_analysis.R
# Table 1, logistic regression, and forest plot

library(tableone)
library(broom)
library(ggplot2)
library(dplyr)

# ── Table 1 ───────────────────────────────────────────────────────────────────

vars     <- c("RIDAGEYR", "gender", "race", "DMDEDUC2",
              "INDFMPIR", "BMXBMI", "BMXWAIST",
              "BPXSY1", "BPXDI1", "LBXGLU", "LBXGH")
cat_vars <- c("gender", "race", "DMDEDUC2")

table1 <- CreateTableOne(
  vars       = vars,
  strata     = "diabetes",
  data       = data_clean,
  factorVars = cat_vars
)

print(table1, showAllLevels = TRUE, quote = FALSE, noSpaces = TRUE)

# ── Logistic regression ───────────────────────────────────────────────────────

model <- glm(
  diabetes ~ RIDAGEYR + gender + race + DMDEDUC2 +
    INDFMPIR + BMXBMI + BMXWAIST + BPXSY1,
  data   = data_clean,
  family = binomial(link = "logit")
)

summary(model)

# ── Odds ratios with 95% CI ───────────────────────────────────────────────────

or_table <- tidy(model, exponentiate = TRUE, conf.int = TRUE) %>%
  filter(term != "(Intercept)") %>%
  filter(!grepl("Refused|Don't know", term))

or_table_labeled <- or_table %>%
  mutate(term = recode(term,
                       "RIDAGEYR"                                                   = "Age (years)",
                       "BMXWAIST"                                                   = "Waist circumference (cm)",
                       "BMXBMI"                                                     = "BMI (kg/m²)",
                       "BPXSY1"                                                     = "Systolic blood pressure",
                       "INDFMPIR"                                                   = "Income-to-poverty ratio",
                       "genderFemale"                                               = "Female (vs Male)",
                       "raceOther Hispanic"                                         = "Race: Other Hispanic",
                       "raceNon-Hispanic White"                                     = "Race: Non-Hispanic White",
                       "raceNon-Hispanic Black"                                     = "Race: Non-Hispanic Black",
                       "raceNon-Hispanic Asian"                                     = "Race: Non-Hispanic Asian",
                       "raceOther Race - Including Multi-Racial"                    = "Race: Other/Multi-Racial",
                       "DMDEDUC29-11th grade (Includes 12th grade with no diploma)" = "Education: 9-11th grade",
                       "DMDEDUC2High school graduate/GED or equivalent"             = "Education: High school/GED",
                       "DMDEDUC2Some college or AA degree"                          = "Education: Some college",
                       "DMDEDUC2College graduate or above"                          = "Education: College graduate+"
  ))

# ── OR table ─────────────────────────────────────────────────────────────────

or_table_labeled %>%
  select(term, estimate, conf.low, conf.high, p.value) %>%
  mutate(across(c(estimate, conf.low, conf.high), ~round(., 2)),
         p.value = round(p.value, 3)) %>%
  print(n = 20)

# ── Forest plot ───────────────────────────────────────────────────────────────

ggplot(or_table_labeled, aes(x = estimate, y = reorder(term, estimate))) +
  geom_point(size = 3, color = "#2c7bb6") +
  geom_errorbarh(aes(xmin = conf.low, xmax = conf.high), height = 0.3) +
  geom_vline(xintercept = 1, linetype = "dashed", color = "red") +
  labs(
    title    = "Odds Ratios for Type 2 Diabetes Risk Factors",
    subtitle = "Logistic regression · NHANES 2017–2018 · n = 3,768",
    x        = "Odds Ratio (95% CI)",
    y        = ""
  ) +
  theme_bw(base_size = 12)


