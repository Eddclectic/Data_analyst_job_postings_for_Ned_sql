 /* Objective:

 Utilise the provided datasets to draw insights about the  
 the top paying data analyst role and the most in demand skills for these data analyst roles along with their average yearly salaries.   

*/



SELECT 
skill_id,
skills,
COUNT(*) AS job_count,
ROUND(AVG(salary_year_avg),0) AS avg_salary
FROM (




SELECT 
dutch_job.job_title_short,
job_location,
salary_year_avg,
company_name,
skills,
skills_dim.skill_id,
dutch_job.job_id

FROM 
(

    SELECT 
        job_id,
        job_title_short,
        job_location,
        job_schedule_type,
        salary_year_avg,
        job_posted_date,
        name AS company_name

    FROM job_postings_fact

    LEFT JOIN company_dim
    On job_postings_fact.company_id=company_dim.company_id

    WHERE 
        job_title_short LIKE '%Data Analyst%' AND
        salary_year_avg IS NOT NULL AND
        job_location ='Anywhere'

) AS dutch_job

INNER JOIN skills_job_dim 
ON dutch_job.job_id=skills_job_dim.job_id
INNER JOIN skills_dim 
ON skills_job_dim.skill_id=skills_dim.skill_id

) AS high_demand

GROUP BY skill_id, skills
ORDER BY job_count DESC
LIMIT 5;



/*
Insights:

Sql appears to be the most in-demand skill by most Data Analayst roles, suggesting its vast usage in all forms of data analytics tasks.

The least in-demand skill is R programming which is yet to gain its deserved acceptance in the Data analytics world. 

Sql showed its dominance by appearing most in all the job sets while the others are relatively evenly distributed, except for R programming with a noticeable deviation in demand.

The average salary range for Data Analyst jobs requiring any of these skills is between $89k to $104k with R programming skill being most priced.

In general, a diverse skill set is valued from programming (R,Python and SQL) to BI tools (Tableau) and not forgetting spreadsheets(Excel) which is still holding on in terms of relevance.
*/