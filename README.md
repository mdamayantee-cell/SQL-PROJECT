# INTRODUCTION

📊 An analytical exploration of the 2023 Data Analyst job market, uncovering top-paying roles, most in-demand skills, and the intersection where high demand meets high salary. The project leverages structured job posting data to generate career-relevant insights for the data analytics ecosystem.
Check them out here: [project_SQL folder](/project_SQL/) 
# BACKGROUND 
📊 SQL-driven job market analysis (2023) for Data Analyst roles, built by applying real-world queries learned in my SQL course to uncover top salaries, skill demand, and high-value skill overlaps.

🧠 This project was developed with guidance from a YouTube tutorial to demonstrate hands-on SQL querying, JOINs, CTEs, aggregation, and salary-skill analysis in a practical career context.

💼 The dataset includes job titles, locations, salaries, and required skills, structured to generate insights that help others identify which skills lead to the best opportunities and pay in data analytics.

❓ Key Questions Answered via SQL

This analysis was powered by SQL queries designed to answer:

- **What are the top-paying Data Analyst jobs in 2023?**

- **Which skills are required for these high-paying roles?**

- **What are the most in-demand technical skills for Data Analysts?**

-**Which skills are linked to higher average salaries?**

- **What are the most optimal skills to learn for strong demand + strong pay?**

# TOOLS I USED

For my deep dive into the data analyst job market, I harnessed the power of several key tools:

- **SQL**: The backbone of my analysis, allowing me to query the database and unearth critical insights.

-**PostgreSQL**: The chosen database management system, ideal for handling the job posting data.

-**Visual Studio Code**: My go-to for database management and executing SQL queries.

-**Git & GitHub**: Essential for version control and sharing my SQL scripts and analysis, ensuring collaboration and project tracking.

# THE ANALYSIS 
Each query for this project aimed at investigating specific aspects of the data analyst job market. Here’s how I approached each question:

1. **Top Paying Data Analyst Jobs**
To identify the highest-paying roles, I filtered data analyst positions by average yearly salary and location, focusing on remote jobs. This query highlights the high paying opportunities in the field.

```
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
```
2. **Skills for Top Paying Jobs**
To understand what skills are required for the top-paying jobs, I joined the job postings with the skills data, providing insights into what employers value for high-compensation roles.

```
WITH top_paying_jobs AS (
    SELECT
        job_id,
        job_title,
        salary_year_avg,
        name AS company_name
    FROM job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_title_short = 'Data Analyst'
        AND job_location = 'Anywhere'
        AND salary_year_avg IS NOT NULL
    ORDER BY salary_year_avg DESC
    LIMIT 15
)

SELECT top_paying_jobs.*,
        skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC;
```

- SQL is leading with a bold count of 8
- Python follows closely with a bold count of 7
- Tableau is also highly sought after, with a count of 6
- Other skills like R,Snowflake,Pandas and Excel show varying degrees of demand.

3. **In-Demand Skills for Data Analysts**
This query helped identify the skills most frequently requested in job postings, directing focus to areas with high demand.

```
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
```
4. **Skills Based on Salary**
Exploring the average salaries associated with different skills revealed which skills are the highest paying.

```
SELECT 
    skills,
    ROUND(AVG(salary_year_avg),0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short ='Data Analyst' AND
    salary_year_avg IS NOT NULL 
  -- job_work_from_home =True
GROUP BY 
    skills
ORDER BY
    avg_salary DESC
    
LIMIT 25;
```
- Engineering-heavy skillset pays the most — languages used in systems/backend development like Swift, Go/Golang, Shell/Shell scripting, and Scala dominate the top salaries, indicating top-paying roles lean toward software engineering and scalable infrastructure expertise.

- Data stack remains lucrative — Python, SQL, NoSQL, SAS, and T-SQL all appear near or above the $100K average salary mark, showing strong demand for data processing, analytics, and database fluency in high-paying analyst/technical roles.

- Automation skills add salary edge — scripting and workflow tools like Shell, Bash, Bash, PowerShell, and VBA/VBA suggest roles involving automation, DevOps collaboration, or data pipeline efficiency are consistently rewarded.

5. **Most Optimal Skills to Learn**
Combining insights from demand and salary data, this query aimed to pinpoint skills that are both in high demand and have high salaries, offering a strategic focus for skill development.

```
WITH skills_demand AS (
    SELECT 
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS demand_count
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst'
        AND job_work_from_home = TRUE
        AND salary_year_avg IS NOT NULL 
    GROUP BY 
        skills_dim.skill_id,
        skills_dim.skills
),
avg_salary AS (
    SELECT 
        skills_job_dim.skill_id,
        ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    WHERE
        job_title_short = 'Business Analyst'
        AND salary_year_avg IS NOT NULL 
    GROUP BY 
        skills_job_dim.skill_id
)

SELECT 
    skills_demand.skill_id,
    skills_demand.skills,
    skills_demand.demand_count,
    avg_salary.avg_salary
FROM skills_demand
INNER JOIN avg_salary 
    ON skills_demand.skill_id = avg_salary.skill_id
WHERE
    demand_count >10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;
```
# WHAT I LEARNED

Throughout this adventure, I've turbocharged my SQL toolkit with some serious firepower:

🧩 **Complex Query Crafting**: Mastered the art of advanced SQL, merging tables like a pro and wielding WITH clauses for ninja-level temp table maneuvers.
📊 **Data Aggregation**: Got cozy with GROUP BY and turned aggregate functions like COUNT() and AVG() into my data-summarizing sidekicks.
💡 **Analytical Wizardry**: Leveled up my real-world puzzle-solving skills, turning questions into actionable, insightful SQL queries.

# CONCLUSION

**Insights**
From the analysis, several general insights emerged:

- Top-Paying Data Analyst Jobs: The highest-paying jobs for data analysts that allow remote work offer a wide range of salaries, the highest at $650,000!
- Skills for Top-Paying Jobs: High-paying data analyst jobs require advanced proficiency in SQL, suggesting it’s a critical skill for earning a top salary.
- Most In-Demand Skills: SQL is also the most demanded skill in the data analyst job market, thus making it essential for job seekers.
- Skills with Higher Salaries: Specialized skills, such as SVN and Solidity, are associated with the highest average salaries, indicating a premium on niche expertise.
- Optimal Skills for Job Market Value: SQL leads in demand and offers for a high average salary, positioning it as one of the most optimal skills for data analysts to learn to maximize their market value.



