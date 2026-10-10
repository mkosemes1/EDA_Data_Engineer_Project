-- we are asking some query to our databases on MOTHER DUCK

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


pragma show_databases;
pragma show_tables;

-- we are showing a lot of informatio about our tables in data_jobs (db)
pragma show_tables_expanded;

select *
from information_schema.tables 
where table_catalog = 'data_jobs';

describe data_jobs.skills_job_dim;

select table_name, column_name, data_type
from information_schema.columns
where table_catalog = 'data_jobs';