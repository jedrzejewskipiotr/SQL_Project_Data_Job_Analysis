# Introduction

This project explores the current data job landscape with a focus on Data Analyst roles.

📌 Key goals:

💰 Identify the top-paying positions

🔥 Pinpoint the most in-demand skills

📈 Find where high demand meets high salary

# Background

Data is gathered from [datanerd.tech](https://datanerd.tech/) by [Luke Barrousse](https://github.com/lukebarousse) and contains real-world job postings from 2023.

The questions I wanted to answer through my SQL queries were:
- What are the top-paying data analyst jobs?
- What skills are required for these top-paying jobs?
- What skills are most in demand for data analysts?
- Which skills are associated with higher salaries?
- What are the most optimal skills to learn?


# Tools & Technologies Used

For my deep dive into the Data Analyst job market, I leveraged a robust set of tools to extract, analyze, and share insights:

- SQL – The core of the analysis, used to query data and extract meaningful patterns.

- PostgreSQL – My database of choice, perfect for managing and exploring structured job posting data.

- Visual Studio Code – Served as my main environment for writing and executing SQL queries.

- Git & GitHub – Ensured version control, collaboration, and transparency by tracking all SQL scripts and project progress.

# The Analysis

Each query for this project aimed at investigating specific aspects of the data analyst job market. Here’s how I approached each question:

### 1. Top Paying Data Analyst Jobs
To identify the highest-paying roles, I filtered data analyst positions by average yearly salary and location, focusing on remote jobs. This query highlights the high paying opportunities in the field.

```sql
SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date::DATE,
    name AS company_name
FROM 
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_location = 'Anywhere' AND
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
```

🚀 Summary
- The top-paying roles cluster around leadership ("Director", "Principal") and advanced analytics.

- Tech companies dominate the top salaries, but healthcare and telecom are also in the race.

- Remote and hybrid positions are common — flexibility seems standard at the top tier.

- If you're aiming for the big bucks: get strategic with title and industry.

# What I learned

# Conclusions