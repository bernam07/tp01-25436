import pandas as pd
import mysql.connector

# Configuração da base de dados
conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="bernardo123",
    database="health_data"
)

# Query para obter os dados finais
sql = "SELECT * FROM covid_annual_metrics;"

# Ler dados e exportar para CSV
df = pd.read_sql(sql, conn)
conn.close()

# Exportar para o ficheiro final
output_path = "C:/tp01-25436/data/output/covid_annual_metrics.csv"
df.to_csv(output_path, index=False)

print(f"Export completo! Ficheiro criado em: {output_path}")
