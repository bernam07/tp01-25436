USE health_data;

-- Criar tabela covid_annual_metrics que engloba a junção dos dados das 3 tabelas originais

CREATE TABLE IF NOT EXISTS covid_annual_metrics (
    country_iso CHAR(3) NOT NULL,
    country_name VARCHAR(100),
    year INT NOT NULL,
    total_cases BIGINT,
    total_deaths BIGINT,
    population BIGINT,
    cases_per_100k FLOAT,
    deaths_per_100k FLOAT,
    PRIMARY KEY (country_iso, year)
);

INSERT INTO covid_annual_metrics (country_iso, country_name, year, total_cases, total_deaths, population, cases_per_100k, deaths_per_100k)
SELECT
    t.country_iso,
    ic.country_name,
    t.year,
    t.total_cases,
    t.total_deaths,
    CASE t.year
        WHEN 2020 THEN p.`2020`
        WHEN 2021 THEN p.`2021`
        WHEN 2022 THEN p.`2022`
        WHEN 2023 THEN p.`2023`
        WHEN 2024 THEN p.`2024`
    END AS population,
    ROUND((t.total_cases / NULLIF(
      CASE t.year
        WHEN 2020 THEN p.`2020`
        WHEN 2021 THEN p.`2021`
        WHEN 2022 THEN p.`2022`
        WHEN 2023 THEN p.`2023`
        WHEN 2024 THEN p.`2024`
      END, 0)) * 100000, 2) AS cases_per_100k,
    ROUND((t.total_deaths / NULLIF(
      CASE t.year
        WHEN 2020 THEN p.`2020`
        WHEN 2021 THEN p.`2021`
        WHEN 2022 THEN p.`2022`
        WHEN 2023 THEN p.`2023`
        WHEN 2024 THEN p.`2024`
      END, 0)) * 100000, 2) AS deaths_per_100k
FROM (
    SELECT
        country_iso,
        YEAR(date) AS year,
        SUM(new_cases) AS total_cases,
        SUM(new_deaths) AS total_deaths
    FROM cases_deaths
    WHERE YEAR(date) BETWEEN 2020 AND 2024
    GROUP BY country_iso, YEAR(date)
) t
JOIN population p ON t.country_iso = p.country_code
LEFT JOIN iso_country_codes ic ON t.country_iso = ic.iso_alpha3
ORDER BY t.country_iso, t.year;
