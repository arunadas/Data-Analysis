# Adding Billion Dollar car auction
Billion dollar car auction analysis

Data cleaning, enhancement - validation steps:

1. Extracted the disaster data from source then added state information using 
web scrapping using excel

IMPORTHTML(""https://en.wikipedia.org/wiki/List_of_most_expensive_cars_sold_at_auction"",""table"",4)

2. Car auction information was extracted from 
https://en.wikipedia.org/wiki/List_of_most_expensive_cars_sold_at_auction

3. Auction date where transformed into "YYYY-MM-DD"
Excel date format function 

4. Insert statements populated for each record in excel 
Excel formula for 1st row 
INSERT INTO car_auction values ('2018-12-08 ',1956,'Ferrari 290 MM','628','RM Sotheby''s','Los Angeles',' California',' United States',22005000,25644000);
You can find the scripts under sql


5. Created car_auction table in postgress database
Script is included here

6. Validated the data using primary key constrains.
Remove handful of duplicated as data quality check

7. Insert statements where loaded to table car_auction.
Script included

You can find full analysis and more article at below locations:

Medium - https://medium.com/@aruna.das29 
Hashnode - https://arunadas.hashnode.dev/ 

