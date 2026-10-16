--1: Which job roles are losing the most people?
SELECT "JobRole",
       COUNT(*) AS total,
       SUM(CASE WHEN "Attrition" = 'Yes' THEN 1 ELSE 0 END) AS leavers,
       ROUND(100.0 * SUM(CASE WHEN "Attrition" = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 1) AS attrition_pct
FROM ibm_hr_project
GROUP BY "JobRole"
ORDER BY attrition_pct DESC;

--2: Which department has the highest attrition?
SELECT "Department",
       COUNT(*) AS total,
       SUM(CASE WHEN "Attrition" = 'Yes' THEN 1 ELSE 0 END) AS leavers,
       ROUND(100.0 * SUM(CASE WHEN "Attrition" = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 1) AS attrition_pct
FROM ibm_hr_project
GROUP BY "Department"
ORDER BY attrition_pct DESC;

--3: Do employees who leave earn less?
SELECT "Attrition",
       ROUND(AVG("MonthlyIncome"), 0) AS avg_income
FROM ibm_hr_project
GROUP BY "Attrition";

--4: Do stock options help keep employees?
SELECT "StockOptionLevel",
       COUNT(*) AS total,
       SUM(CASE WHEN "Attrition" = 'Yes' THEN 1 ELSE 0 END) AS leavers,
       ROUND(100.0 * SUM(CASE WHEN "Attrition" = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 1) AS attrition_pct
FROM ibm_hr_project
GROUP BY "StockOptionLevel"
ORDER BY "StockOptionLevel";

--5: How many current employees are at high risk (overtime + low income)?
SELECT COUNT(*) AS at_risk_employees
FROM ibm_hr_project
WHERE "Attrition" = 'No'
  AND "OverTime" = 'Yes'
  AND "MonthlyIncome" < 3000;

--6: Does overtime affect attrition?
SELECT "OverTime",
       COUNT(*) AS total,
       SUM(CASE WHEN "Attrition" = 'Yes' THEN 1 ELSE 0 END) AS leavers,
       ROUND(100.0 * SUM(CASE WHEN "Attrition" = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 1) AS attrition_pct
FROM ibm_hr_project
GROUP BY "OverTime";

--7: Which marital status group leaves the most?
SELECT "MaritalStatus",
       COUNT(*) AS total,
       ROUND(100.0 * SUM(CASE WHEN "Attrition" = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 1) AS attrition_pct
FROM ibm_hr_project
GROUP BY "MaritalStatus"
ORDER BY attrition_pct DESC;

--8: Does business travel affect attrition?
SELECT "BusinessTravel",
       COUNT(*) AS total,
       ROUND(100.0 * SUM(CASE WHEN "Attrition" = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 1) AS attrition_pct
FROM ibm_hr_project
GROUP BY "BusinessTravel"
ORDER BY attrition_pct DESC;

--9: Which job roles are paid the least on average?
SELECT "JobRole",
       ROUND(AVG("MonthlyIncome"), 0) AS avg_income
FROM ibm_hr_project
GROUP BY "JobRole"
ORDER BY avg_income ASC
LIMIT 7;

--10: How many employees left within their first 2 years?
SELECT COUNT(*) AS early_leavers
FROM ibm_hr_project
WHERE "Attrition" = 'Yes'
  AND "YearsAtCompany" <= 2;

--11: Which age group leaves the most? 
SELECT CASE
           WHEN "Age" <= 25 THEN '18-25'
           WHEN "Age" <= 35 THEN '26-35'
           WHEN "Age" <= 45 THEN '36-45'
           ELSE '46+'
       END AS age_group,
       COUNT(*) AS total,
       ROUND(100.0 * SUM(CASE WHEN "Attrition" = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 1) AS attrition_pct
FROM ibm_hr_project
GROUP BY age_group
ORDER BY age_group;

--12: Which income group leaves the most? 
SELECT CASE
           WHEN "MonthlyIncome" < 3000 THEN 'Low'
           WHEN "MonthlyIncome" < 7000 THEN 'Medium'
           ELSE 'High'
       END AS income_group,
       COUNT(*) AS total,
       ROUND(100.0 * SUM(CASE WHEN "Attrition" = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 1) AS attrition_pct
FROM ibm_hr_project
GROUP BY income_group
ORDER BY attrition_pct DESC;

--13: Which job roles have attrition above 20%? 
SELECT "JobRole",
       COUNT(*) AS total,
       ROUND(100.0 * SUM(CASE WHEN "Attrition" = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 1) AS attrition_pct
FROM ibm_hr_project
GROUP BY "JobRole"
HAVING 100.0 * SUM(CASE WHEN "Attrition" = 'Yes' THEN 1 ELSE 0 END) / COUNT(*) > 20
ORDER BY attrition_pct DESC;

--14: How many employees earn below the company average? (Subquery)
SELECT COUNT(*) AS below_avg_employees
FROM ibm_hr_project
WHERE "MonthlyIncome" < (SELECT AVG("MonthlyIncome") FROM ibm_hr_project);

--15: Attrition for employees below vs above the company average income 
SELECT CASE
           WHEN "MonthlyIncome" < (SELECT AVG("MonthlyIncome") FROM ibm_hr_project)
           THEN 'Below average income'
           ELSE 'Above average income'
       END AS income_position,
       COUNT(*) AS total,
       ROUND(100.0 * SUM(CASE WHEN "Attrition" = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 1) AS attrition_pct
FROM ibm_hr_project
GROUP BY income_position;

--16: Rank job roles by attrition 
SELECT "JobRole",
       ROUND(100.0 * SUM(CASE WHEN "Attrition" = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 1) AS attrition_pct,
       RANK() OVER (ORDER BY 100.0 * SUM(CASE WHEN 
	                 "Attrition" = 'Yes' THEN 1 ELSE 0 END) / COUNT(*) DESC) AS rank_no
FROM ibm_hr_project
GROUP BY "JobRole";

--17: Attrition by tenure group 
SELECT CASE
           WHEN "YearsAtCompany" <= 2 THEN '0-2 years'
           WHEN "YearsAtCompany" <= 5 THEN '3-5 years'
           WHEN "YearsAtCompany" <= 10 THEN '6-10 years'
           ELSE '10+ years'
       END AS tenure_group,
       COUNT(*) AS total,
       ROUND(100.0 * SUM(CASE WHEN "Attrition" = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 1) AS attrition_pct
FROM ibm_hr_project
GROUP BY tenure_group
ORDER BY attrition_pct DESC;

--18: Attrition by department and overtime together 
SELECT "Department", "OverTime",
       COUNT(*) AS total,
       ROUND(100.0 * SUM(CASE WHEN "Attrition" = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 1) AS attrition_pct
FROM ibm_hr_project
GROUP BY "Department", "OverTime"
ORDER BY attrition_pct DESC;

--21: How does each employee's income compare to their job role's average? 
SELECT "EmployeeNumber",
       "JobRole",
       "MonthlyIncome",
       ROUND(AVG("MonthlyIncome") OVER (PARTITION BY "JobRole"), 0) AS role_avg_income
FROM ibm_hr_project
ORDER BY "EmployeeNumber"
LIMIT 10;

--22: Who are the top 3 highest paid employees in each department? (ROW_NUMBER)
SELECT *
FROM (
    SELECT "Department",
           "EmployeeNumber",
           "MonthlyIncome",
           ROW_NUMBER() OVER (PARTITION BY "Department" ORDER BY "MonthlyIncome" DESC) AS row_no
    FROM ibm_hr_project
) AS ranked
WHERE row_no <= 3
ORDER BY "Department", row_no;


--Predictions
ALTER TABLE ibm_hr_project
ADD COLUMN "Leave_Probability" FLOAT,
ADD COLUMN "Risk_Level" VARCHAR(10),
ADD COLUMN "Pred_LogReg" VARCHAR(3),
ADD COLUMN "Pred_DecisionTree" VARCHAR(3),
ADD COLUMN "Pred_RandomForest" VARCHAR(3);

UPDATE ibm_hr_project h
SET "Leave_Probability" = p."Leave_Probability",
    "Risk_Level" = p."Risk_Level",
    "Pred_LogReg" = p."Pred_LogReg",
    "Pred_DecisionTree" = p."Pred_DecisionTree",
    "Pred_RandomForest" = p."Pred_RandomForest"
FROM hr_predictions p
WHERE h."EmployeeNumber" = p."EmployeeNumber";


--26: Do employees flagged "High risk" by the model actually leave more? (Is the model useful?)
SELECT "Risk_Level",
       COUNT(*) AS total,
       ROUND(100.0 * SUM(CASE WHEN "Attrition" = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 1) AS actual_att_pct
FROM ibm_hr_project
GROUP BY "Risk_Level"
ORDER BY actual_att_pct DESC;


--28: Which current employees should HR talk to first? (Action list)
SELECT "EmployeeNumber", "JobRole", "Department", "OverTime",
       "MonthlyIncome", ROUND(("Leave_Probability" * 100)::numeric, 1) AS leave_probability_pct
FROM ibm_hr_project
WHERE "Attrition" = 'No'
  AND "Risk_Level" = 'High'
ORDER BY "Leave_Probability" DESC
LIMIT 10;










