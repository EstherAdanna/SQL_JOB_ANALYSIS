
SELECT *
FROM february;

SELECT *
FROM march;

SELECT company_id,
job_location,
job_title_short
FROM january
UNION ALL
SELECT company_id,
job_location,
job_title_short
FROM february
UNION ALL
SELECT company_id,
job_location,
job_title_short
FROM march;
-- trying out advanced practice problem
--jan
WITH jan_skill_job AS (
SELECT january.job_id,
skill_job.skill_id
FROM january
INNER JOIN skills_job_dim AS skill_job 
ON january.job_id = skill_job.job_id)

/*SELECT jan_skill_job.*,
skills_dim.skills,
skills_dim.type
FROM jan_skill_job
INNER JOIN skills_dim 
ON jan_skill_job.skill_id=skills_dim.skill_id
UNION
-- feb
WITH feb_skill_job AS (
SELECT february.job_id,
skill_job.skill_id
FROM february
INNER JOIN skills_job_dim AS skill_job 
ON february.job_id = skill_job.job_id)

SELECT feb_skill_job.*,
skills_dim.skills,
skills_dim.type
FROM feb_skill_job
INNER JOIN skills_dim 
ON feb_skill_job.skill_id=skills_dim.skill_id;

--march
WITH mar_skill_job AS (
SELECT march.job_id,
skill_job.skill_id
FROM march
INNER JOIN skills_job_dim AS skill_job 
ON march.job_id = skill_job.job_id)

SELECT mar_skill_job.*,
skills_dim.skills,
skills_dim.type
FROM mar_skill_job
INNER JOIN skills_dim 
ON mar_skill_job.skill_id=skills_dim.skill_id;*/


FROM(SELECT *
FROM january
 UNION ALL
 SELECT *
 FROM february
 UNION ALL
 SELECT *
 FROM march) AS quarter_job3;
 WHERE