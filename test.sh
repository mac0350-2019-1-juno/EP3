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
    psql -v ON_ERROR_STOP=1 -Upostgres $2 -f "$1" 
    printf "${D}"
  }

printf "\n${G} -------- Dropping databases -------- \n${D}"
psql_query  "DROP DATABASE juno_people"   ""
psql_query  "DROP DATABASE juno_access"   ""

# DROP ROLES
# psql_query  "DROP ROLE dba"         && 0

set -e

# CREATE DATABASES
printf "\n${G} -------- Creating databases -------- \n${D}"
psql_query  "CREATE DATABASE juno_people"
psql_query  "CREATE DATABASE juno_access"

# # Runs a setup
# printf "\n${G} -------- Setting Up Server -------- \n${D}"
# psql_file   "./sql/server_setup.sql" ""

# DDLs
printf "\n${G} -------- Executing DDL's -------- \n${D}"
psql_file   "./sql/DDL/MODULE_PEOPLE_DDL.sql"     "juno_people"
psql_file   "./sql/DDL/MODULE_ACCESS_DDL.sql"     "juno_access"

# functions
printf "\n${G} -------- Creating functions -------- \n${D}"
psql_file   "./sql/FUNCTIONS/MODULE_PEOPLE_FUNCTIONS.sql"     "juno_people"
psql_file   "./sql/FUNCTIONS/MODULE_ACCESS_FUNCTIONS.sql"     "juno_access"

# DDLs
printf "\n${G} -------- Executing DML's -------- \n${D}"
psql_file   "./sql/DML/MODULE_PEOPLE_DML.sql"     "juno_people"
psql_file   "./sql/DML/MODULE_ACCESS_DML.sql"     "juno_access"

printf "\n${D}"
