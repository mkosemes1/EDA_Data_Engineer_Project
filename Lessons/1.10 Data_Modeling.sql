select 
    job_id,
    job_title_short,
    salary_hour_avg,
    salary_rate
from data_jobs.job_postings_fact
limit 100;

select 
    company_id,
    name
from data_jobs.company_dim
limit 100;

select *
from company_dim
limit 20;

select *
from information_schema.tables
where table_catalog= 'data_jobs';

select * 
from information_schema.COLUMNS
where table_catalog = 'data_jobs';