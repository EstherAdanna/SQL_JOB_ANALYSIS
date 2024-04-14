TODO : update this contents to this later
# Introduction (My First SQL Project)
Explore the data analytics job market!
This project delves into the top paying data analytics job across various countries, in-demand skills and where high demand meet top paying jobs in data analytics.

SQL queries? check them out here: [project_sql folder](/project_sql/) 

# Background
The desire to effectively understand the data analytics job market birthed this project. 
Data source [SQL course](https://lukebarousse/sql). These datasets contains information on job titles, salaries, location and essential skills on demand.

### The questions answered through my queries were;
1. What are the top-paying data analyst jobs?
2. What skills are required for the top-paying data analyst jobs?
3. what skills are most in demand for data analyst
4. Which skills are associated with higher salaries
5. What are the most optimal skills to learn

# Tools I used

- **SQL**  : the foundation of my analysis, allowing me to query database and discover essential insights
- **PostgreSQL** : database management used in the project, ideal for handling job posting data
- **Visual Studio Code**: my safe-haven executing queries and database management(very seamless)
- **Git & GitHub**: essential for sharing my SQL scripts and analysis, ensuring collaborationa and project tracking
# The Analysis
Each query for this project aimed at investigating specific aspect of the job market and answering the questions above.
*** What are the top-paying data analyst jobs?***
``` sql
SELECT job_id,
job_title,
job_location,
job_schedule_type,
salary_year_avg,
job_posted_date,
name AS company_name
FROM
job_postings_fact
LEFT JOIN company_dim
ON job_postings_fact.company_id = company_dim.company_id
WHERE job_title_short = 'Data Analyst'
AND job_location = 'Anywhere' 
AND salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10
```


*** What skills are required for the top-paying data analyst jobs?***
``` sql
WITH top_paying_jobs AS (SELECT 
    job_id,
    job_title,
    salary_year_avg,
    name AS company_name
FROM
    job_postings_fact
LEFT JOIN company_dim
ON  job_postings_fact.company_id = company_dim.company_id
WHERE job_title_short = 'Data Analyst'
AND    job_location = 'Anywhere' 
AND     salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10)

SELECT top_paying_jobs.*,
skills
FROM top_paying_jobs
INNER JOIN skills_job_dim
ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim
ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY top_paying_jobs.salary_year_avg DESC
LIMIT 100;
```
*** what skills are most in demand for data analyst***
``` sql
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
LIMIT 10;
```

Skills            | Demand
-------------------------|-------
     SQL                 |  7291
     Excel               |  4611
     Python              |  4330
     Tableau             |  3745
     Power BI            |  2609
     R                   |  2142
     SAS                 |  1866
     Looker              |   868
     Azure               |   821
     PowerPoint          |   819

       
*** Which skills are associated with higher salaries ***
``` sql
SELECT 
skills,
ROUND(AVG(salary_year_avg),0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim
ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim
ON skills_dim.skill_id = skills_job_dm.skill_id
WHERE job_title_short = 'Data Analyst' 
AND job_work_from_home = True
AND salary_year_avg IS NOT NULL
GROUP BY skills
ORDER BY avg_salary  DESC 
LIMIT 10;
```
       
Skills            | Average Salary
-------------------------|----------------
     Pyspark              |   $208,172
     Bitbucket            |   $189,155
     Watson               |   $160,515
     Couchbase            |   $160,515
     Datarobot            |   $155,486
     Gitlab               |   $154,500
     Swift                |   $153,750
     Jupyter              |   $152,777
     Pandas               |   $151,821
     Elasticsearch        |   $145,000


/*Answer: what are the most optimal skills to learn (aka high demand and pay)
-Identify skills on high demand and associated with high average salary
-Concentrates on remote positions with specified salaries
-why? Targets skills that offer job security (high demand) and offering
stategic insights for career development in data analysis*/

```sql
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
LIMIT 25;
```
  Skills            | Demand | Average Salary
-------------------------|--------|---------------
     Go                  |   27   |   $115,320
     Confluence          |   11   |   $114,210
     Hadoop              |   22   |   $113,193
     Snowflake           |   37   |   $112,948
     Azure               |   34   |   $111,225
     BigQuery            |   13   |   $109,654
     AWS                 |   32   |   $108,317
     Java                |   17   |   $106,906
     SSIS                |   12   |   $106,683
     Jira                |   20   |   $104,918


# What I learned
 Throughout out this project; 
 - I have mastered the art of advanced SQL, merging table lika a pro and wielding WITH clauses and the use of subqueries in simplifying complex queries for easy comprehension of queries.
 - Data Aggregation and improved immensely in real-world puzzle-solving skills, turning questions into actionable, insightful SQL queries.

# Conclusions
This project enhanced my skills and provided valuable insights into the data analytics job market. This expploration highlights the importacncee of  continuous learning and adaptation to emerging trens in the field of data analytics.