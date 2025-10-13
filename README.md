# TP01 – Integração de Dados de Saúde Pública (COVID-19)

## Autor
- **Nome:** Bernardo Martins  
- **Nº de Aluno:** 25436  
- **UC:** Integração de Sistemas de Informação (3º Ano, LESI)  
- **Ano Letivo:** 2025/26  

---

**Objetivo:**  

Integrar dados de casos e mortes por COVID-19 com dados populacionais (World Bank) e gerar métricas anuais por 100 000 habitantes, utilizando MySQL, Node-RED e Python.

---

## Estrutura do Projeto

```
tp01-25436/
│
├── README.md
│
├── doc/
│   └── tp01_25436_doc.pdf                ← Relatório final
│
├── dataint/
│   ├── create_tables.sql
│   ├── load_data.sql
│   ├── transform.sql
│   ├── covid_annual_metrics.sql
│   ├── node-red-flow.json                ← Flow completo do Node-RED
│   ├── node-red-mortality-rate.json                ← Flow mortalidade do Node-RED
│   ├── add_mortality_rate.sql
│   └── covid_total_deaths.sql
│
├── data/
│   ├── input/
│   │   ├── population_totals.csv
│   │   ├── iso_country_codes.csv
│   │   └── cases_deaths.csv (no Drive)
│   │
│   └── output/
│       ├── covid_annual_metrics.csv      ← Export gerado pelo Python
│       ├── dashboard_geral.png      ← Print do dashboard geral
│       ├── dashboards.png      ← Print dos dashboards individuais
│       ├── dashboard_mortality_rate.png      ← Print do dashboard de mortalidade  
│       └── top10_total_deaths.csv      ← Export gerado pelo Python 
│
└── src/
    ├── export_data.py              ← Script Python de exportação
    └── export_top10_deaths.py              ← Script Python de exportação top 10
```

---

## Dados Utilizados

| Ficheiro | Descrição | Fonte |
|-----------|------------|--------|
| `cases_deaths.csv` | Dados COVID-19 (casos e mortes por país) | Our World in Data |
| `population_totals.csv` | População total por país (2020–2024) | World Bank |
| `iso_country_codes.csv` | Códigos ISO Alpha-2 e Alpha-3 | ISO.org |

**O ficheiro `cases_deaths.csv` (160 MB)** encontra-se disponível em:  
(https://drive.google.com/file/d/14S-5q1-pFyIkXB_FGWjGEWSrDnKOV189/view?usp=drive_link)

---

## Ferramentas Utilizadas

- **MySQL 8.0** – Base de dados e transformações ETL  
- **MySQL Workbench** – Importação e execução de queries  
- **Node-RED 3.1 + Dashboard 2.0** – Visualização dos resultados  
- **Python 3.14.0** – Exportação automática dos dados finais  
- **VS Code / GitHub** – Documentação e versões  

---

## Como Executar o Projeto

### 1. Configurar a Base de Dados (MySQL)

1. Criar a base de dados:
   ```sql
   CREATE DATABASE health_data;
   USE health_data;
   ```
2. Executar os scripts SQL da pasta `dataint/` pela seguinte ordem:
   1. `create_tables.sql`
   2. `load_data.sql`
   3. `transform.sql`
   4. `covid_annual_metrics.sql`

3. Confirmar que a tabela `covid_annual_metrics` foi criada com sucesso.

4. Executar o script SQL `add_mortality_rate.sql` e verificar as alterações na tabela `covid_annual_metrics`.

5. Executar o script SQL `covid_total_deaths.sql` e confirmar que a tabela `covid_total_deaths` foi criada com sucesso.

---

### 2. Executar o Node-RED Dashboard
1. Iniciar o Node-RED:
   ```bash
   node-red
   ```
2. Aceder a [http://localhost:1880]http://localhost:1880  
3. Menu → **Import** → colar o conteúdo de `dataint/node-red-flow.json` 
4. Clicar em **Deploy**
5. Repetir o processo num flow diferente, usando o conteúdo de `dataint/node-red-mortality-rate.json`
6. Abrir o dashboard em:  [http://localhost:1880/ui]http://localhost:1880/ui


#### Separadores do dashboard:

- **Geral:** visão global com todos os países (forma de testar a integração)  
- **Países:** gráficos individuais para Portugal, França e Alemanha  
- **Estatísticas:** evolução da taxa de mortalidade entre Portugal, França e Alemanha  
---

### 3. Exportar Dados com Python
1. Instalar Python e os pacotes necessários:
   ```bash
   pip install pandas mysql-connector-python
   ```
2. Executar o script:
   ```bash
   python src/export_data.py
   ```
3. O ficheiro vai ser criado em:
   ```
   data/output/covid_annual_metrics.csv
   ```
4. Executar o script:
   ```bash
   python src/export_top10_deaths.py
   ``` 
5. O ficheiro vai ser criado em:
   ```
   data/output/top10_total_deaths.csv
   ```
---

## Resultados

- Gráficos de evolução anual (Casos e Mortes / 100k habitantes)  
- Tabela `covid_annual_metrics` agregada por país e ano  
- Comparação visual entre Portugal, França e Alemanha
- Apresentação do indíce de mortalidade tanto em tabela como graficamente
- Tabela `covid_total_deaths` com o número total de mortes por país

---

## Observações

- Os dados originais estão acessíveis via Google Drive (ver link acima).  
- Todos os ficheiros seguem a estrutura exigida no enunciado.  
- O flow Node-RED e os scripts SQL são reutilizáveis noutros datasets similares.  

---

10/2025 — **Trabalho Prático 01 – Integração de Sistemas de Informação (LESI)**
