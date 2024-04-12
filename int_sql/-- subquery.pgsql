-- subquery
SELECT job_id,
    job_title,
    job_posted_date
FROM (SELECT *
FROM job_postings_fact
where EXTRACT(MONTH FROM job_posted_date)=1) AS jan_jobs;


-- CTEs
 WITH feb_jobs AS ( SELECT * 
 FROM job_postings_fact
 WHERE EXTRACT(MONTH FROM job_posted_date)=2)
 SELECT job_id,
    job_title,
    job_posted_date,
    salary_year_avg
 FROM feb_jobs
 where salary_year_avg is not null;


-- subquery example
 SELECT company_id,
 name as company_name
 FROM company_dim
 WHERE company_id IN (
        SELECT company_id
        FROM job_postings_fact
        WHERE job_no_degree_mention = true
        ORDER BY company_id );

-- CTEs examples
WITH company_job_count AS (
    SELECT company_id,
    count(*) as job_count
FROM job_postings_fact
GROUP BY company_id 
ORDER BY job_count desc)

SELECT company.name AS company_name,
       company_job.job_count AS total_job
FROM company_dim AS company
LEFT JOIN company_job_count AS company_job ON 
company.company_id = company_job.company_id
ORDER BY total_job desc
;

-- practice problem
SELECT skills,
    skills_count
    FROM(SELECT skill_id,
    count(*) AS skills_count
FROM skills_job_dim
GROUP BY skill_id) AS skills_job
LEFT JOIN  skills_dim  ON
skills_job.skill_id = skills_dim.skill_id
ORDER BY skills_count DESC
LIMIT 5;

SELECT 
        company_id,
        job_count,
CASE 
    WHEN job_count <10 THEN 'Small'
    WHEN job_count >=10 AND job_count<=50 THEN 'Medium'
    WHEN job_count > 50 THEN 'Large'
    END AS company_size
    FROM(
        SELECT 
        company_id,

        count(*) AS job_count 
FROM job_postings_fact
GROUP BY company_id) AS company_jobs
ORDER BY job_count DESC;

-- check this code later
/*SELECT 
        skills_dim.skills AS skill_name,
        skill_job.skills_count
FROM (
    SELECT job_id, skill_id,
    COUNT(*) AS skills_count
    FROM skills_job_dim
    GROUP BY skill_id) AS skill_job
INNER JOIN job_postings_fact AS job_postings ON 
skill_job.job_id = job_postings.job_id
INNER JOIN skills_dim ON
skill_job.skill_id = skills_dim.skill_id
WHERE job_postings.job_work_from_home = True
GROUP BY skill_id
ORDER BY skills_count DESC
LIMIT 5;*/


WITH remote_job AS (
SELECT 
skill_id,
COUNT(*) AS count_job
FROM skills_job_dim AS skills_job
INNER JOIN job_postings_fact AS job_postings ON 
skills_job.job_id= job_postings.job_id
WHERE job_postings.job_work_from_home = True AND 
job_postings.job_title = 'Data Analyst'
GROUP BY skill_id)

SELECT remote_job.skill_id,
remote_job.count_job,
skills_dim.skills
FROM remote_job
INNER JOIN skills_dim ON 
remote_job.skill_id = skills_dim.skill_id
ORDER BY count_job DESC
LIMIT 5;

SELECT quarter1.job_title_short,
quarter1.job_location,
ROUND(quarter1.salary_year_avg,0),
quarter1.job_posted_date:: DATE,
quarter1.job_via
FROM(SELECT *
FROM january
UNION ALL
SELECT *
FROM february
UNION ALL
SELECT *
FROM march) AS quarter1
WHERE quarter1.salary_year_avg > 70000
AND quarter1.job_title_short = 'Data Analyst'
ORDER BY quarter1.salary_year_avg DESC;

-- PROJECT GOAL
/* ABOUT THE PROJECT
1. You are an aspiring data nerd looking to analyze top-paying roles and skills
2. you will create SQL queries to explore this large dataset specific to you
3. For those job searching or looking for promotion; you can not only use this project to 
showcase experience BUT also to extract what roles/skills you should target.*/







