/*
What are the top skills based on salary
-We look at the average salary associated with each skill for Data Analyst positions
-Then focus on roles with specified salaries, regardless of location
-We do this as it reveals how different skills impact salary levels for Data Analysts and helps identify the most financially rewarding skills to acquire or improve.
*/

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


    


/*
[
  {
    "skills": "swift",
    "avg_salary": "153750"
  },
  {
    "skills": "golang",
    "avg_salary": "145000"
  },
  {
    "skills": "shell",
    "avg_salary": "125000"
  },
  {
    "skills": "scala",
    "avg_salary": "117379"
  },
  {
    "skills": "go",
    "avg_salary": "116147"
  },
  {
    "skills": "crystal",
    "avg_salary": "114000"
  },
  {
    "skills": "c",
    "avg_salary": "109816"
  },
  {
    "skills": "r",
    "avg_salary": "103431"
  },
  {
    "skills": "python",
    "avg_salary": "102992"
  },
  {
    "skills": "nosql",
    "avg_salary": "102865"
  },
  {
    "skills": "javascript",
    "avg_salary": "102604"
  },
  {
    "skills": "sas",
    "avg_salary": "102161"
  },
  {
    "skills": "c++",
    "avg_salary": "101917"
  },
  {
    "skills": "t-sql",
    "avg_salary": "101214"
  },
  {
    "skills": "java",
    "avg_salary": "99881"
  },
  {
    "skills": "matlab",
    "avg_salary": "99000"
  },
  {
    "skills": "sql",
    "avg_salary": "98269"
  },
  {
    "skills": "rust",
    "avg_salary": "97500"
  },
  {
    "skills": "php",
    "avg_salary": "95000"
  },
  {
    "skills": "bash",
    "avg_salary": "93950"
  },
  {
    "skills": "pascal",
    "avg_salary": "92000"
  },
  {
    "skills": "powershell",
    "avg_salary": "90500"
  },
  {
    "skills": "html",
    "avg_salary": "90000"
  },
  {
    "skills": "vb.net",
    "avg_salary": "90000"
  },
  {
    "skills": "vba",
    "avg_salary": "88015"
  }
]

INSIGHTS

Engineering-heavy skillset pays the most — languages used in systems/backend development like Swift, Go/Golang, Shell/Shell scripting, and Scala dominate the top salaries, indicating top-paying roles lean toward software engineering and scalable infrastructure expertise.

Data stack remains lucrative — Python, SQL, NoSQL, SAS, and T-SQL all appear near or above the $100K average salary mark, showing strong demand for data processing, analytics, and database fluency in high-paying analyst/technical roles.

Automation skills add salary edge — scripting and workflow tools like Shell, Bash, Bash, PowerShell, and VBA/VBA suggest roles involving automation, DevOps collaboration, or data pipeline efficiency are consistently rewarded.

*/