SELECT
    job_schedule_type,
    AVG(salary_year_avg),
    AVG(salary_hour_avg)
FROM
    job_postings_fact
WHERE
    job_posted_date::date > '2023-06-01'
GROUP BY
    job_schedule_type
ORDER BY
    job_schedule_type;

SELECT
    COUNT(job_id) AS job_posted_count,
    EXTRACT(MONTH FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York') AS month
FROM
    job_postings_fact
GROUP BY
    month
ORDER BY
    month;

SELECT
    c.name AS company_name,
    COUNT(j.job_id) AS job_posted_count
FROM
    job_postings_fact j
INNER JOIN
    company_dim c on j.company_id = c.company_id
WHERE
    j.job_health_insurance = TRUE
    AND EXTRACT(QUARTER FROM j.job_posted_date) = 2
GROUP BY
    company_name
HAVING
    COUNT(j.job_id) > 0
ORDER BY
    job_posted_count DESC;




