psql -h depgdb.c50u4bslwwg0.eu-west-2.rds.amazonaws.com -p 5432 -U postgres -d de_pgdb <<EOF
\copy (select row_to_json(user_data) from (select * from ws2.pii) user_data ) to 'out.txt';
EOF

MONGO_USER_DATA_COLLECTION=$(cat out.txt | sed 's/$/,/g' | sed '1s/^/[/' | sed '$ s/,$/]/')

mongo <<EOF
use workshop3
db.user_data.insertMany(${MONGO_USER_DATA_COLLECTION})
EOF



