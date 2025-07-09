SELECT
    skills,
    skill_count
FROM (
    SELECT
        skill_id,
        COUNT(*) AS skill_count
    FROM
        skills_job_dim
    GROUP BY
        skill_id
    ORDER BY
        skill_count DESC
    LIMIT
        5
) AS top_skills
INNER JOIN skills_dim ON skills_dim.skill_id = top_skills.skill_id

SELECT skills_dim.skills, top_skills.skill_count
FROM skills_dim
INNER JOIN (
    SELECT 
        skill_id,
        COUNT(job_id) AS skill_count
    FROM skills_job_dim
    GROUP BY skill_id
    ORDER BY COUNT(job_id) DESC
    LIMIT 5
) AS top_skills ON skills_dim.skill_id = top_skills.skill_id
ORDER BY top_skills.skill_count DESC;

-----

SELECT
    company_id,
    job_postings_count,
    CASE
        WHEN job_postings_count < 10 THEN 'Small'
        WHEN job_postings_count BETWEEN 10 AND 50 THEN 'Medium'
        WHEN job_postings_count > 50 THEN 'Large'
    END AS size_category
FROM (
    SELECT
        company_id,
        COUNT(*) AS job_postings_count
    FROM
        job_postings_fact
    GROUP BY
        company_id
    ORDER BY
        job_postings_count DESC
)

SELECT
    cd.company_id,
    cd.name,
    job_postings_count,
    CASE
        WHEN job_postings_count < 10 THEN 'Small'
        WHEN job_postings_count BETWEEN 10 AND 50 THEN 'Medium'
        ELSE 'Large'
    END AS size_category
FROM (
    SELECT
        company_id,
        COUNT(*) AS job_postings_count
    FROM
        job_postings_fact
    GROUP BY
        company_id
) AS company_category
INNER JOIN
    company_dim cd ON company_category.company_id = cd.company_id


SELECT
   company_id,
   name,
   -- Categorize companies
   CASE
       WHEN job_count < 10 THEN 'Small'
       WHEN job_count BETWEEN 10 AND 50 THEN 'Medium'
       ELSE 'Large'
   END AS company_size
FROM (
   -- Subquery to calculate number of job postings per company 
   SELECT
       company_dim.company_id,
       company_dim.name,
       COUNT(job_postings_fact.job_id) AS job_count
   FROM company_dim
   INNER JOIN job_postings_fact 
       ON company_dim.company_id = job_postings_fact.company_id
   GROUP BY
       company_dim.company_id,
       company_dim.name
) AS company_job_count;

-----------

SELECT
    company_avg.name,
    average_salary_company
FROM (
    SELECT
        c.name,
        AVG(salary_year_avg) AS average_salary_company
    FROM
        job_postings_fact j
    INNER JOIN
        company_dim c ON j.company_id = c.company_id
    GROUP BY
        c.company_id
) AS company_avg
WHERE average_salary_company > (
    SELECT
        AVG(salary_year_avg) AS total_average
    FROM 
        job_postings_fact
)


SELECT 
    company_dim.name
FROM 
    company_dim
INNER JOIN (
    -- Subquery to calculate average salary per company
    SELECT 
        company_id, 
        AVG(salary_year_avg) AS avg_salary
    FROM job_postings_fact
    GROUP BY company_id
    ) AS company_salaries ON company_dim.company_id = company_salaries.company_id
-- Filter for companies with an average salary greater than the overall average
WHERE company_salaries.avg_salary > (
    -- Subquery to calculate the overall average salary
    SELECT AVG(salary_year_avg)
    FROM job_postings_fact
);