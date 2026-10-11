/*
Question: What are the most in-demand skills for data engineers?
- Identify the top 10 in-demand skills for data engineers
- Focus on remote job postings
- Why? Retrieves the top 10 skills with the highest demand in the remote job market,
    providing insights into the most valuable skills for data engineers seeking remote work
*/



select 
    sd.skills,
    count(jpf.*) as demand_count
from job_postings_fact as jpf
inner join skills_job_dim as sjd
    on jpf.job_id = sjd.job_id
inner join skills_dim as sd
    on sjd.skill_id = sd.skill_id
where jpf.job_title_short like '%Data Engineer%'
and jpf.job_work_from_home = true
group by sd.skills
order by demand_count desc
limit 10;


/* he is the breackdown of the most demand skills in Data Engineers.
-SQL and PYTHON are the most demanding skills in the list with around 39 000 job posting each.
nearly double Cloud Platformsround out the top skills with aws leading at ~24514 postings followed by Azure
at ~18 000 postings. Appach Spark complete the top 5 with nearly 17000, hightlighting the importance Big Data skills in Data Engeneering.

key takeways
-SQL and Python remain the foundational skills from Data Engineering
-Cloud Platforms are critical fro modern Data Engineering
-Big Data tools like spark still to be hightly valued in this field
-Data Pipeline tools( Airflow, snowflake, databricks) show growing demand
-java and Kafka round out the top 10 most requested skills in this field
*/

/*
┌────────────┬──────────────┐
│   skills   │ demand_count │
│  varchar   │    int64     │
├────────────┼──────────────┤
│ sql        │        38368 │
│ python     │        38117 │
│ aws        │        24514 │
│ azure      │        18707 │
│ spark      │        17591 │
│ airflow    │        13395 │
│ snowflake  │        11781 │
│ databricks │        10962 │
│ java       │         9993 │
│ kafka      │         9315 │
└────────────┴──────────────┘
  10 rows         2 columns
*/ 