import pymongo


class MongoWrapper:
    def __init__(self, config):
        self.username = config["user"]
        self.password = config["password"]
        self.authSource = config["database"]
        self.host = config["host"]
        # self.port = config["port"] or 27017
        self.client = None

    def connect(self):
        self.client = pymongo.MongoClient(
            self.host,
            username=self.username,
            password=self.password,
            authSource=self.authSource,
        )


config = {
    'user': "myUser",
    "password": "qwerty123",
    "database": "testdb",
    "host": "127.0.0.1"
}
db_con = MongoWrapper(config)
print (db_con)
db_con.connect()
col = db_con.client.testdb.mycollouis

col.insert_one({'ceplm': 123})

