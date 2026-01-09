/*
The first question we address in this project is What are the top paying jobs?
-For this we first identify the top 15 highest paying Data Analyst roles that are available remotely.
-Then we focus on job postings with specified salaries(removing null).
-We do all this because it high lights the top paying job opportunities for Data Analysts,offering insights into what skills are the most important.
*/


SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name AS company_name
FROM
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id=company_dim.company_id
WHERE
    job_title_short='Data Analyst' AND
    job_location='Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 15;