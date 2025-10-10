CREATE DATABASE IF NOT EXISTS health_data;
USE health_data;

-- ------------------------------------------------------------
-- Tabela: iso_country_codes
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS iso_country_codes (
    country_name VARCHAR(100),
    iso_alpha2 CHAR(2),
    iso_alpha3 CHAR(3),
    PRIMARY KEY (iso_alpha3)
);

-- ------------------------------------------------------------
-- Tabela: population
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS population (
    country_name VARCHAR(100),
    country_code CHAR(3),
    `2020` BIGINT,
    `2021` BIGINT,
    `2022` BIGINT,
    `2023` BIGINT,
    `2024` BIGINT,
    PRIMARY KEY (country_code)
);

-- ------------------------------------------------------------
-- Tabela: cases_deaths
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS cases_deaths (
    id INT AUTO_INCREMENT PRIMARY KEY,
    country VARCHAR(100),
    date DATE,
    new_cases INT,
    total_cases INT,
    new_deaths INT,
    total_deaths INT,
    new_cases_per_million FLOAT,
    new_deaths_per_million FLOAT,
    new_cases_7_day_avg_right FLOAT,
    new_deaths_7_day_avg_right FLOAT,
    cfr FLOAT,
    cfr_100_cases FLOAT,
    country_iso CHAR(3)
);
