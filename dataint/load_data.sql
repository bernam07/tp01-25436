USE health_data;

-- Importar códigos ISO

LOAD DATA LOCAL INFILE 'C:/tp01-25436/data/input/iso_country_codes.csv'
INTO TABLE iso_country_codes
FIELDS TERMINATED BY ',' ENCLOSED BY '"' 
IGNORE 1 ROWS
(country_name, iso_alpha2, iso_alpha3);

-- Importar população

LOAD DATA LOCAL INFILE 'C:/tp01-25436/data/input/population_totals.csv'
INTO TABLE population
FIELDS TERMINATED BY ',' ENCLOSED BY '"' 
IGNORE 1 ROWS
(country_name, country_code, `2020`, `2021`, `2022`, `2023`, `2024`);

-- Importar dados COVID

LOAD DATA LOCAL INFILE 'C:/tp01-25436/data/input/cases_deaths.csv'
INTO TABLE cases_deaths
FIELDS TERMINATED BY ',' ENCLOSED BY '"' 
IGNORE 1 ROWS
(country, date, new_cases, total_cases, new_deaths, total_deaths,
new_cases_per_million, new_deaths_per_million,
new_cases_7_day_avg_right, new_deaths_7_day_avg_right,
cfr, cfr_100_cases);
