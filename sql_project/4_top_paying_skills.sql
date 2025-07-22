/*
Question : What are the top skills based on salary?
- Look at the average salary associated with each skill for Data Analysts positions.
- Focus on roles with specified salaries, regardless of location.
Why? It reveals how different skills impact salary levels for Data Analysts and 
helps identify the most financially rewarding skills to acquire or improve
*/

SELECT
    skills,
    ROUND(AVG(salary_year_avg), 2) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = TRUE
GROUP BY
    skills
ORDER BY
    avg_salary DESC
LIMIT 25;

/*

💰 Top-Paying Skills = Modern Stack + Engineering Crossover
| 💡 **Trend**                       | 📊 **Observation**                                                                                                                                                                                  |
| ---------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **1. Data Engineering is king** 👑 | Skills like `PySpark`, `Databricks`, `Airflow`, `Kubernetes`, and `GCP` dominate. These are not “just analyst” skills – they overlap heavily with **data engineering** and **big data processing**. |
| **2. ML & AI skills pay off** 🤖   | Tools like `DataRobot`, `Watson`, `Scikit-learn`, and `Jupyter` suggest that **machine learning fluency** translates to significantly higher pay.                                                   |
| **3. Coding chops = \$\$\$** 💻    | Strong programming languages (`Golang`, `Scala`, `Swift`, `Python` libs like `Pandas`, `NumPy`) are high on the list – this implies that **analysts with developer-level skills** earn a premium.   |
| **4. DevOps & Git culture** 🛠️    | `Bitbucket`, `Gitlab`, `Jenkins`, `Linux`, `Atlassian` show that **version control + CI/CD knowledge** makes you highly valuable – even as an analyst.                                              |
| **5. Less Tableau, more cloud** ☁️ | Notably absent: `Tableau`, `Power BI`, `Excel`. In contrast, cloud tools like `GCP` and orchestration platforms like `Airflow` are rising stars in high-paying roles.                               |
*/

