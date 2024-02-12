#cleaning us_household income

USE US_income;

select * 
from us_household_income;

select * 
from us_household_income_statistics;

select count(*) 
from us_household_income;

select count(*) 
from us_household_income_statistics;

select id, count(id)
from us_household_income
group by id
having count(id) > 1;

delete from us_household_income
where row_id IN
		(select row_id
		from
			(select row_id, 
			id,
			row_number() over(partition by id order by id) row_num
			from us_household_income) duplicates
		where row_num > 1);

# updating state_names

UPDATE us_household_income
set State_name = 'Alabama'
where State_name = 'alabama';

select state_name, count(*)
from us_household_income
group by state_name;

UPDATE us_household_income
set State_name = 'Georgia'
where State_name = 'georia';

select type, count(*)
from us_household_income
group by type;

UPDATE us_household_income
set Type = 'Borough'
where Type = 'Boroughs';


UPDATE us_household_income
set Place = 'Autaugaville'
where county = 'Autauga County'
and city = 'Vinemont';

select *
from us_household_income
where county = 'Autauga County'
AND place = ' ';

select ALand, AWater
from us_household_income
where (AWater = ' ' or AWater = 0 or AWater IS NULL)
AND  (ALand = ' ' or ALand = 0 or ALand IS NULL);

select ALand, AWater
from us_household_income
where  (ALand = ' ' or ALand = 0 or ALand IS NULL);

