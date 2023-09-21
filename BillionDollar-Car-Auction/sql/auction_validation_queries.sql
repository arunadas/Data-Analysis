SELECT EXTRACT(YEAR FROM auction_date) AS year,
       ROUND((SUM(adjusted_value)/1000000)::numeric,1) AS adjusted_value_million
FROM car_auction
  GROUP BY EXTRACT(YEAR FROM auction_date)
  ORDER BY 1 DESC


SELECT EXTRACT(YEAR FROM auction_date) AS year,
       make_year,
       ROUND((SUM(adjusted_value)/1000000)::numeric,1) AS adjusted_value_million
FROM car_auction
  GROUP BY EXTRACT(YEAR FROM auction_date),
           make_year
  ORDER BY 1, 2 DESC
  
SELECT auctioneer,
       ROUND((SUM(adjusted_value)/1000000)::numeric,1) AS adjusted_value_million
FROM car_auction
  GROUP BY auctioneer
  ORDER BY 2 DESC  
  

-- Top N cars 
SELECT * FROM (
    SELECT auction_date, make_year, car_brand, serialnumber, round((adjusted_value/1000000)::numeric, 1) AS auction_amount
    FROM car_auction
	ORDER BY auction_amount DESC
    LIMIT 6
) AS subquery1
UNION ALL
SELECT * FROM (
    SELECT auction_date, make_year, car_brand, serialnumber, round((adjusted_value/1000000)::numeric, 1) AS auction_amount
    FROM car_auction
	ORDER BY auction_amount ASC
    LIMIT 5
) AS subquery2;

SELECT auction_date, make_year, car_brand,serialnumber,round((adjusted_value/1000000)::numeric,1)  
FROM car_auction
WHERE make_year >= 1947 AND make_year <= 1975
ORDER BY adjusted_value DESC
LIMIT 5
  
SELECT split_part(car_brand, ' ',1) AS car_brand,
ROUND((SUM(adjusted_value)/1000000)::numeric,1) AS adjusted_value_million 
FROM car_auction 
GROUP BY split_part(car_brand, ' ',1)
ORDER BY 2 DESC 

SELECT CASE 
         WHEN auction_year >= 1980 AND auction_year < 1990 THEN 1980
		 WHEN auction_year >= 1990 AND auction_year < 2000 THEN 1990
		 WHEN auction_year >= 2000 AND auction_year < 2010 THEN 2010
		 WHEN auction_year >= 2010 AND auction_year < 2020 THEN 2020
		 WHEN auction_year >= 2020 AND auction_year < 2030 THEN 2030
		 ELSE NULL
		END AS decade,
		 ROUND((sum(adjusted_value)/(SELECT SUM(adjusted_value) FROM car_auction))::numeric * 100,2) as sales_percentage
		 FROM(
SELECT EXTRACT( YEAR FROM auction_date) AS auction_year,
       adjusted_value
   FROM
      car_auction) AS decade
	  GROUP BY
	  CASE 
         WHEN auction_year >= 1980 AND auction_year < 1990 THEN 1980
		 WHEN auction_year >= 1990 AND auction_year < 2000 THEN 1990
		 WHEN auction_year >= 2000 AND auction_year < 2010 THEN 2010
		 WHEN auction_year >= 2010 AND auction_year < 2020 THEN 2020
		 WHEN auction_year >= 2020 AND auction_year < 2030 THEN 2030
	  END
      ORDER BY decade DESC
	   