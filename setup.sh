#!/bin/bash

R="\e[0;31m"                    # red
G="\e[1;32m"                    # green
B="\e[1m"                       # bold
DIM="\e[2m"
D="\e[0m"                       # default

export PGPASSWORD=c
export ON_ERROR_STOP=1

psql_query() {
    printf "${B}psql -Upostgres $2 -c \"$1\"\n${DIM}"
    psql -Upostgres $2 -c "$1"
    printf "${D}"
}

psql_file() {
    printf "${B}psql -v ON_ERROR_STOP=1 -Upostgres $2 -f \"$1\" > /dev/null\n${DIM}"
    psql -v ON_ERROR_STOP=1 -Upostgres $2 -f "$1" > /dev/null
    printf "${D}"
  }

# Changing password in juno/juno/settings.py
printf "\n${G} -------- Changing password in juno/juno/settings.py -------- \n${D}"
sed -e "16s#.*#senha_postgres = '${PGPASSWORD}'#" -i juno/juno/settings.py

# Dropping DATABASES
printf "\n${G} -------- Dropping databases -------- \n${D}"
psql_query  "DROP DATABASE juno_people"            ""
psql_query  "DROP DATABASE juno_access"            ""
psql_query  "DROP DATABASE juno_access_people"     ""
psql_query  "DROP DATABASE juno_curriculum"        ""
psql_query  "DROP DATABASE juno_people_curriculum" ""

psql_query  "DROP ROLE IF EXISTS dbajuno"

set -e

# CREATE DATABASES
printf "\n${G} -------- Creating databases -------- \n${D}"
psql_query  "CREATE DATABASE juno_people"
psql_query  "CREATE DATABASE juno_access"
psql_query  "CREATE DATABASE juno_access_people"
psql_query  "CREATE DATABASE juno_curriculum"
psql_query  "CREATE DATABASE juno_people_curriculum"

# DDLs
printf "\n${G} -------- Executing DDL's -------- \n${D}"
psql_file   "./sql/DDL/MODULE_PEOPLE_DDL.sql"      "juno_people"
psql_file   "./sql/DDL/MODULE_ACCESS_DDL.sql"      "juno_access"
psql_file   "./sql/DDL/INTER_MOD_ACC_PEO_DDL.sql"  "juno_access_people"
psql_file   "./sql/DDL/MODULE_CURRICULUM_DDL.sql"  "juno_curriculum"
psql_file   "./sql/DDL/INTER_MOD_PEO_CUR_DDL.sql"  "juno_people_curriculum"

# functions
printf "\n${G} -------- Creating functions -------- \n${D}"
psql_file   "./sql/FUNCTIONS/MODULE_PEOPLE_FUNCTIONS.sql"     "juno_people"
psql_file   "./sql/FUNCTIONS/MODULE_ACCESS_FUNCTIONS.sql"     "juno_access"
psql_file   "./sql/FUNCTIONS/INTER_MOD_ACC_PEO_FUNCTIONS.sql" "juno_access_people"
psql_file   "./sql/FUNCTIONS/MODULE_CURRICULUM_FUNCTIONS.sql" "juno_curriculum"
psql_file   "./sql/FUNCTIONS/INTER_MOD_PEO_CUR_FUNCTIONS.sql" "juno_people_curriculum"

# DMLs
printf "\n${G} -------- Executing DML's -------- \n${D}"
psql_file   "./sql/DML/MODULE_PEOPLE_DML.sql"      "juno_people"
psql_file   "./sql/DML/MODULE_ACCESS_DML.sql"      "juno_access"
psql_file   "./sql/DML/INTER_MOD_ACC_PEO_DML.sql"  "juno_access_people"
psql_file   "./sql/DML/MODULE_CURRICULUM_DML.sql"  "juno_curriculum"
psql_file   "./sql/DML/INTER_MOD_PEO_CUR_DML.sql"  "juno_people_curriculum"

printf "\n${D}"

# Deleting old migrations
printf "\n${G} -------- Deleting old migrations -------- \n${D}"
find . -path "*/migrations/*.py" -not -name "__init__.py" -delete
find . -path "*/migrations/*.pyc"  -delete

# Migrating
printf "\n${G} -------- Migrating -------- \n${D}"
python3.6 juno/manage.py makemigrations
python3.6 juno/manage.py migrate
python3.6 juno/manage.py migrate --database=juno_people
python3.6 juno/manage.py migrate --database=juno_access
python3.6 juno/manage.py migrate --database=juno_access_people
python3.6 juno/manage.py migrate --database=juno_curriculum
python3.6 juno/manage.py migrate --database=juno_people_curriculum

printf "\n${D}"
