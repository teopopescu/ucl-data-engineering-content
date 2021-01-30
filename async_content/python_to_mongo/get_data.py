import csv
from postgres import PGWrapper

config = {
    "database": "de_pgdb",
    "user": "postgres",
    "password": "qwerty123",
    "host": "depgdb.c50u4bslwwg0.eu-west-2.rds.amazonaws.com",
    "port": 5432,
}

with PGWrapper(config) as db_con:
    results = db_con.query_as_list_of_dicts("SELECT * FROM ws2.order_product")

with open("out.csv", "w") as out_file:
    dict_writer = csv.DictWriter(out_file, results[0].keys())
    dict_writer.writeheader()
    dict_writer.writerows(results)