-- Adicionar coluna para o índice de mortalidade
ALTER TABLE covid_annual_metrics ADD COLUMN mortality_rate FLOAT;

-- Desligar o Safe_Update por causa da PK
SET SQL_SAFE_UPDATES = 0;

UPDATE covid_annual_metrics
SET mortality_rate = 
    CASE WHEN total_cases > 0 THEN (total_deaths / total_cases) * 100 ELSE 0 END;

SET SQL_SAFE_UPDATES = 1;

-- Remover coluna
ALTER TABLE covid_annual_metrics
DROP COLUMN mortality_rate;






