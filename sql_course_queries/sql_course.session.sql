SELECT name AS company_name, company_id
FROM company_dim
WHERE company_id IN(
    SELECT
        company_id
    FROM
        job_postings_fact
    WHERE
        job_no_degree_mention = true
)

WITH company_job_count AS (
SELECT
    company_id,
    COUNT(*)
FROM
    job_postings_fact
GROUP BY
    company_id
)
SELECT * FROM company_job_count

SELECT name
FROM company_dim

WITH remote_job_skills AS (
    SELECT
        skill_id,
        COUNT(*) AS skill_count
    FROM
        skills_job_dim AS skills_to_job
    INNER JOIN job_postings_fact AS job_postings ON job_postings.job_id = skills_to_job.job_id
    WHERE
        job_postings.job_work_from_home = True AND
        job_postings.job_title_short = 'Data Analyst'
    GROUP BY
        skill_id
)

SELECT
    skills.skill_id,
    skills AS skill_name,
    skill_count
FROM remote_job_skills
INNER JOIN skills_dim AS skills ON skills.skill_id = remote_job_skills.skill_id
ORDER BY
    skill_count DESC
LIMIT 5;