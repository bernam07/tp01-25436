import mysql.connector
import pandas as pd

# Configuração da conexão MySQL
config = {
    "host": "localhost",
    "user": "root",
    "password": "bernardo123",
    "database": "health_data"
}

# Query - Top 10 países com mais mortes
query = """
SELECT 
    country_name,
    total_deaths_all_years
FROM covid_total_deaths
ORDER BY total_deaths_all_years DESC
LIMIT 10;
"""

# Conectar ao MySQL e extrair dados
try:
    conn = mysql.connector.connect(**config)
    df = pd.read_sql(query, conn)
    conn.close()

    # Exportar para CSV
    output_path = "C:/tp01-25436/data/output/top10_total_deaths.csv"
    df.to_csv(output_path, index=False, encoding="utf-8-sig")

    print("Exportação concluída com sucesso!")
    print(f"Ficheiro guardado em: {output_path}")
    print("\nTop 10 países com mais mortes:")
    print(df)

except mysql.connector.Error as err:
    print(f"Erro ao conectar ao MySQL: {err}")
