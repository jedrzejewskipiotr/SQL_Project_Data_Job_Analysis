SELECT
    job_id,
    job_title,
    'With Salary Info' AS salary_info -- Custom field indicating salary info presence
FROM job_postings_fact
WHERE
    salary_hour_avg IS NOT NULL OR
    salary_year_avg IS NOT NULL

UNION ALL

SELECT
    job_id,
    job_title,
    'Without Salary Info' AS salary_info -- Custom field indicating absence of salary info
FROM job_postings_fact
WHERE
    salary_hour_avg IS NULL AND
    salary_year_avg IS NULL

-- 

-- Select job postings with salary information
(
SELECT 
    job_id, 
    job_title, 
    'With Salary Info' AS salary_info  -- Custom field indicating salary info presence
FROM 
    job_postings_fact
WHERE 
    salary_year_avg IS NOT NULL OR salary_hour_avg IS NOT NULL  
)
UNION ALL
 -- Select job postings without salary information
(
SELECT 
    job_id, 
    job_title, 
    'Without Salary Info' AS salary_info  -- Custom field indicating absence of salary info
FROM 
    job_postings_fact
WHERE 
    salary_year_avg IS NULL AND salary_hour_avg IS NULL 
)
ORDER BY 
    salary_info DESC, 
    job_id; 

-- Problem 2

SELECT
    quarter1_job_postings.job_id,
    quarter1_job_postings.job_title_short,
    quarter1_job_postings.job_location,
    quarter1_job_postings.job_via,
    skills_type.skills,
    skills_type.type
FROM (
    SELECT *
    FROM january_jobs
    UNION ALL
    SELECT *
    FROM february_jobs
    UNION ALL
    SELECT *
    FROM march_jobs
) AS quarter1_job_postings
LEFT JOIN skills_job_dim skills ON quarter1_job_postings.job_id = skills.job_id
LEFT JOIN skills_dim skills_type ON skills.skill_id = skills_type.skill_id
WHERE
    quarter1_job_postings.salary_year_avg > 70000
ORDER BY
    quarter1_job_postings.job_id;
    
SELECT * from skills_dim