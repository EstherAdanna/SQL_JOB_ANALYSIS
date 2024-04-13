
SELECT 
skills,
COUNT(skills_job_dim.job_id) AS demand_job_skills
FROM job_postings_fact
INNER JOIN skills_job_dim
ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim
ON skills_dim.skill_id = skills_job_dim.skill_id
WHERE job_title_short = 'Data Analyst' 
GROUP BY skills_dim.skills
ORDER BY demand_job_skills DESC 
LIMIT 5;

"skills","demand_job_skills"
"sql","92628"
"excel","67031"
"python","57326"
"tableau","46554"
"power bi","39468"






