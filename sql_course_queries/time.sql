SELECT job_posted_date
FROM job_postings_fact
LIMIT 10;

SELECT 
    '2023-03-19'::DATE,
    '123'::INTEGER,
    'true'::BOOLEAN,
    '3.14'::REAL;

SELECT
    job_title_short as title,
    job_location as location,
    job_posted_date::DATE as date
from
    job_postings_fact;

SELECT
    job_title_short as title,
    job_location as location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' as date
from
    job_postings_fact
limit 5;

SELECT
    job_title_short as title,
    job_location as location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' as date_time,
    EXTRACT(MONTH FROM job_posted_date) as date_month,
    EXTRACT(YEAR FROM job_posted_date) as date_year
from
    job_postings_fact
limit 5;

SELECT
    COUNT(job_id) as job_posted_count,
    EXTRACT(MONTH FROM job_posted_date) as month
from
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    month
ORDER BY
    job_posted_count DESC;


CREATE TABLE january_jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1;

CREATE TABLE february_jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 2;

CREATE TABLE march_jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 3;

select *
from march_jobs;