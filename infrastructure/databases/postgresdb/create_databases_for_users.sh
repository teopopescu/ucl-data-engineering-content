USERS="$(ls ../../users/created_users/)"

DATABASE_PORT=$(terraform output -raw database_port)
DATABASE_ENDPOINT=$(terraform output -raw database_endpoint | sed s/:${DATABASE_PORT}//)
DATABASE_PASSWORD=$(terraform output -raw database_password)
DATABASE_NAME=$(terraform output -raw database_name)
export PGPASSWORD=${DATABASE_PASSWORD}

for USER in ${USERS}; do
    DB_USER=$(echo ${USER} | sed 's/\.//g' | sed 's/\([a-z0-9]\)@uclacuk/\1/' | sed 's/-//g')
    psql -h "${DATABASE_ENDPOINT}" -p "${DATABASE_PORT}" -U postgres -d "${DATABASE_NAME}" <<EOF 
	drop database ${DB_USER};
	create database ${DB_USER};
	create user ${DB_USER};
	alter user ${DB_USER} with password 'qwerty123';
	grant all privileges on database ${DB_USER} to ${DB_USER};
EOF
done
