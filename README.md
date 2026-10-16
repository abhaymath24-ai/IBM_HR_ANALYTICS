# IBM HR Employee Attrition & Retention Prediction Dashboard

An end-to-end People Analytics solution combining SQL data exploration, machine learning risk modeling, and an interactive 3-page Power BI executive dashboard to identify key attrition drivers and prioritize retention interventions.

---

## 📌 Project Overview
Employee turnover creates significant operational friction, domain knowledge loss, and replacement costs. This project analyzes the IBM HR Analytics dataset to uncover why employees leave, evaluate structural retention drivers, and present a decision-support dashboard for HR leadership to take proactive action.

### Key Objectives:
- Identify primary demographic, compensation, and workplace factors driving employee turnover.
- Quantify turnover patterns across job roles, tenure groups, and overtime demands.
- Deliver an interactive, decision-oriented dashboard for operational monitoring and targeted HR intervention.

---

## 📊 Dashboard Architecture & Preview

### 1. Employee Attrition Overview
> High-level executive monitoring tracking overall headcount, active attrition rates, and demographic breakdowns across roles and age groups.
![Employee Attrition Overview](Screenshot%202026-10-16%20154638.png)

### 2. What Drives Attrition
> Deep dive into structural factors influencing turnover, highlighting critical patterns across Overtime, Income, Tenure, and Travel.
![What Drives Attrition](Screenshot%202026-10-16%20154821.png)

### 3. Risk Predictions & Action Planning
> Action-oriented decision support interface displaying predicted risk segments and a targeted HR action list for high-risk active employees.
![Risk Predictions](Screenshot%202026-10-16%20154907.png)

---

## 🔍 Key Analytical Insights
- **The Overtime Impact**: Employees working frequent overtime experience an attrition rate nearly **3x higher** than those who do not (30.5% vs. 10.4%).
- **Tenure Vulnerability**: Attrition is heavily concentrated in early career tenures, with the steepest turnover occurring within the first **0–2 years (30%)** before stabilizing sharply after year 3.
- **Role & Travel Sensitivity**: Roles with frequent travel and frontline operational demands (such as Sales Representatives at 40% and Laboratory Technicians at 24%) show disproportionately elevated departure rates.
- **Actionable Prioritization**: Segmenting staff by predicted risk levels enables HR to focus retention conversations, workload rebalancing, and compensation reviews directly on the highest-risk cohorts.

---

## 📂 Repository Contents
- **`IBM_HR_ANALYSIS.pbix`**: Interactive 3-page Power BI dashboard report.
- **`IBM_HR_QUERIES_SQL.sql`**: SQL scripts used for data extraction, KPI aggregation, and cohort analysis.
- **`IBM_HR_Project_EDA.pdf`**: Exploratory data analysis documenting distributions, correlations, and initial findings.
- **`IBM_HR_Attrition_Business_Report.pdf`**: Comprehensive business case report detailing strategic recommendations.
- **`IBM_HR_Attrition_Professional_Presentation.pptx`**: Executive-ready presentation deck summarizing key outcomes.

---

## 🛠️ Tools & Technologies
- **Business Intelligence**: Microsoft Power BI (DAX, Data Modeling, Custom UI/UX design)
- **Database & Querying**: SQL (Aggregations, Window Functions, Filtering)
- **Exploratory Data Analysis**: Python (`pandas`, `matplotlib`, `seaborn`)
- **Documentation & Reporting**: Microsoft PowerPoint & Executive Business Reports

---

## 🚀 How to Explore This Project

1. **Clone the repository**:
   ```bash
   git clone [https://github.com/abhaymath24-ai/IBM_HR_ANALYTICS.git](https://github.com/abhaymath24-ai/IBM_HR_ANALYTICS.git)
