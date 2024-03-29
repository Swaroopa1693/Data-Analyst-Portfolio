# WORLD LIFE EXPECTANCY PROJECT: EXPLORATORY DATA ANALYSIS
-------------------------------------------------------------------------------------------------------------------------------
#Project Outline:
	# 1. 15-Year Life Expectancy Trend By Country
	# 2. Correlation between life expectancy and GDP
	# 3. Correlation between life expectancy and BMI
	# 4. Average Life Expectancy Comparison: Developed vs. Developing Countries
	# 5. Adult Mortality Impact on Life Expectancy
-------------------------------------------------------------------------------------------------------------------------------
USE world_life_expectancy;
SELECT * FROM world_life_expectancy;

-------------------------------------------------------------------------------------------------------------------------------
#1.  Part 1: life expectancy over the past 15 years
-------------------------------------------------------------------------------------------------------------------------------
			#Retrieving Life Expectancy Growth from 2007 to 2022 by country
			SELECT 
				Country, 
				MIN(`Life expectancy`) AS Min_Life_Expectancy, 
				MAX(`Life expectancy`) AS Max_Life_Expectancy,
				ROUND(MAX(`Life expectancy`) - MIN(`Life expectancy`), 1) AS Life_Increase_15_Years
			FROM world_life_expectancy
			GROUP BY Country
			HAVING 
				MIN(`Life expectancy`) <> 0 AND
				MAX(`Life expectancy`) <> 0
			ORDER BY Life_increase_15_years DESC;

			# average life expectancy each year 

			SELECT Year, ROUND(AVG(`Life expectancy`),1)
			FROM world_life_expectancy
			WHERE 
					`Life expectancy` <> 0 AND
					`Life expectancy` <> 0
			GROUP By Year
			ORDER BY Year;

-------------------------------------------------------------------------------------------------------------------------------
#2.  Part 2: correlation with life expectancy and GDP
-------------------------------------------------------------------------------------------------------------------------------
			#Retrieving average life expectancy and average gdp by country
            
			SELECT 
					Country, 
					ROUND(AVG(`Life expectancy`),1) AS Avg_Life_Exp, 
					ROUND(AVG(GDP)) AS Avg_GDP
			FROM world_life_expectancy
			GROUP BY Country
			HAVING
					Avg_Life_Exp > 0 AND
					Avg_GDP > 0
			ORDER BY Avg_GDP;

			#Retrieving count of high & low GDP countries and their respective average life expectancy for correlation analysis

			SELECT
					SUM(CASE WHEN GDP >= 1500 THEN 1 ELSE 0 END) AS High_GDP_Count,
					ROUND(AVG(CASE WHEN GDP >= 1500 THEN `Life expectancy` ELSE NULL END), 1) AS High_GDP_Life_Expectancy,
					SUM(CASE WHEN GDP <= 1500 THEN 1 ELSE 0 END) AS Low_GDP_Count,
					ROUND(AVG(CASE WHEN GDP <= 1500 THEN `Life expectancy` ELSE NULL END), 1) AS Low_GDP_Life_Expectancy
			FROM world_life_expectancy;
    
-------------------------------------------------------------------------------------------------------------------------------    
#3. Part 3: Average life expectancy comparison: DEVELOPED VS. DEVELOPING countries
-------------------------------------------------------------------------------------------------------------------------------
				# Retrieving the average life expectancy by status of country
				SELECT 
					Status, 
					COUNT(DISTINCT Country) AS Country_Count, 
					ROUND(AVG(`Life expectancy`),1) AS Avg_Life_Exp
				FROM world_life_expectancy
				GROUP BY Status;

-------------------------------------------------------------------------------------------------------------------------------
#4. Part 4:  Correlation with life exp and BMI
-------------------------------------------------------------------------------------------------------------------------------
				#Retrieving average life expectancy and average BMI by country HEADER
				SELECT 
						Country, 
						ROUND(AVG(`Life expectancy`),1) AS Avg_Life_Exp, 
						ROUND(AVG(BMI)) AS Avg_BMI
					FROM world_life_expectancy
					GROUP BY Country
					HAVING
						Avg_Life_Exp > 0 AND
						Avg_BMI > 0
					ORDER BY Avg_BMI DESC;
-------------------------------------------------------------------------------------------------------------------------------
#5. Part 5: Adult Mortality impact on life expectancy
-------------------------------------------------------------------------------------------------------------------------------
				# Retrieving the rolling total of adult mortality by country by year
					SELECT
						Country,
						Year,
						`Life expectancy`,
						`Adult Mortality`,
						SUM(`Adult Mortality`) OVER(PARTITION BY Country ORDER BY Year) AS Adult_Mortality_Rolling_Total
					FROM world_life_expectancy;

#--------------------------------------------------------------#-----------------------------------------------------------------#
