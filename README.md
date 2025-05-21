## 1. Introduction
Data analyst roles are in no doubt in high demand due to its increasing relevance in various organizations and sectors with a competitive remuneration when compared with other tech positions, and hence increasing traction to this tech career path. It’s important for aspiring data analyst to know the required skillsets alongside their respective salary structure to better position themselves for employment opportunities in this field. Our focus is in the Netherlands, a developed tech hub like its other European counterparts and so not left out in demand for Data Analyst. To better secure these roles in the Netherlands there is need for more details like the in-demand skills, company offering these jobs and the average salary offered for the roles.
Objective: Utilize the provided datasets to investigate the top paying data analyst roles in the Netherlands, identify the most in-demand skills for these data analyst roles and compute the average yearly salaries by skills for these roles. For the complete sql queries of this project please [click here](/project_sql).  


## 2. Background
The dataset is a year 2023 compilation of tech job postings from various countries done by Luke Barousse and can be found in [sql_course](https://www.lukebarousse.com/sql).
The dataset consists of three major tables containing information about the job postings and their required skills needed in these roles. Below are the major tables with some of the contained columns;
Job_postings_fact: job_id, job_location, job_title, job_country, salary_year_avg e.t.c
Skills_dim: skill_id, skill and type
Skills_job_dim: job_id, skill_id.
The Sql queries will answer the following questions:
1)	Top paying Data Analyst roles in the Netherlands
2)	Most in-demand skills for these top roles in the Netherlands
3)	The average yearly salary for the most in-demand skills for these top Data analyst roles in the Netherlands.

#### Tools Used 
SQL: programming language used to manipulate and manage the database
Postgres: The relational database management system that was used in storing and querying the structured data 
Visual studio Code: code editor used in executing the Sql queries and managing the database.
Git and Github: Used in version control and sharing of the Sql scripts and analysis creating room for collaboration and project tracking. 

## 3. Analysis
In this part of the project, we intend to answer all the questions in line with meeting the set objectives. We will show the various queries done on the dataset which are needed to investigate the various job positions in other to properly answer the research questions.

#### a. Top paying Data Analyst roles in the Netherlands
In identifying the top paying Data Analyst roles in the Netherlands, the job_postings _facts table was queried for information about Data Analyst job postings specifically for the Netherlands and a Left Join command was used to include the company_dim table in other to include the column containing company names in the result. Result filtering was done to remove all entries with NULL on the salary_year_avg column and another filtering to get the needed result columns.  

``` Sql
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
        job_location ='Netherlands';
```
    
    

![output_1](img_1\output_1.png)
*Table 1.0: Showing Data Analyst Jobs Published by Companies in the Netherlands*  


#### Insights
Salary range: Not so diverse average salary range per year with the lowest being about $74000 and maximum of $155000
Company: The major companies in the Netherlands into hiring of Data Analyst are ING, DEPT and LyondellBasel, with LyondellBasel paying the most for these roles on full time schedule.


#### b. Most in-demand skills for these top roles in the Netherlands
The most in-demand skills for Data Analyst roles in the Netherlands were investigated by building on the above query for top paying Data Analyst roles. The skills_job_dim table, the skills_dim table and the resulting table from the above query were all joined so as to capture the skill_id and skills columns containing skills information for each job postings.  A count of all the job postings was done and grouped by the skills and skill_id columns to show each skill with their respective number of job postings.

``` sql

SELECT 
skill_id,
skills,
COUNT(*) AS job_count
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
        job_location ='Netherlands'
) AS dutch_job
INNER JOIN skills_job_dim 
ON dutch_job.job_id=skills_job_dim.job_id
INNER JOIN skills_dim 
ON skills_job_dim.skill_id=skills_dim.skill_id
) AS high_demand
GROUP BY skill_id, skills
ORDER BY job_count DESC; 

```

| Skill       | job_count|
|-------------|----------|
| cognos      | 1        |
| SQL         | 1        |
| R           | 1        |
| sas         | 1        | 
| excel       | 1        | 
| javascript  | 1        | 
| css         | 1        |        
| html        | 1        |        
| sap         | 1        | 

*Table 1.1: Showing Job Count for the Skills Required for each Data Analyst Job in the Netherlands* 

#### Insights
In-demand skills: The dataset shows an even distribution of the number of job postings for each skill in the Data Analyst role in the Netherlands.
Skills:  From the dataset, the in-demand skills for Data analyst roles in Netherlands are SAS, SQL, EXCEL, R, JAVASCRIPT, HTML, CSS, COGNOS and SAP.

#### c. The average yearly salary for the most in-demand skills for these top Data analyst roles in the Netherlands.
To get the average yearly salary by skill for job postings, we developed on the last query by simply getting the average for the salary_year_avg column, this gave us the average yearly salary for jobs by each in-demand skills. 

``` sql
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
        job_location ='Netherlands'
) AS dutch_job
INNER JOIN skills_job_dim 
ON dutch_job.job_id=skills_job_dim.job_id
INNER JOIN skills_dim 
ON skills_job_dim.skill_id=skills_dim.skill_id
) AS high_demand
GROUP BY skill_id, skills
ORDER BY job_count, avg_salary DESC;

```

![output_3](img_1\output_3.png)
*Table 1.2: Showing Average Yearly Salary for the Top Skills Required for Data Analyst Jobs in the Netherlands* 

#### Insight
Data Analyst Jobs requiring SAP skills appears to pay about twice the salary of other Data Analyst jobs requiring Sql, Cognos, Excel, SAS and R skills. 
 
## 4. Conclusion: 
ING, DEPT and LyondellBasel are the major companies hiring Data Analyst for full time schedule in the Netherlands with salary ranging from $74000 and maximum of $155000 per year depending on skillset. The major skills in-demand are SQL, EXCEL, R, JAVASCRIPT, HTML, CSS, COGNOS and SAP, although Data Analyst with SAP skills appears to earn twice than others with Sql, Cognos, Excel, SAS and R skills. 

## 5. Recommendations:
Aspiring Data Analyst should focus more on learning the above listed in-demand skills with emphases on SAP, Sql, Cognos, Excel, SAS and R skills, in other to be employable to major firms like ING, DEPT and LyondellBasel who are in need of these skills.

#### Limitation:
There is insufficient data for job postings specifically for the Netherlands and also the data worked on is obsolete as it was collected in year 2023, more recent data collection is recommended for job listings in this country to enable better data driven insights and recommendations.

