-- Cria tabela com o número total de mortes por país

CREATE TABLE covid_total_deaths AS
SELECT 
    country_iso,
    country_name,
    SUM(total_deaths) AS total_deaths_all_years
FROM covid_annual_metrics
GROUP BY country_iso, country_name;
