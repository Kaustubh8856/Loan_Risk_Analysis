# Loan_Risk_Analysis

---

## 🧮 Step-by-Step Workflow

### 1. 🧾 SQL Analysis
- Connected to the dataset using SQL.
- Executed queries to answer key business questions:
  - Total profile summary
  - Default rate by grade
  - Rate for long term months
  - Default rate by grade and term
  - Top states by default rate
  - Impact of DTI on default rate
  - Total recovery rate
  - Default rate by issue year
  - Average interest rate by purpose
  - Recovery amount by grade for defaults

### 2. 📈 Python Visualization
- Used `pandas`, `matplotlib`, and `seaborn` for data cleaning and visualization.
- Created boxplots, histograms, and scatter plots 

### 3. 📊 Power BI Dashboard
- Built an interactive dashboard with:
  - Executive KPIs (loan amount, defaults, interest rates)
  - State-wise breakdowns using maps and bar charts
  - Grade-wise comparisons of recovery and collection fees
  - Decomposition tree for default drivers
  - Slicers for dynamic filtering by grade, state, and date

---

## 📌 Key Insights

- High default rates correlate with lower FICO scores and higher DTI ratios.
- Certain states show disproportionately high loan volumes and defaults.
- Recovery and collection fees vary significantly across loan grades.
- Interest rates tend to increase with borrower risk profiles.

---

## 🛠️ Tools & Technologies

| Tool        | Purpose                          |
|-------------|----------------------------------|
| SQL         | Data extraction & business logic |
| Python      | Data cleaning & visualization    |
| Power BI    | Dashboard & KPI reporting        |
| GitHub      | Version control & sharing        |

---
