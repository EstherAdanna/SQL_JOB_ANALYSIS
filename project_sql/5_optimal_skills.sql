/*Answer: what are the most optimal skills to learn (aka high demand and pay)
-Identify skills on high demand and associated with high average salary
-Concentrates on remote positions with specified salaries
-why? Targets skills that offer job security (high demand) and offering
stategic insights for career development in data analysis*/

WITH skills_demand AS (
    SELECT 
        skills_dim.skill_id,
       skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS demand_job_skills
    FROM job_postings_fact
    INNER JOIN skills_job_dim
    ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim
    ON skills_dim.skill_id = skills_job_dim.skill_id
    WHERE job_title_short = 'Data Analyst' 
    AND job_work_from_home = True
    AND  salary_year_avg IS NOT NULL
    GROUP BY  skills_dim.skill_id
    ), average_salary AS (
    SELECT 
       skills_job_dim.skill_id,
        ROUND(AVG(salary_year_avg),0) AS avg_salary
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
    WHERE job_title_short = 'Data Analyst' 
        AND job_work_from_home = True
        AND salary_year_avg IS NOT NULL
    GROUP BY   skills_job_dim.skill_id
)
SELECT skills_demand.skill_id,
        skills_demand.skills,
        demand_job_skills,
        avg_salary
FROM skills_demand 
INNER JOIN average_salary ON  skills_demand.skill_id = average_salary.skill_id
WHERE demand_job_skills > 10
ORDER BY avg_salary DESC,
demand_job_skills DESC
        
LIMIT 25