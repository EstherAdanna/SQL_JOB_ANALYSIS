SELECT job_title_short,
    job_location
FROM job_postings_fact;

/* 
Label new column as follows;
    'Anywhere' jobs as 'Remote'
    'New York, NY ' jobs as 'Local'
    Otherwhise 'Onsite'
    */

SELECT 
     count(job_id) AS  number_of_jobs,
    CASE 
    WHEN job_location = 'Anywhere'  THEN 'Remote'
    WHEN job_location = 'New York, NY' THEN 'Local'
    ELSE 'Onsite'
    END AS location_category
    FROM job_postings_fact
    WHERE job_title_short = 'Data Analyst'
    GROUP BY location_category;

   -- ADvanced Case Expression practice 

   SELECT 
     count(job_id) AS  number_of_jobs,
    CASE 
    WHEN salary_year_avg < 100000  THEN 'Low Salary'
    WHEN salary_year_avg >=100000 AND salary_year_avg <=150000 THEN 'Standard Salary'
    WHEN salary_year_avg > 150000  THEN 'High Salary'
    ELSE 'Not Available'
    END AS Yearly_Salary_category
    FROM job_postings_fact
    WHERE job_title = 'Data Analyst'
    GROUP BY Yearly_Salary_category;

    -- Subqueries and Common Table expressions(CTEs)
-- subqueries
    SELECT *
    FROM ( SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1) 
    AS january_job;

    -- CTEs
    WITH january_jobs AS(-- CTE starts here
    SELECT * 
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date)=1) -- CTE ends here
    SELECT *
    FROM january_jobs
    )

    select salary_year_avg
    from job_postings_fact;

    