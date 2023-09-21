CREATE TABLE car_auction (  
    auction_date DATE,  
    make_year INT, 
	car_brand VARCHAR(250),
	serialnumber VARCHAR(100),
	auctioneer VARCHAR(50),
	city VARCHAR(50),
	state VARCHAR(50),
	country VARCHAR(50),
	original_value FLOAT,
	adjusted_value FLOAT 
); 

ALTER TABLE car_auction 
ADD CONSTRAINT pk_car_auction PRIMARY KEY (auction_date, serialnumber);