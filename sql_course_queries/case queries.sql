-- problem 1

select
    job_id,
    job_title,
    salary_year_avg,
    CASE
        when salary_year_avg >= 100000 then 'High salary'
        WHEN salary_year_avg >= 60000 then 'Standard salary'
        WHEN salary_year_avg < 60000 then 'Low salary'
    END AS salary_information
FROM job_postings_fact
WHERE
    job_title_short = 'Data Analyst' AND salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC;

-- problem 2

SELECT
    COUNT(DISTINCT company_id),
    CASE
        WHEN job_work_from_home IS TRUE
        WHEN job_work_from_home IS FALSE
    END AS wfh_policy
FROM job_postings_fact; -- źle

SELECT 
    COUNT(DISTINCT CASE WHEN job_work_from_home = TRUE THEN company_id END) AS wfh_companies,
    COUNT(DISTINCT CASE WHEN job_work_from_home = FALSE THEN company_id END) AS non_wfh_companies
FROM job_postings_fact;

SELECT * from job_postings_fact

-- problem 3

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