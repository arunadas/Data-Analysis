CREATE TABLE usa_disaster ( 

    name VARCHAR(250), 

    type VARCHAR(100), 

    begin_date DATE, 

    end_date DATE, 

    cost_million FLOAT, 

    deaths INT, 

    state VARCHAR(5) 

); 

  

ALTER TABLE usa_disaster  

ADD CONSTRAINT pk_usa_disaster PRIMARY KEY (name, type, begin_date, end_date,state);