/*
The question is what are the top in demand skills for data analyst?
_Join job postings to inner join table similar to query 2
-identify the top 5 in_demand skills for a data analyst
-focus on all job postings
_we do this to retrieve the top 5 skills highest in demand in the job market.
*/

SELECT 
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short ='Data Analyst' AND
    job_work_from_home =True
GROUP BY 
    skills
ORDER BY
    demand_count DESC
LIMIT 5;