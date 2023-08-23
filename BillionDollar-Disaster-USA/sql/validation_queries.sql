-- Natural climate disaster from 1980 to 2023 
SELECT  state , COUNT(1) as disaster_count
	FROM usa_disaster
	GROUP BY state
	ORDER BY state

-- Which disaster event was active more than 90 days in a given year? 
WITH max_days AS (
    SELECT
        DATE_PART('year', begin_date) AS yr,
        MAX(end_date - begin_date) AS max_days
    FROM
        usa_disaster
    GROUP BY
        DATE_PART('year', begin_date)
),
descr AS (
    SELECT
        DISTINCT name,
        type,
        begin_date,
        end_date,
        (end_date - begin_date) AS days,
        DATE_PART('year', begin_date) AS yr
    FROM
        usa_disaster
)
SELECT
    *
FROM
    descr
WHERE
    (days, yr) IN (SELECT max_days, yr FROM max_days)
    AND days >= 90
ORDER BY
    yr;

-- Which disaster event claim at least 100 lives?
WITH max_deaths AS (
    SELECT
        DATE_PART('year', begin_date) AS yr,
        MAX(deaths) AS max_deaths
    FROM
        usa_disaster
    GROUP BY
        DATE_PART('year', begin_date)
),
descr AS (
    SELECT
        DISTINCT name,
        type,
	    deaths,
        DATE_PART('year', begin_date) AS yr
    FROM
        usa_disaster
)
SELECT
    *
FROM
    descr
WHERE
    (deaths, yr) IN (SELECT max_deaths, yr FROM max_deaths)
     AND deaths >= 100
ORDER BY
    yr;


-- total sum of $ expenditure in events
SELECT 
   ROUND(SUM(cost_million/1000)) AS total_cost_billion
FROM usa_disaster;

-- % dollar expenditure in billion by disaster type
    WITH total_sum AS (
		SELECT 
		   ROUND(SUM(cost_million/1000)) AS total_cost_billion
		FROM usa_disaster
	),
	disaster_sum AS (
		SELECT 
		   type AS Disaster_type,
		   ROUND(SUM(cost_million/1000)) AS total_cost_billion
		FROM usa_disaster
		GROUP BY type
	) 
	SELECT 
	   Disaster_type,
	   ROUND(CAST(total_cost_billion/(select * FROM total_sum) * 100 AS numeric)  , 2) AS percentage_total
	FROM  disaster_sum  
	ORDER BY percentage_total DESC




