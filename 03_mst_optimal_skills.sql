/*
Question: What are the most optimal skills for data engineers—balancing both demand and salary?
- Create a ranking column that combines demand count and median salary to identify the most valuable skills.
- Focus only on remote Data Engineer positions with specified annual salaries.
- Why?
    - This approach highlights skills that balance market demand and financial reward. It weights core skills appropriately instead of letting rare, outlier skills distort the results.
*/


select 
    sd.skills,
    round(median(jpf.salary_year_avg), 2) as median_salary,
    round(LN(count(jpf.salary_year_avg)), 1) as demand_count,
    round(median(jpf.salary_year_avg), 2) * round(LN(count(jpf.salary_year_avg)), 1)/1_000_000 as optimal_score
    
from job_postings_fact as jpf
inner join skills_job_dim as sjd
on jpf.job_id = sjd.job_id
inner join skills_dim as sd
on sjd.skill_id = sd.skill_id
where jpf.job_title_short  = 'Data Engineer' AND
jpf.job_work_from_home = true and jpf.salary_year_avg is not null
group by sd.skills
HAVING 
    count(jpf.*) > 100
order by optimal_score desc
limit 25;

/*
Here's a breakdown of the most optimal skills for Data Engineers, based on both high demand and high salaries:

Top Skills by Optimal Score:
- Terraform leads the list with a $184K median salary and 193 postings, resulting in the highest overall "optimal score".
- Python and SQL dominate demand (over 1100 postings each), with strong median salaries of $135K and $130K, respectively.
- AWS (783 postings, $137K median), Spark (503 postings, $140K median), and Airflow (386 postings, $150K median) are all highly sought-after cloud and big data technologies.
- Kafka offers high compensation ($145K median) and solid demand (292 postings).
- Tools like Snowflake, Azure, and Databricks each have 250–475 postings and median salaries between $128–$137K.
┌────────────┬───────────────┬──────────────┬────────────────────┐
│   skills   │ median_salary │ demand_count │   optimal_score    │
│  varchar   │    double     │    double    │       double       │
├────────────┼───────────────┼──────────────┼────────────────────┤
│ terraform  │      184000.0 │          5.3 │             0.9752 │
│ python     │      135000.0 │          7.0 │              0.945 │
│ aws        │     137320.31 │          6.7 │ 0.9200460770000001 │
│ sql        │      130000.0 │          7.0 │               0.91 │
│ airflow    │      150000.0 │          6.0 │                0.9 │
│ spark      │      140000.0 │          6.2 │              0.868 │
│ snowflake  │      135500.0 │          6.1 │            0.82655 │
│ kafka      │      145000.0 │          5.7 │             0.8265 │
│ azure      │      128000.0 │          6.2 │             0.7936 │
│ java       │      135000.0 │          5.7 │             0.7695 │
│ scala      │     137290.48 │          5.5 │         0.75509764 │
│ kubernetes │      150500.0 │          5.0 │             0.7525 │
│ databricks │      132750.0 │          5.6 │             0.7434 │
│ git        │      140000.0 │          5.3 │              0.742 │
│ redshift   │      130000.0 │          5.6 │              0.728 │
│ gcp        │      136000.0 │          5.3 │             0.7208 │
│ hadoop     │      135000.0 │          5.3 │             0.7155 │
│ nosql      │      134415.0 │          5.3 │          0.7123995 │
│ pyspark    │      140000.0 │          5.0 │                0.7 │
│ docker     │      135000.0 │          5.0 │              0.675 │
│ mongodb    │      135750.0 │          4.9 │           0.665175 │
│ r          │      134775.0 │          4.9 │          0.6603975 │
│ go         │      140000.0 │          4.7 │              0.658 │
│ github     │      135000.0 │          4.8 │              0.648 │
│ bigquery   │      135000.0 │          4.8 │              0.648 │
└────────────┴───────────────┴──────────────┴────────────────────┘
*/