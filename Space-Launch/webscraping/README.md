# Data-source
I have used https://nextspaceflight.com for webscapping past launch data 
The code will not run as-is , I have removed the logic of full scrapping and reference to the site if you choose to use this script please be mindful of the website you are scrapping 
and try to not overload it.

# Other Data sources
For below sources I have used import html web scrapping capability.
https://www.nanosats.eu 
https://en.wikipedia.org 


# Data cleaning process
1. scrape the data from various sources
2. Analyse the columns you want in your data analysis
3. Remove the columns you don't want to use in your analysis
4. Further analyse the columns and ensure the quality by following checklist:
    a - Identify missing , null values and handle them accordingly
    b - Format using excel functions like =DATEVALUE(MID(A1,5,3)&" "&MID(A1,9,2)&", "&MID(A1,13,4))+TIMEVALUE(MID(A1,18,5))
    c - Ensure the price column metrices are handles to appropriate decimal places
5. Once satisfied after cleaning process run data analysis stats either using R or sql , for this project I used both on couple of files just for practice. 
6. Data included here in <data> folder is cleaned and analysed which I used in tableau visualization.     


