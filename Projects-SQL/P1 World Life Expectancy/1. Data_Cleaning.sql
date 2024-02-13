#WORLD LIFE EXPECTANCY PROJECT: DATA CLEANING
------------------------------------------------------------------------------------------------------------------------------
	#Project Outline:
		# 1. Removing Duplicates
                # 2. Dealing with Null/Blank Values
		# 3. Populating missing values with average
------------------------------------------------------------------------------------------------------------------------------
	
	SELECT * FROM world_life_expectancy;

------------------------------------------------------------------------------------------------------------------------------
#1. Part 1: finding duplicate values
------------------------------------------------------------------------------------------------------------------------------
		#1. Verifying if there are duplicate rows

				SELECT country,
					year, 
					count(concat(country, year))
				FROM world_life_expectancy
				GROUP BY country, year
				HAVING count(concat(country, year)) > 1;

				#2. Locating Row_Id for duplicate rows
					
				SELECT *
				FROM
					(SELECT Row_id,
						concat(country, year),
						ROW_NUMBER() OVER(PARTITION BY concat(country, year) ORDER BY concat(country, year)) as row_num
						FROM world_life_expectancy) as row_table
				WHERE row_num > 1;


				#3. Removing duplicate rows from table
				DELETE FROM world_life_expectancy
				WHERE
						Row_ID IN 
						 (SELECT Row_ID
				FROM
						 (SELECT Row_id,
						 concat(country, year),
						 ROW_NUMBER() OVER(PARTITION BY concat(country, year) ORDER BY concat(country, year)) as row_num
						 FROM world_life_expectancy) as row_table
				WHERE row_num > 1);

------------------------------------------------------------------------------------------------------------------------------
#2. Part 2: filling blanks with values
------------------------------------------------------------------------------------------------------------------------------
				#'Status' Column: Checking for blank values in 'Status' column

				SELECT DISTINCT(status)
				FROM world_life_expectancy
				WHERE status <> ' ' ;

				select * 
				from world_life_expectancy
				where status = ' ' ;

				# 'Status' Column: Setting up code to add to UPDATE Statement
				SELECT *
				FROM world_life_expectancy t1
				JOIN world_life_expectancy t2
						ON t1.Country = t2.Country
				WHERE
						t1.Status = ''
						AND t2.Status <> ''
						AND t2.Status = 'Developing';

				SELECT *
				FROM world_life_expectancy t1
				JOIN world_life_expectancy t2
						ON t1.Country = t2.Country
				WHERE
						t1.Status = ''
						AND t2.Status <> ''
						AND t2.Status = 'Developed';

				#'Status' Column: Updating table to populate 'Status' Column based on information from different rows

				UPDATE  world_life_expectancy t1
				JOIN world_life_expectancy t2
								ON t1.Country = t2.Country
				SET t1.status = 'Developing'
								WHERE t1.status = ' '
								and t2.status <> ' '
								and t2.status = 'Developing';

				UPDATE world_life_expectancy t1
				JOIN world_life_expectancy t2
								ON t1.Country = t2.Country
				SET t1.status = 'Developed'
								WHERE t1.status = ' '
								and t2.status <> ' '
								and t2.status = 'Developed';

				SELECT t1.country, t1.status, t2.country, t2.status
				FROM worldlifexpectancy_backup t1
				JOIN worldlifexpectancy_backup t2
					ON t1.Country = t2.Country;
------------------------------------------------------------------------------------------------------------------------------    
#3. Part 3: populating life expectancy missing values with average
------------------------------------------------------------------------------------------------------------------------------
				SELECT  t1.country, t1.year, t1.`lifeexpectancy`, t2.country, t2.year, t2.`lifeexpectancy`
				FROM world_life_expectancy t1
				JOIN world_life_expectancy t2
					ON t1.year = t2.year - 1;


				SELECT country,year, `lifeexpectancy`
				FROM world_life_expectancy;

				#'Life expectancy' Column: Setting up code to add to UPDATE Statement
                
				SELECT w1.country, w1.year, w1.`lifeexpectancy`,
								w2.country, w2.year, w2.`lifeexpectancy`,
								w3.country, w3.year, w3.`lifeexpectancy`,
								round((w2.`lifeexpectancy` +  w3.`lifeexpectancy`)/ 2,1)
				FROM world_life_expectancy w1
				JOIN world_life_expectancy w2
								ON w1.country = w2.country
								AND w1.year = w2.year -1
				JOIN world_life_expectancy w3
								ON w1.country = w3.country
								AND w1.year = w3.year + 1
				WHERE w1.`lifeexpectancy` = ' ' ;


				UPDATE world_life_expectancy w1
				JOIN world_life_expectancy w2
						ON w1.country = w2.country
						AND w1.year = w2.year -1
				JOIN world_life_expectancy w3
						ON w1.country = w3.country
						AND w1.year = w3.year +1
				SET w1.`lifeexpectancy` = round((w2.`lifeexpectancy` +  w3.`lifeexpectancy`)/ 2,1)
				WHERE w1.`lifeexpectancy` = ' ' ;

#-------------------------------------------------------------#-----------------------------------------------------------------#
					
				





