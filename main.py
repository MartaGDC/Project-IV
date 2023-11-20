from src.cleaning import clean
from src.queries import conection_sql

# Clean data
clean("data/original_superheros.csv", "heros")

# Connection:
engine = conection_sql()