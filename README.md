# TP01 - Integração de Dados de Saúde Pública (COVID-19)

## Autor
- Nome: Bernardo Martins  
- Nº de Aluno: 25436 
- UC: Integração de Sistemas de Informação (3º ano)  

## Estrutura

tp01-25436/
│
├── doc/ → relatório final (PDF)
├── dataint/ → scripts SQL e Node-RED flow
├── data/input/ → ficheiros CSV
├── data/output/ → ficheiros resultantes (ex. métricas anuais)
└── src/ → código adicional (opcional)

## Como executar

1. Instalar **MySQL** e **Node-RED**
2. Importar os ficheiros `.csv` na BD (usar `LOAD DATA LOCAL INFILE`)
3. Executar o script `covid_etl.sql`
4. Iniciar Node-RED e importar `node-red-flow.json`
5. Abrir o dashboard em http://localhost:1880/ui
6. Visualizar os gráficos e métricas

## Dados

- Casos e Mortes COVID (`cases_deaths.csv`)
- População (`population_totals.csv`)
- Códigos ISO (`iso_country_codes.csv`)
- Output: tabela `covid_annual_metrics`

## Ferramentas

- MySQL Workbench 8.0
- Node-RED v3.1 + Dashboard 2.0
- PowerShell / CMD (para testar comandos)