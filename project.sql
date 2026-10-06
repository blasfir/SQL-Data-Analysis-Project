/*SELECT * FROM cohort_users_raw 
LIMIT 10;

SELECT * FROM cohort_events_raw 
LIMIT 10;

WITH t AS (
select *,
replace(
REPLACE(
LEFT(
TRIM(signup_datetime), 
POSITION(' ' IN TRIM(signup_datetime)) - 1),
'/', '-'),
'.', '-')  as date
from cohort_users_raw),
tt as (
select *,
case
	when length(SPLIT_PART(date, '-', 1)) = 2 then SPLIT_PART(date, '-', 1)
	else CONCAT('0', SPLIT_PART(date, '-', 1))
end as day,
case
	when length(SPLIT_PART(date, '-', 2)) = 2 then SPLIT_PART(date, '-', 2)
	else CONCAT('0', SPLIT_PART(date, '-', 2))
end as month,
case
	when length(SPLIT_PART(date, '-', 3)) = 4 then SPLIT_PART(date, '-', 3)
	else CONCAT('20', SPLIT_PART(date, '-', 3))
end as year
from t),
ttt as (
SELECT user_id, promo_signup_flag,
to_date(CONCAT(day, '-', month, '-', year), 'dd-MM-yyyy') as date_timestamp
from tt)
select *
from ttt;



with f AS (
select *,
replace(
REPLACE(
LEFT(
TRIM(event_datetime), 
POSITION(' ' IN TRIM(event_datetime)) - 1),
'/', '-'),
'.', '-')  as date
from cohort_events_raw),
ff as (
select *,
case
	when length(SPLIT_PART(date, '-', 1)) = 2 then SPLIT_PART(date, '-', 1)
	else CONCAT('0', SPLIT_PART(date, '-', 1))
end as day,
case
	when length(SPLIT_PART(date, '-', 2)) = 2 then SPLIT_PART(date, '-', 2)
	else CONCAT('0', SPLIT_PART(date, '-', 2))
end as month,
case
	when length(SPLIT_PART(date, '-', 3)) = 4 then SPLIT_PART(date, '-', 3)
	else CONCAT('20', SPLIT_PART(date, '-', 3))
end as year
from f),
fff as (
SELECT user_id, event_type  
to_date(CONCAT(day, '-', month, '-', year), 'dd-MM-yyyy') as date_timestamp
from ff)
select *
from fff;

WITH t AS (
select *,
replace(
REPLACE(
LEFT(
TRIM(signup_datetime), 
POSITION(' ' IN TRIM(signup_datetime)) - 1),
'/', '-'),
'.', '-')  as date
from cohort_users_raw),
tt as (
select *,
case
	when length(SPLIT_PART(date, '-', 1)) = 2 then SPLIT_PART(date, '-', 1)
	else CONCAT('0', SPLIT_PART(date, '-', 1))
end as day,
case
	when length(SPLIT_PART(date, '-', 2)) = 2 then SPLIT_PART(date, '-', 2)
	else CONCAT('0', SPLIT_PART(date, '-', 2))
end as month,
case
	when length(SPLIT_PART(date, '-', 3)) = 4 then SPLIT_PART(date, '-', 3)
	else CONCAT('20', SPLIT_PART(date, '-', 3))
end as year
from t),
ttt as (
SELECT user_id, promo_signup_flag,
to_date(CONCAT(day, '-', month, '-', year), 'dd-MM-yyyy') as date_signup
from tt),
f AS (
select *,
replace(
REPLACE(
LEFT(
TRIM(event_datetime), 
POSITION(' ' IN TRIM(event_datetime)) - 1),
'/', '-'),
'.', '-')  as date
from cohort_events_raw),
ff as (
select *,
case
	when length(SPLIT_PART(date, '-', 1)) = 2 then SPLIT_PART(date, '-', 1)
	else CONCAT('0', SPLIT_PART(date, '-', 1))
end as day,
case
	when length(SPLIT_PART(date, '-', 2)) = 2 then SPLIT_PART(date, '-', 2)
	else CONCAT('0', SPLIT_PART(date, '-', 2))
end as month,
case
	when length(SPLIT_PART(date, '-', 3)) = 4 then SPLIT_PART(date, '-', 3)
	else CONCAT('20', SPLIT_PART(date, '-', 3))
end as year
from f),
fff as (
SELECT user_id, event_type,  
to_date(CONCAT(day, '-', month, '-', year), 'dd-MM-yyyy') as date_event
from ff)
select 
t.user_id, 
t.promo_signup_flag,
f.event_type,
date(DATE_TRUNC('month', t.date_signup)) as month_signup,
date(DATE_TRUNC('month', f.date_event)) as month_event,
EXTRACT('month' FROM f.date_event) - EXTRACT('month' FROM t.date_signup) as month_offset
from ttt t
FULL OUTER join fff f on t.user_id = f.user_id
where t.date_signup is not null
and f.date_event is not null
and f.event_type is not null
and event_type != 'test_event';
*/

WITH t AS (
select *,
replace(
REPLACE(
LEFT(
TRIM(signup_datetime), 
POSITION(' ' IN TRIM(signup_datetime)) - 1),
'/', '-'),
'.', '-')  as date
from cohort_users_raw),
tt as (
select *,
case
	when length(SPLIT_PART(date, '-', 1)) = 2 then SPLIT_PART(date, '-', 1)
	else CONCAT('0', SPLIT_PART(date, '-', 1))
end as day,
case
	when length(SPLIT_PART(date, '-', 2)) = 2 then SPLIT_PART(date, '-', 2)
	else CONCAT('0', SPLIT_PART(date, '-', 2))
end as month,
case
	when length(SPLIT_PART(date, '-', 3)) = 4 then SPLIT_PART(date, '-', 3)
	else CONCAT('20', SPLIT_PART(date, '-', 3))
end as year
from t),
ttt as (
SELECT user_id, promo_signup_flag,
to_date(CONCAT(day, '-', month, '-', year), 'dd-MM-yyyy') as date_signup
from tt),
f AS (
select *,
replace(
REPLACE(
LEFT(
TRIM(event_datetime), 
POSITION(' ' IN TRIM(event_datetime)) - 1),
'/', '-'),
'.', '-')  as date
from cohort_events_raw),
ff as (
select *,
case
	when length(SPLIT_PART(date, '-', 1)) = 2 then SPLIT_PART(date, '-', 1)
	else CONCAT('0', SPLIT_PART(date, '-', 1))
end as day,
case
	when length(SPLIT_PART(date, '-', 2)) = 2 then SPLIT_PART(date, '-', 2)
	else CONCAT('0', SPLIT_PART(date, '-', 2))
end as month,
case
	when length(SPLIT_PART(date, '-', 3)) = 4 then SPLIT_PART(date, '-', 3)
	else CONCAT('20', SPLIT_PART(date, '-', 3))
end as year
from f),
fff as (
SELECT user_id, event_type,  
to_date(CONCAT(day, '-', month, '-', year), 'dd-MM-yyyy') as date_event
from ff)
select promo_signup_flag, 
month_signup as cohort_month,
month_offset,
count(distinct user_id) as users_total
from (
select 
t.user_id, 
t.promo_signup_flag,
f.event_type,
date(DATE_TRUNC('month', t.date_signup)) as month_signup,
date(DATE_TRUNC('month', f.date_event)) as month_event,
EXTRACT('month' FROM f.date_event) - EXTRACT('month' FROM t.date_signup) as month_offset
from ttt t
FULL OUTER join fff f on t.user_id = f.user_id
where t.date_signup is not null
and f.date_event is not null
and f.event_type is not null
and f.event_type != 'test_event'
and TO_CHAR(f.date_event, 'YYYY-MM') BETWEEN '2025-01' AND '2025-06') as tttfff
group by promo_signup_flag, cohort_month, month_offset
order by promo_signup_flag, cohort_month, month_offset;
