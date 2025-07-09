CREATE TABLE job_applied (
    job_id INT,
    application_sent_date DATE,
    custom_resume BOOLEAN,
    resume_file_name VARCHAR(255),
    cover_letter_sent BOOLEAN,
    cover_letter_file_name VARCHAR(255),
    status VARCHAR(50)
);

SELECT * FROM job_applied

insert into job_applied (
    
)

drop TABLE job_applied

CREATE TABLE data_science_jobs (
    job_id int primary key,
    job_title text,
    company_name text,
    post_date date
);

insert into data_science_jobs 
    (job_id, job_title, company_name, post_date) 
values 
    (1, 'Data Scientist', 'Tech Innovations', '2023-01-01'),
    (2, 'Machine Learning Engineer', 'Data Driven Co', '2023-01-15'),
    (3, 'AI Specialist', 'Future Tech', '2023-02-01');

SELECT * from data_science_jobs;

alter table data_science_jobs
add column remote BOOLEAN;

ALTER TABLE data_science_jobs
rename column post_date to posted_on;

ALTER TABLE data_science_jobs
ALTER column remote set default False;

alter table data_science_jobs
drop column company_name;

UPDATE data_science_jobs
SET remote = True
WHERE job_id = 2

drop table data_science_jobs