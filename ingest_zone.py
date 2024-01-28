import pandas as pd
from sqlalchemy import create_engine
import os
import argparse

def main(params):
    user = params.user
    password = params.password
    host = params.host 
    port = params.port 
    db = params.db
    table_name = "zones"
    url = "https://s3.amazonaws.com/nyc-tlc/misc/taxi+_zone_lookup.csv"
    csv_name = "taxi_zone_lookup.csv"

    os.system(f"wget {url} -O {csv_name}")

    # Read CSV into a DataFrame
    df = pd.read_csv(csv_name)

    # Create a PostgreSQL engine
    engine = create_engine(f'postgresql://{user}:{password}@{host}:{port}/{db}')

    # Write DataFrame to PostgreSQL
    df.head(n=0).to_sql(name=table_name, con=engine, if_exists='replace')
    df.to_sql(name=table_name, con=engine, if_exists='append')

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Ingest CSV data to Postgres')

    parser.add_argument('--user', required=True, help='user name for postgres')
    parser.add_argument('--password', required=True, help='password for postgres')
    parser.add_argument('--host', required=True, help='host for postgres')
    parser.add_argument('--port', required=True, help='port for postgres')
    parser.add_argument('--db', required=True, help='database name for postgres')

    args = parser.parse_args()

    main(args)
