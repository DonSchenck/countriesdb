USE countries;
LOAD DATA INFILE '/tmp/countries.csv'
INTO TABLE countries
FIELDS TERMINATED BY '|'
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';