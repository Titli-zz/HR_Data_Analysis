-- IBM HR Analytics: Employee Attrition
-- SQL queries only | MySQL 8.0+
-- Run after importing HR_Employee_Attrition.csv into a table named
-- hr_employee_attrition with matching column names.
-- Includes basic to advanced analysis, CTEs, recursive CTEs and window functions.

SELECT COUNT(*) AS total_employee_records
FROM hr_employee_attrition;

SELECT *
FROM hr_employee_attrition
LIMIT 10;

SELECT EmployeeNumber, COUNT(*) AS record_count
FROM hr_employee_attrition
GROUP BY EmployeeNumber
HAVING COUNT(*) > 1;

SELECT
    SUM(Attrition IS NULL)       AS null_attrition,
    SUM(EmployeeNumber IS NULL)  AS null_employee_number,
    SUM(Department IS NULL)      AS null_department,
    SUM(JobRole IS NULL)         AS null_job_role,
    SUM(MonthlyIncome IS NULL)   AS null_monthly_income,
    SUM(YearsAtCompany IS NULL)  AS null_tenure,
    SUM(OverTime IS NULL)        AS null_overtime
FROM hr_employee_attrition;

SELECT DISTINCT Attrition FROM hr_employee_attrition;

SELECT DISTINCT Department FROM hr_employee_attrition;

SELECT DISTINCT JobRole FROM hr_employee_attrition;

SELECT DISTINCT OverTime FROM hr_employee_attrition;

SELECT DISTINCT BusinessTravel FROM hr_employee_attrition;

SELECT *
FROM hr_employee_attrition
WHERE Age < 18 OR Age > 100
   OR DistanceFromHome < 0
   OR MonthlyIncome < 0
   OR YearsAtCompany < 0
   OR TotalWorkingYears < 0
   OR JobSatisfaction NOT BETWEEN 1 AND 4
   OR EnvironmentSatisfaction NOT BETWEEN 1 AND 4
   OR WorkLifeBalance NOT BETWEEN 1 AND 4;

SELECT EmployeeNumber, TotalWorkingYears, YearsAtCompany,
       YearsInCurrentRole, YearsWithCurrManager
FROM hr_employee_attrition
WHERE YearsAtCompany > TotalWorkingYears
   OR YearsInCurrentRole > YearsAtCompany
   OR YearsWithCurrManager > YearsAtCompany;

SELECT
    COUNT(DISTINCT EmployeeCount) AS employee_count_distinct_values,
    COUNT(DISTINCT StandardHours) AS standard_hours_distinct_values,
    COUNT(DISTINCT Over18) AS over18_distinct_values
FROM hr_employee_attrition;

SELECT EmployeeNumber, Age, Department, JobRole, MonthlyIncome, OverTime
FROM hr_employee_attrition
WHERE Attrition = 'Yes'
ORDER BY MonthlyIncome DESC;

SELECT EmployeeNumber, Department, JobRole, OverTime
FROM hr_employee_attrition
WHERE Attrition = 'No' AND OverTime = 'Yes';

SELECT DISTINCT Department FROM hr_employee_attrition ORDER BY Department;

SELECT DISTINCT JobRole FROM hr_employee_attrition ORDER BY JobRole;

SELECT DISTINCT EducationField FROM hr_employee_attrition ORDER BY EducationField;

SELECT EmployeeNumber, JobRole, Department, MonthlyIncome
FROM hr_employee_attrition
WHERE MonthlyIncome > 10000
ORDER BY MonthlyIncome DESC;

SELECT EmployeeNumber, Age, Department, YearsAtCompany
FROM hr_employee_attrition
WHERE YearsAtCompany >= 10
ORDER BY YearsAtCompany DESC;

SELECT EmployeeNumber, Department, JobRole, JobSatisfaction, Attrition
FROM hr_employee_attrition
WHERE JobSatisfaction IN (1, 2)
ORDER BY JobSatisfaction, Department;

SELECT EmployeeNumber, BusinessTravel, Department, Attrition
FROM hr_employee_attrition
WHERE BusinessTravel = 'Travel_Frequently';

SELECT Attrition, COUNT(*) AS employee_count
FROM hr_employee_attrition
GROUP BY Attrition;

SELECT
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
    ROUND(100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
          / NULLIF(COUNT(*), 0), 2) AS attrition_rate_pct
FROM hr_employee_attrition;

SELECT Department,
       COUNT(*) AS employee_count,
       ROUND(AVG(MonthlyIncome), 2) AS avg_monthly_income
FROM hr_employee_attrition
GROUP BY Department
ORDER BY avg_monthly_income DESC;

SELECT Department,
       COUNT(*) AS total_employees,
       SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
       ROUND(100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
             / NULLIF(COUNT(*), 0), 2) AS attrition_rate_pct
FROM hr_employee_attrition
GROUP BY Department
ORDER BY attrition_rate_pct DESC;

SELECT JobRole,
       COUNT(*) AS total_employees,
       SUM(Attrition = 'Yes') AS employees_left,
       ROUND(100.0 * SUM(Attrition = 'Yes') / NULLIF(COUNT(*), 0), 2)
           AS attrition_rate_pct
FROM hr_employee_attrition
GROUP BY JobRole
ORDER BY attrition_rate_pct DESC;

SELECT Attrition,
       COUNT(*) AS employee_count,
       ROUND(AVG(MonthlyIncome), 2) AS avg_monthly_income,
       ROUND(AVG(YearsAtCompany), 2) AS avg_years_at_company
FROM hr_employee_attrition
GROUP BY Attrition;

SELECT Department, SUM(Attrition = 'Yes') AS employees_left
FROM hr_employee_attrition
GROUP BY Department
HAVING SUM(Attrition = 'Yes') > 10
ORDER BY employees_left DESC;

SELECT Attrition,
       ROUND(AVG(JobSatisfaction), 2) AS avg_job_satisfaction,
       ROUND(AVG(EnvironmentSatisfaction), 2) AS avg_environment_satisfaction,
       ROUND(AVG(WorkLifeBalance), 2) AS avg_work_life_balance,
       ROUND(AVG(RelationshipSatisfaction), 2) AS avg_relationship_satisfaction
FROM hr_employee_attrition
GROUP BY Attrition;

SELECT
    CASE
        WHEN Age < 25 THEN 'Under 25'
        WHEN Age BETWEEN 25 AND 34 THEN '25-34'
        WHEN Age BETWEEN 35 AND 44 THEN '35-44'
        WHEN Age BETWEEN 45 AND 54 THEN '45-54'
        ELSE '55+'
    END AS age_group,
    COUNT(*) AS employee_count,
    SUM(Attrition = 'Yes') AS employees_left,
    ROUND(100.0 * SUM(Attrition = 'Yes') / NULLIF(COUNT(*), 0), 2)
        AS attrition_rate_pct
FROM hr_employee_attrition
GROUP BY age_group
ORDER BY attrition_rate_pct DESC;

SELECT
    CASE
        WHEN YearsAtCompany < 1 THEN 'Less than 1 year'
        WHEN YearsAtCompany BETWEEN 1 AND 3 THEN '1-3 years'
        WHEN YearsAtCompany BETWEEN 4 AND 6 THEN '4-6 years'
        WHEN YearsAtCompany BETWEEN 7 AND 10 THEN '7-10 years'
        ELSE 'Over 10 years'
    END AS tenure_group,
    COUNT(*) AS employee_count,
    SUM(Attrition = 'Yes') AS employees_left,
    ROUND(100.0 * SUM(Attrition = 'Yes') / NULLIF(COUNT(*), 0), 2)
        AS attrition_rate_pct
FROM hr_employee_attrition
GROUP BY tenure_group
ORDER BY MIN(YearsAtCompany);

SELECT
    CASE
        WHEN MonthlyIncome < 3000 THEN 'Under 3,000'
        WHEN MonthlyIncome < 6000 THEN '3,000-5,999'
        WHEN MonthlyIncome < 10000 THEN '6,000-9,999'
        ELSE '10,000+'
    END AS income_band,
    COUNT(*) AS employee_count,
    ROUND(AVG(YearsAtCompany), 2) AS avg_tenure,
    ROUND(100.0 * SUM(Attrition = 'Yes') / NULLIF(COUNT(*), 0), 2)
        AS attrition_rate_pct
FROM hr_employee_attrition
GROUP BY income_band
ORDER BY MIN(MonthlyIncome);

SELECT OverTime,
       COUNT(*) AS employee_count,
       SUM(Attrition = 'Yes') AS employees_left,
       ROUND(100.0 * SUM(Attrition = 'Yes') / NULLIF(COUNT(*), 0), 2)
           AS attrition_rate_pct
FROM hr_employee_attrition
GROUP BY OverTime
ORDER BY attrition_rate_pct DESC;

SELECT EmployeeNumber, Department, JobRole, MonthlyIncome
FROM hr_employee_attrition
WHERE MonthlyIncome > (SELECT AVG(MonthlyIncome) FROM hr_employee_attrition)
ORDER BY MonthlyIncome DESC;

SELECT e.EmployeeNumber, e.Department, e.JobRole, e.MonthlyIncome
FROM hr_employee_attrition AS e
WHERE e.MonthlyIncome >
      (SELECT AVG(d.MonthlyIncome)
       FROM hr_employee_attrition AS d
       WHERE d.Department = e.Department)
ORDER BY e.Department, e.MonthlyIncome DESC;

SELECT role_stats.JobRole, role_stats.total_employees,
       role_stats.employees_left, role_stats.attrition_rate_pct
FROM (
    SELECT JobRole,
           COUNT(*) AS total_employees,
           SUM(Attrition = 'Yes') AS employees_left,
           100.0 * SUM(Attrition = 'Yes') / NULLIF(COUNT(*), 0)
               AS attrition_rate_pct
    FROM hr_employee_attrition
    GROUP BY JobRole
) AS role_stats
WHERE role_stats.attrition_rate_pct >
      (SELECT 100.0 * SUM(Attrition = 'Yes') / NULLIF(COUNT(*), 0)
       FROM hr_employee_attrition)
ORDER BY role_stats.attrition_rate_pct DESC;

SELECT e.EmployeeNumber, e.Department, e.JobRole, e.JobSatisfaction
FROM hr_employee_attrition AS e
WHERE e.JobSatisfaction <
      (SELECT AVG(d.JobSatisfaction)
       FROM hr_employee_attrition AS d
       WHERE d.Department = e.Department)
ORDER BY e.Department, e.JobSatisfaction;

WITH attrition_summary AS (
    SELECT COUNT(*) AS total_employees,
           SUM(Attrition = 'Yes') AS employees_left
    FROM hr_employee_attrition
)
SELECT total_employees, employees_left,
       ROUND(100.0 * employees_left / NULLIF(total_employees, 0), 2)
           AS attrition_rate_pct
FROM attrition_summary;

WITH department_metrics AS (
    SELECT Department,
           COUNT(*) AS total_employees,
           SUM(Attrition = 'Yes') AS employees_left,
           AVG(MonthlyIncome) AS avg_income
    FROM hr_employee_attrition
    GROUP BY Department
)
SELECT Department, total_employees, employees_left,
       ROUND(100.0 * employees_left / NULLIF(total_employees, 0), 2)
           AS attrition_rate_pct,
       ROUND(avg_income, 2) AS avg_monthly_income
FROM department_metrics
ORDER BY attrition_rate_pct DESC;

WITH company_baseline AS (
    SELECT AVG(MonthlyIncome) AS company_avg_income,
           AVG(JobSatisfaction) AS company_avg_satisfaction
    FROM hr_employee_attrition
),
department_metrics AS (
    SELECT Department,
           AVG(MonthlyIncome) AS department_avg_income,
           AVG(JobSatisfaction) AS department_avg_satisfaction,
           COUNT(*) AS employee_count
    FROM hr_employee_attrition
    GROUP BY Department
)
SELECT d.Department, d.employee_count,
       ROUND(d.department_avg_income, 2) AS department_avg_income,
       ROUND(c.company_avg_income, 2) AS company_avg_income,
       ROUND(d.department_avg_income - c.company_avg_income, 2)
           AS income_difference,
       ROUND(d.department_avg_satisfaction, 2) AS department_avg_satisfaction,
       ROUND(c.company_avg_satisfaction, 2) AS company_avg_satisfaction
FROM department_metrics AS d
CROSS JOIN company_baseline AS c
ORDER BY income_difference DESC;

WITH role_metrics AS (
    SELECT JobRole,
           COUNT(*) AS employee_count,
           SUM(Attrition = 'Yes') AS employees_left,
           AVG(JobSatisfaction) AS avg_satisfaction
    FROM hr_employee_attrition
    GROUP BY JobRole
)
SELECT JobRole, employee_count, employees_left,
       ROUND(100.0 * employees_left / NULLIF(employee_count, 0), 2)
           AS attrition_rate_pct,
       ROUND(avg_satisfaction, 2) AS avg_job_satisfaction
FROM role_metrics
WHERE 100.0 * employees_left / NULLIF(employee_count, 0) >
      (SELECT 100.0 * SUM(Attrition = 'Yes') / NULLIF(COUNT(*), 0)
       FROM hr_employee_attrition)
  AND avg_satisfaction < 2.5
ORDER BY attrition_rate_pct DESC;

WITH employee_segments AS (
    SELECT EmployeeNumber, Attrition, OverTime, JobSatisfaction,
           CASE
               WHEN OverTime = 'Yes' AND JobSatisfaction <= 2
                   THEN 'Overtime + low satisfaction'
               WHEN OverTime = 'Yes'
                   THEN 'Overtime + higher satisfaction'
               WHEN JobSatisfaction <= 2
                   THEN 'No overtime + low satisfaction'
               ELSE 'No overtime + higher satisfaction'
           END AS risk_segment
    FROM hr_employee_attrition
)
SELECT risk_segment, COUNT(*) AS employee_count,
       SUM(Attrition = 'Yes') AS employees_left,
       ROUND(100.0 * SUM(Attrition = 'Yes') / NULLIF(COUNT(*), 0), 2)
           AS attrition_rate_pct
FROM employee_segments
GROUP BY risk_segment
ORDER BY attrition_rate_pct DESC;

WITH RECURSIVE tenure_years AS (
    SELECT 0 AS tenure_year
    UNION ALL
    SELECT tenure_year + 1
    FROM tenure_years
    WHERE tenure_year < 10
)
SELECT tenure_year
FROM tenure_years;

WITH role_metrics AS (
    SELECT JobRole, COUNT(*) AS employee_count,
           SUM(Attrition = 'Yes') AS employees_left,
           100.0 * SUM(Attrition = 'Yes') / NULLIF(COUNT(*), 0)
               AS attrition_rate_pct
    FROM hr_employee_attrition
    GROUP BY JobRole
)
SELECT JobRole, employee_count, employees_left,
       ROUND(attrition_rate_pct, 2) AS attrition_rate_pct,
       RANK() OVER (ORDER BY attrition_rate_pct DESC) AS attrition_rank
FROM role_metrics
ORDER BY attrition_rank;

SELECT EmployeeNumber, Department, JobRole, MonthlyIncome,
       DENSE_RANK() OVER (
           PARTITION BY Department ORDER BY MonthlyIncome DESC
       ) AS income_rank_in_department
FROM hr_employee_attrition
ORDER BY Department, income_rank_in_department;

SELECT EmployeeNumber, Department, MonthlyIncome,
       ROUND(AVG(MonthlyIncome) OVER (PARTITION BY Department), 2)
           AS department_avg_income,
       ROUND(MonthlyIncome -
             AVG(MonthlyIncome) OVER (PARTITION BY Department), 2)
           AS difference_from_department_avg
FROM hr_employee_attrition
ORDER BY Department, difference_from_department DESC;

SELECT Department, COUNT(*) AS employee_count,
       ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2)
           AS share_of_workforce_pct
FROM hr_employee_attrition
GROUP BY Department
ORDER BY employee_count DESC;

WITH level_counts AS (
    SELECT JobLevel, COUNT(*) AS employee_count
    FROM hr_employee_attrition
    GROUP BY JobLevel
)
SELECT JobLevel, employee_count,
       SUM(employee_count) OVER (
           ORDER BY JobLevel
           ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
       ) AS cumulative_employee_count
FROM level_counts
ORDER BY JobLevel;

WITH department_rates AS (
    SELECT Department,
           COUNT(*) AS employee_count,
           100.0 * SUM(Attrition = 'Yes') / NULLIF(COUNT(*), 0)
               AS attrition_rate_pct
    FROM hr_employee_attrition
    GROUP BY Department
)
SELECT Department, employee_count,
       ROUND(attrition_rate_pct, 2) AS attrition_rate_pct,
       ROUND(LAG(attrition_rate_pct) OVER (
           ORDER BY attrition_rate_pct DESC
       ), 2) AS previous_rate_in_ranked_list
FROM department_rates
ORDER BY attrition_rate_pct DESC;

WITH ranked_employees AS (
    SELECT EmployeeNumber, Department, JobRole, MonthlyIncome,
           ROW_NUMBER() OVER (
               PARTITION BY Department ORDER BY MonthlyIncome DESC,
               EmployeeNumber
           ) AS row_num
    FROM hr_employee_attrition
)
SELECT EmployeeNumber, Department, JobRole, MonthlyIncome, row_num
FROM ranked_employees
WHERE row_num <= 3
ORDER BY Department, row_num;

SELECT JobSatisfaction, COUNT(*) AS employee_count,
       SUM(Attrition = 'Yes') AS employees_left,
       ROUND(100.0 * SUM(Attrition = 'Yes') / NULLIF(COUNT(*), 0), 2)
           AS attrition_rate_pct
FROM hr_employee_attrition
GROUP BY JobSatisfaction
ORDER BY JobSatisfaction;

SELECT EnvironmentSatisfaction, OverTime,
       COUNT(*) AS employee_count,
       SUM(Attrition = 'Yes') AS employees_left,
       ROUND(100.0 * SUM(Attrition = 'Yes') / NULLIF(COUNT(*), 0), 2)
           AS attrition_rate_pct
FROM hr_employee_attrition
GROUP BY EnvironmentSatisfaction, OverTime
ORDER BY attrition_rate_pct DESC;

SELECT BusinessTravel, COUNT(*) AS employee_count,
       SUM(Attrition = 'Yes') AS employees_left,
       ROUND(100.0 * SUM(Attrition = 'Yes') / NULLIF(COUNT(*), 0), 2)
           AS attrition_rate_pct
FROM hr_employee_attrition
GROUP BY BusinessTravel
ORDER BY attrition_rate_pct DESC;

SELECT MaritalStatus, COUNT(*) AS employee_count,
       SUM(Attrition = 'Yes') AS employees_left,
       ROUND(100.0 * SUM(Attrition = 'Yes') / NULLIF(COUNT(*), 0), 2)
           AS attrition_rate_pct
FROM hr_employee_attrition
GROUP BY MaritalStatus
ORDER BY attrition_rate_pct DESC;

SELECT JobLevel, COUNT(*) AS employee_count,
       SUM(Attrition = 'Yes') AS employees_left,
       ROUND(100.0 * SUM(Attrition = 'Yes') / NULLIF(COUNT(*), 0), 2)
           AS attrition_rate_pct,
       ROUND(AVG(MonthlyIncome), 2) AS avg_monthly_income
FROM hr_employee_attrition
GROUP BY JobLevel
ORDER BY JobLevel;

SELECT
    CASE
        WHEN YearsSinceLastPromotion = 0 THEN 'Promotion this/most recent year'
        WHEN YearsSinceLastPromotion BETWEEN 1 AND 2 THEN '1-2 years since promotion'
        WHEN YearsSinceLastPromotion BETWEEN 3 AND 5 THEN '3-5 years since promotion'
        ELSE 'Over 5 years since promotion'
    END AS promotion_recency_group,
    COUNT(*) AS employee_count,
    SUM(Attrition = 'Yes') AS employees_left,
    ROUND(100.0 * SUM(Attrition = 'Yes') / NULLIF(COUNT(*), 0), 2)
        AS attrition_rate_pct
FROM hr_employee_attrition
GROUP BY promotion_recency_group
ORDER BY attrition_rate_pct DESC;

SELECT NumCompaniesWorked, COUNT(*) AS employee_count,
       SUM(Attrition = 'Yes') AS employees_left,
       ROUND(100.0 * SUM(Attrition = 'Yes') / NULLIF(COUNT(*), 0), 2)
           AS attrition_rate_pct
FROM hr_employee_attrition
GROUP BY NumCompaniesWorked
ORDER BY NumCompaniesWorked;

SELECT Attrition,
       ROUND(AVG(JobSatisfaction), 2) AS job_satisfaction,
       ROUND(AVG(EnvironmentSatisfaction), 2) AS environment_satisfaction,
       ROUND(AVG(RelationshipSatisfaction), 2) AS relationship_satisfaction,
       ROUND(AVG(WorkLifeBalance), 2) AS work_life_balance,
       ROUND(AVG(JobInvolvement), 2) AS job_involvement
FROM hr_employee_attrition
GROUP BY Attrition;

SELECT Attrition,
       ROUND(AVG(MonthlyIncome), 2) AS avg_monthly_income,
       ROUND(AVG(PercentSalaryHike), 2) AS avg_salary_hike_pct,
       ROUND(AVG(PerformanceRating), 2) AS avg_performance_rating
FROM hr_employee_attrition
GROUP BY Attrition;

SELECT EmployeeNumber, Department, JobRole, YearsAtCompany,
       JobSatisfaction, WorkLifeBalance, OverTime, MonthlyIncome
FROM hr_employee_attrition
WHERE Attrition = 'No'
  AND (JobSatisfaction <= 2 OR WorkLifeBalance <= 2)
  AND OverTime = 'Yes'
ORDER BY YearsAtCompany, JobSatisfaction;

SELECT * FROM vw_hr_overall_kpis;

SELECT * FROM vw_hr_department_kpis
ORDER BY attrition_rate_pct DESC;

SELECT 'Total employees' AS metric, CAST(COUNT(*) AS CHAR) AS metric_value
FROM hr_employee_attrition
UNION ALL
SELECT 'Employees left', CAST(SUM(Attrition = 'Yes') AS CHAR)
FROM hr_employee_attrition
UNION ALL
SELECT 'Attrition rate (%)',
       CAST(ROUND(100.0 * SUM(Attrition = 'Yes') / NULLIF(COUNT(*), 0), 2)
            AS CHAR)
FROM hr_employee_attrition
UNION ALL
SELECT 'Average monthly income',
       CAST(ROUND(AVG(MonthlyIncome), 2) AS CHAR)
FROM hr_employee_attrition
UNION ALL
SELECT 'Average years at company',
       CAST(ROUND(AVG(YearsAtCompany), 2) AS CHAR)
FROM hr_employee_attrition;
