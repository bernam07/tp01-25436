USE health_data;

-- Normalizar países (preencher country_iso)
UPDATE cases_deaths c
JOIN iso_country_codes i ON c.country = i.country_name
SET c.country_iso = i.iso_alpha3;

-- Verificar países sem código ISO
SELECT DISTINCT country
FROM cases_deaths
WHERE country_iso IS NULL;

-- Exemplo de correção manual:
-- UPDATE cases_deaths SET country_iso = 'USA' WHERE country = 'United States';
