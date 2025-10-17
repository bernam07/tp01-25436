import pandas as pd
from sqlalchemy import create_engine, text
import sys

# 1. CAMINHOS PARA OS FICHEIROS CSV

path_iso_codes = 'C:/tp01-25436/data/input/iso_country_codes.csv'
path_population = 'C:/tp01-25436/data/input/population_totals.csv'
path_cases_deaths = 'C:/tp01-25436/data/input/cases_deaths.csv'

# 2. LIGAÇÃO À BASE DE DADOS

db_user = 'root'
db_password = 'bernardo123'
db_host = 'localhost'
db_port = '3306'
db_name = 'health_data'

try:
    engine = create_engine(f"mysql+mysqlconnector://{db_user}:{db_password}@{db_host}:{db_port}/{db_name}")
    print("Ligação à base de dados estabelecida com sucesso.")
except Exception as e:
    print(f"Erro: Não foi possível ligar à base de dados. Verifica os dados.")
    print(e)
    sys.exit() # Termina o script se não conseguir ligar

def carregar_iso_codes():
    """Lê o CSV de códigos ISO, seleciona as colunas e carrega para o MySQL."""
    try:
        print("\n1/3 - A processar 'iso_country_codes.csv'...")
        df = pd.read_csv(path_iso_codes)
        # Seleciona e renomeia as colunas para corresponderem à tabela
        df_iso = df.iloc[:, 0:3]
        df_iso.columns = ['country_name', 'iso_alpha2', 'iso_alpha3']
        # Escreve o dataframe para a tabela SQL, substituindo o conteúdo existente
        df_iso.to_sql('iso_country_codes', con=engine, if_exists='replace', index=False)
        print("Tabela 'iso_country_codes' carregada.")
    except Exception as e:
        print(f"Erro ao processar 'iso_country_codes.csv': {e}")
        sys.exit()

def carregar_population():
    """Lê o CSV da população, seleciona as colunas de 2020-2024 e carrega."""
    try:
        print("\n2/3 - A processar 'population_totals.csv'...")
        df = pd.read_csv(path_population)
        # Seleciona as colunas relevantes
        cols_to_keep = ['Country Name', 'Country Code', '2020', '2021', '2022', '2023', '2024']
        df_pop = df[cols_to_keep]
        # Renomeia as colunas para corresponderem à tabela
        df_pop.columns = ['country_name', 'country_code', '2020', '2021', '2022', '2023', '2024']
        df_pop.to_sql('population', con=engine, if_exists='replace', index=False)
        print("Tabela 'population' carregada.")
    except Exception as e:
        print(f"Erro ao processar 'population_totals.csv': {e}")
        sys.exit()

def carregar_cases_deaths():
    """Lê o CSV grande em partes e carrega para o MySQL."""
    try:
        print("\n3/3- A processar o ficheiro 'cases_deaths.csv'...")
        chunk_iter = pd.read_csv(path_cases_deaths, chunksize=50000)
        
        for chunk in chunk_iter:
            df_chunk = chunk.iloc[:, 0:6]
            df_chunk.columns = ['country', 'date', 'new_cases', 'total_cases', 'new_deaths', 'total_deaths']
            df_chunk['date'] = pd.to_datetime(df_chunk['date'])
            df_chunk.to_sql('cases_deaths', con=engine, if_exists='append', index=False)
            print("  -> Carregadas 50,000 linhas...")
        print("  -> Tabela 'cases_deaths' carregada.")
    except Exception as e:
        print(f"Erro ao processar 'cases_deaths.csv': {e}")
        sys.exit()

if __name__ == '__main__':
    print("A limpar tabelas existentes...")
    with engine.connect() as connection:
        connection.execute(text('TRUNCATE TABLE iso_country_codes;'))
        connection.execute(text('TRUNCATE TABLE population;'))
        connection.execute(text('TRUNCATE TABLE cases_deaths;'))
        print("Tabelas limpas.")

    carregar_iso_codes()
    carregar_population()
    carregar_cases_deaths()

    print("\nProcesso de carregamento de dados concluído com sucesso!")