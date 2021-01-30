tablename=$1
echo ${tablename}
psql -h depgdb.c50u4bslwwg0.eu-west-2.rds.amazonaws.com -p 5432 -U postgres -d de_pgdb <<EOF > out.txt
        select * from ${tablename};
EOF
# cat out.txt | sed s'/|//g' > out.txt
