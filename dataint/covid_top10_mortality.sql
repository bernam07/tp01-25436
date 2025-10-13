-- Cria tabela com a média de mortalidade por país

CREATE TABLE IF NOT EXISTS covid_top10_mortality AS
SELECT 
    country_name,
    ROUND(AVG(mortality_rate), 2) AS avg_mortality_rate
FROM covid_annual_metrics
WHERE mortality_rate IS NOT NULL
GROUP BY country_name
ORDER BY avg_mortality_rate DESC
LIMIT 10;

-- Verificar os resultados
SELECT * FROM covid_top10_mortality;
