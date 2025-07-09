select
    COUNT(job_id) AS number_of_jobs,
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS location_category
FROM
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    location_category;

SELECT
    job_id,
    job_title,
    salary_year_avg,
    CASE
        WHEN salary_year_avg >= 100000 THEN 'high salary'
        WHEN salary_year_avg >= 60000 THEN 'standard salary'
        WHEN salary_year_avg < 60000 THEN 'low salary'
    END AS salary_category
FROM
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC;

SELECT
    COUNT(DISTINCT company_id),
    CASE
        WHEN job_work_from_home IS TRUE THEN 'WFH available'
        WHEN job_work_from_home IS FALSE THEN 'WFH not available'
    END AS wfh_category
FROM 
    job_postings_fact
GROUP BY
    wfh_category;

SELECT 
    COUNT(DISTINCT CASE WHEN job_work_from_home = TRUE THEN company_id END) AS wfh_companies,
    COUNT(DISTINCT CASE WHEN job_work_from_home = FALSE THEN company_id END) AS non_wfh_companies
FROM job_postings_fact;

SELECT
    COUNT(DISTINCT CASE WHEN job_work_from_home = TRUE THEN company_id END) * 100.0 /
    COUNT(DISTINCT company_id) AS pct_wfh_companies
FROM
    job_postings_fact;

SELECT
    job_id,
    salary_year_avg,
    CASE
        WHEN job_title LIKE '%Senior%' THEN 'Senior'
        WHEN job_title LIKE '%Manager%' THEN 'Lead/Manager'
        WHEN job_title LIKE '%Junior%' THEN 'Junior/Entry'
        ELSE 'Not Specified'
    END AS experience_level,
    CASE
        WHEN job_work_from_home IS TRUE THEN 'Yes'
        ELSE 'No'
    END AS remote_option
FROM
    job_postings_fact
WHERE
    salary_year_avg IS NOT NULL
ORDER BY
    job_id;

SELECT 
  job_id,
  salary_year_avg,
  CASE
      WHEN job_title ILIKE '%Senior%' THEN 'Senior'
      WHEN job_title ILIKE '%Manager%' OR job_title ILIKE '%Lead%' THEN 'Lead/Manager'
      WHEN job_title ILIKE '%Junior%' OR job_title ILIKE '%Entry%' THEN 'Junior/Entry'
      ELSE 'Not Specified'
  END AS experience_level,
  CASE
      WHEN job_work_from_home THEN 'Yes'
      ELSE 'No' 
  END AS remote_option
FROM 
  job_postings_fact
WHERE 
  salary_year_avg IS NOT NULL 
ORDER BY 
  job_id;
