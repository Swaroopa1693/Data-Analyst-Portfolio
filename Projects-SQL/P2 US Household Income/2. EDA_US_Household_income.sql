#EDA on US household income

select * 
from us_household_income;

select state_name, ALand, AWater
from us_household_income;

select state_name, sum(ALand), sum(AWater)
from us_household_income
group by state_name
order by 3 desc;


select state_name, ALand, AWater
from us_household_income
where state_name like '%Alaska%';

select state_name, count(*)
from us_household_income
group by state_name;

select *
from us_household_income u
right join  us_household_income_statistics us
	on u.id = us.id
where u.id IS NULL;

#average household income state wise
select u.state_name, round(avg(mean),2) as avg_mean, round(avg(median),2) as avg_median
from us_household_income u
right join  us_household_income_statistics us
	on u.id = us.id
where mean <> 0 
group by u.state_name
order by 2 desc
limit 10 ;

select type, count(type), round(avg(mean),2) as avg_mean, round(avg(median),2) as avg_median
from us_household_income u
inner join  us_household_income_statistics us
	on u.id = us.id
where mean <> 0 
group by type
order by avg_mean desc ;

select u.state_name, city, round(avg(mean),1) as avg_mean, round(avg(median),1) as avg_median
from us_household_income u
right join  us_household_income_statistics us
	on u.id = us.id
group by u.state_name, city
order by avg_mean desc;
