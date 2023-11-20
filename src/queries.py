import pandas as pd
import os
from dotenv import load_dotenv
import sqlalchemy as alch

def conection_sql():
    load_dotenv()
    password = os.getenv("password")
    dbName = "heros_mysql"
    connectionData=f"mysql+pymysql://root:{password}@localhost/{dbName}"
    engine = alch.create_engine(connectionData)
    return engine

def csv_query(name, engine):
    try:
        df = pd.read_csv("data/{name}.csv")
        df.to_sql(name, if_exists="replace", con=engine, index=False)
    except:
        name.to_sql(name, if_exists="replace", con=engine, index=False)

def query_sql(query, engine, name):
    pd.read_sql_query(query, engine)
    pd.read_sql_query(query, engine).to_csv(f"data/queries_results/{name}.csv")

def query_superpowers(query, engine):
    superpowers= pd.read_sql_query(query, engine)
    superpowers.columns = superpowers.iloc[0]
    superpowers = superpowers[1:]
    superpowers.reset_index(inplace=True)
    return superpowers