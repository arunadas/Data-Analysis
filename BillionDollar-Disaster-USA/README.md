# Adding Billion Dollar Disaster USA analysis with temperature data
Billion dollar disaster data is from data.gov
Climate data source is NOAA gov site

Data cleaning, enhancement - validation steps:

1. Extracted the disaster data from source then added state information using 
Excel formula 

=TRIM(MID(SUBSTITUTE($A$1, ",", REPT(" ", LEN($A$1))), (ROW()-1)*LEN($A$1)+1, LEN($A$1)))

2. State information was extracted from 
https://www.ncei.noaa.gov/access/billions/events/US/1980-2023?disasters[]=all-disasters

3. Begin and END date where transformed into "YYYY-MM-DD"
Excel formula used - =DATE(VALUE(LEFT(A1,4)), VALUE(MID(A1,5,2)), VALUE(RIGHT(A1,2)))

4. Insert statements populated for each record in excel 
Excel formula for 1st row 
="INSERT INTO usa_disaster values ('" &A3&" ','"&B3&"','"& TEXT(C3,"YYYY-MM-DD") &"','"& TEXT(D3, "YYYY-MM-DD")&"',"&E3&","&F3&",'"&G3&"');"
Value
INSERT INTO usa_disaster values ('Southern Severe Storms and Flooding (April 1980) ','Flooding','1980-04-10','1980-04-17',2636.2,7,'AR');

5. Created usa_disaster table in postgress database
Script is included here

6. Validated the data using primary key constrains.
Remove handful of duplicated as data quality check

7. Insert statements where loaded to table usa_disaster.
Script included

You can find full analysis and more article at below locations:

Medium - https://medium.com/@aruna.das29 
Hashnode - https://arunadas.hashnode.dev/ 

