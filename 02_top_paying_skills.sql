/*
Question: What are the highest-paying skills for data engineers?
- Calculate the median salary for each skill required in data engineer positions
- Focus on remote positions with specified salaries
- Include skill frequency to identify both salary and demand
- Why? Helps identify which skills command the highest compensation while also showing 
    how common those skills are, providing a more complete picture for skill development priorities
*/


select 
    sd.skills,
    round(median(jpf.salary_year_avg), 2) as median_salary,
    count(jpf.*) as demand_count

from job_postings_fact as jpf
inner join skills_job_dim as sjd
on jpf.job_id = sjd.job_id
inner join skills_dim as sd
on sjd.skill_id = sd.skill_id
where jpf.job_title_short  = 'Data Engineer' AND
jpf.job_work_from_home = true
group by sd.skills
HAVING 
    count(jpf.*) > 100
order by median_salary desc
limit 10;

/*

key takeways
In this amount of data Rust remains the top paying skill at 210 000$  median salary but this skill demand still relatively limited( only 232 postings)
In this same data Terraform, goland , Spring and Neo4j occupy the 4 remaining places of the top 5 paying skill with 175000$ on average for the median
We see also mongodb and fastapi in the top 10 which are commonly integrated to build high-performance
┌────────────┬───────────────┬──────────────┐
│   skills   │ median_salary │ demand_count │
│  varchar   │    double     │    int64     │
├────────────┼───────────────┼──────────────┤
│ rust       │      210000.0 │          232 │
│ terraform  │      184000.0 │         3248 │
│ golang     │      184000.0 │          912 │
│ spring     │      175500.0 │          364 │
│ neo4j      │      170000.0 │          277 │
│ gdpr       │      169615.5 │          582 │
│ zoom       │      168437.5 │          127 │
│ graphql    │      167500.0 │          445 │
│ mongo      │      162250.0 │          265 │
│ fastapi    │      157500.0 │          204 │
│ bitbucket  │      155000.0 │          478 │
│ django     │      155000.0 │          265 │
│ crystal    │      154223.5 │          129 │
│ c          │      151500.0 │          444 │
│ atlassian  │      151500.0 │          249 │
│ typescript │      151000.0 │          388 │
│ kubernetes │      150500.0 │         4202 │
│ node       │      150000.0 │          179 │
│ airflow    │      150000.0 │         9996 │
│ css        │      150000.0 │          262 │
│ ruby       │      150000.0 │          736 │
│ redis      │      149000.0 │          605 │
│ ansible    │     148798.25 │          475 │
│ vmware     │     148798.25 │          136 │
│ jupyter    │      147500.0 │          400 │
│ visio      │      146500.0 │          105 │
│ kafka      │      145000.0 │         6415 │
│ go         │      140000.0 │         1997 │
│ pyspark    │      140000.0 │         4898 │
│ git        │      140000.0 │         4641 │
└────────────┴───────────────┴──────────────┘
*/