SELECT 
    '2026-01-01':: DATE,
    '123':: INT,
    'true':: BOOLEAN,
    '37.8':: REAL;

SELECT 
    job_title_short AS title,
    job_location AS location,
    job_posted_date:: DATE AS DATE
FROM job_postings_fact;

SELECT 
    job_title_short AS title,
    job_location AS location,
    job_posted_date AS DATE
FROM job_postings_fact;



SELECT 
    COUNT(job_id) AS job_count,
    EXTRACT(MONTH FROM job_posted_date) AS date_month
FROM 
    job_postings_fact
WHERE
    job_title_short='Business Analyst'
GROUP BY    
    date_month
ORDER BY
    job_count DESC;
DROP TABLE januray_jobs
CREATE TABLE januray_jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date)=1;
      
CREATE TABLE February_jobs AS
 SELECT *
 FROM job_postings_fact
 WHERE EXTRACT(MONTH FROM job_posted_date)=2;



CREATE TABLE March_jobs AS
 SELECT *
 FROM job_postings_fact
 WHERE EXTRACT(MONTH FROM job_posted_date)=3;

CREATE TABLE April_jobs AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 4;

CREATE TABLE May_jobs AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 5;

CREATE TABLE June_jobs AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 6;

CREATE TABLE July_jobs AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 7;

CREATE TABLE August_jobs AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 8;

CREATE TABLE September_jobs AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 9;

CREATE TABLE October_jobs AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 10;

CREATE TABLE November_jobs AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 11;

CREATE TABLE December_jobs AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date)=12;

--SUBQUERIES
SELECT *
FROM (
        SELECT *
        FROM job_postings_fact
        WHERE EXTRACT(MONTH FROM job_posted_date)=1) AS jan_jobs;

SELECT 
    company_id,
    name AS company_name
FROM company_dim
WHERE company_id IN (
        SELECT 
            company_id
        FROM 
            job_postings_fact
        WHERE
            job_no_degree_mention=true
        ORDER BY
            company_id
);






        --CTE COMMAN TABLE EXPRESSION
WITH janu_jobs AS (
        SELECT *
        FROM job_postings_fact
        WHERE EXTRACT(MONTH FROM job_posted_date)=1
)

SELECT *
FROM janu_jobs;



WITH company_job_count AS(
    SELECT 
        company_id,
        COUNT(*) AS total_jobs
    FROM
        job_postings_fact
    GROUP BY
        company_id
)



SELECT 
    company_dim.name AS company_name,
    company_job_count.total_jobs
FROM 
    company_dim
LEFT JOIN 
    company_job_count ON company_job_count.company_id=company_dim.company_id
ORDER BY
    total_jobs DESC;


SELECT *
FROM skills_job_dim
LIMIT 5;

WITH remote_work_skills AS(
SELECT 
    job_postings.job_id,
    skill_id,
    COUNT(*) AS skills_count
FROM
    skills_job_dim AS skills_to_job
INNER JOIN job_postings_fact AS job_postings ON job_postings.job_id=skills_to_job.job_id
WHERE
    job_postings.job_work_from_home=True
GROUP BY
    skill_id
) 

SELECT *
FROM remote_work_skills;

WITH remote_work_skills AS (
  SELECT 
      job_postings.job_id,
      skill_id,
      COUNT(*) AS skill_count
  FROM skills_job_dim AS skills_to_job
  INNER JOIN job_postings_fact AS job_postings
      ON job_postings.job_id = skills_to_job.job_id
  WHERE job_postings.job_work_from_home = True
  
)
SELECT *
FROM remote_work_skills;

SELECT *
FROM company_dim
LIMIT 5;



--unions

SELECT 
    job_title_short,
    company_id,
    job_location
FROM
    januray_jobs

UNION

SELECT 
    job_title_short,
    company_id,
    job_location
FROM
    February_jobs

UNION 

SELECT 
    job_title_short,
    company_id,
    job_location
FROM
    March_jobs;

    --UNION ALL

SELECT 
    job_title_short,
    company_id,
    job_location
FROM
    januray_jobs

UNION ALL

SELECT 
    job_title_short,
    company_id,
    job_location
FROM
    February_jobs

UNION ALL 

SELECT 
    job_title_short,
    company_id,
    job_location
FROM
    March_jobs;

SELECT 
    quater_1_job_postings.job_title_short,
    quater_1_job_postings.job_location,
    quater_1_job_postings.job_via,
    quater_1_job_postings.job_posted_date::DATE,
    quater_1_job_postings.salary_year_avg

FROM (
    SELECT *
    FROM januray_jobs
    UNION ALL
    SELECT *
    FROM February_jobs
    UNION ALL
    SELECT *
    FROM March_jobs
) AS quater_1_job_postings
WHERE
    quater_1_job_postings.salary_year_avg > 70000 And
    quater_1_job_postings.job_title_short='Data Analyst'
ORDER BY
    quater_1_job_postings.salary_year_avg DESC;