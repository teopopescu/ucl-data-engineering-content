USERS="$(ls ../../users/created_users/)"

DATABASE_PORT=$(terraform output -raw database_port)
DATABASE_ENDPOINT=$(terraform output -raw database_endpoint | sed s/:${DATABASE_PORT}//)
DATABASE_PASSWORD=$(terraform output -raw database_password)
DATABASE_NAME=$(terraform output -raw database_name)
export PGPASSWORD=${DATABASE_PASSWORD}

for USER in ${USERS}; do
    psql -h "${DATABASE_ENDPOINT}" -p "${DATABASE_PORT}" -U postgres -d "${DATABASE_NAME}" <<< "create database ${USER}"
done
