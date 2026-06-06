# Diabetes Risk Factor Analysis Using Logistic Regression (NHANES 2017–2018)

## Objective
This project investigates risk factors associated with Type 2 diabetes 
using real-world data from the National Health and Nutrition Examination 
Survey (NHANES 2017–2018). A logistic regression model was built to 
identify demographic, anthropometric, and socioeconomic predictors of 
diabetes status among U.S. adults.

## Methods
- Data loading and merging from multiple NHANES modules via `nhanesA` R package
- Exploratory Data Analysis (EDA) and missing data inspection
- Table 1 — descriptive statistics stratified by diabetes status
- Logistic regression with odds ratio (OR) estimation
- Forest plot visualization of OR with 95% CI

## Technologies
- R
- nhanesA
- tableone
- tidyverse
- ggplot2
- broom

## Dataset
Data were obtained directly from the CDC NHANES 2017–2018 survey using 
the `nhanesA` R package. The following modules were used:

| Module | Code | Contents |
|---|---|---|
| Diabetes | `DIQ_J` | Diabetes diagnosis |
| Demographics | `DEMO_J` | Age, sex, race, education, income |
| Fasting glucose | `GLU_J` | Fasting plasma glucose |
| HbA1c | `GHB_J` | Glycated haemoglobin |
| Body measures | `BMX_J` | BMI, waist circumference |
| Blood pressure | `BPX_J` | Systolic and diastolic BP |

Source: [CDC NHANES 2017–2018](https://wwwn.cdc.gov/nchs/nhanes/continuousnhanes/default.aspx?BeginYear=2017)

## Key Results

- **Age** was significantly associated with increased diabetes risk
  (OR = 1.06 per year, 95% CI: 1.06–1.07, p < 0.001).
- **Waist circumference** was the strongest anthropometric predictor
  (OR = 1.06 per cm, 95% CI: 1.05–1.08, p < 0.001).
- **Non-Hispanic Asian** participants had significantly higher odds of diabetes
  compared to Mexican American (OR = 1.76, 95% CI: 1.18–2.62, p = 0.006).
- **Non-Hispanic White** participants had lower odds of diabetes
  (OR = 0.51, 95% CI: 0.37–0.72, p < 0.001).
- **Higher education** was consistently protective: college graduates had 59%
  lower odds compared to those with less than 9th grade education
  (OR = 0.41, 95% CI: 0.27–0.63, p < 0.001).
- **BMI** was significant but weaker than waist circumference
  (OR = 0.96, p = 0.029), suggesting central adiposity matters more than
  overall body weight.
- **Gender, income, and systolic blood pressure** were not significantly
  associated after full covariate adjustment.

## Interpretation

The forest plot reveals that waist circumference and age are the most 
consistent predictors of Type 2 diabetes risk, each associated with a 6% 
increase in odds per unit. Non-Hispanic Asian participants showed nearly 
twice the odds of diabetes compared to the reference group (Mexican 
American), while Non-Hispanic White participants had significantly lower 
odds (OR = 0.51). Higher educational attainment was consistently 
protective, with college graduates showing 59% lower odds than those with 
less than 9th grade education. Notably, BMI was significant but weaker 
than waist circumference, suggesting that central adiposity is a more 
relevant indicator than overall body weight. Gender, income-to-poverty 
ratio, and systolic blood pressure were not independently associated with 
diabetes after full covariate adjustment.

## Forest Plot

![Forest Plot](outputs/figures/forest_plot.png)

## Variable Description

| Variable | Description |
|---|---|
| `RIDAGEYR` | Age at examination (years) |
| `RIAGENDR` | Sex (Male / Female) |
| `RIDRETH3` | Race/ethnicity |
| `DMDEDUC2` | Education level (adults 20+) |
| `INDFMPIR` | Income-to-poverty ratio |
| `BMXBMI` | Body Mass Index (kg/m²) |
| `BMXWAIST` | Waist circumference (cm) |
| `BPXSY1` | Systolic blood pressure (mmHg) |
| `LBXGLU` | Fasting plasma glucose (mg/dL) |
| `LBXGH` | Glycated haemoglobin HbA1c (%) |
| `DIQ010` | Ever told you have diabetes (Yes/No) |
| `diabetes` | Binary outcome: 1 = diabetes, 0 = no diabetes |

## Limitations

- The dataset is observational; causal conclusions cannot be drawn.
- 1,242 observations were excluded due to missing values in key variables.
- Glucose and HbA1c were not included in the regression model due to high 
  missingness; they are presented descriptively in Table 1 only.
- The analysis uses unweighted regression and does not account for the 
  complex survey design of NHANES (sampling weights, PSU, strata).
- Results reflect the U.S. adult population in 2017–2018 and may not 
  generalise to other populations or time periods.

## How to Run

### 1. Clone the repository
```bash
git clone https://github.com/shilina-biostat/diabetes-risk-nhanes.git
cd diabetes-risk-nhanes
```

### 2. Install required R packages
```r
install.packages(c("nhanesA", "tidyverse", "tableone", "ggplot2", "broom"))
```

### 3. Run the scripts in order
```r
source("scripts/01_data_loading.R")
source("scripts/02_data_cleaning.R")
source("scripts/03_analysis.R")
```
Output figures will be saved to `figures/`.

## Repository Structure

```
scripts/
├── 01_data_loading.R
├── 02_data_cleaning.R
└── 03_analysis.R
outputs/
└── figures/
    └── forest_plot_logistic.png
README.md
```
