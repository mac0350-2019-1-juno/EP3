#!/bin/bash

# ./test.sh

R="\e[31m"                      # red
G="\e[32m"                      # green
B="\e[1m"                       # bold
D="\e[0m"                       # default

# postgres password
export PGPASSWORD=postgres
export ON_ERROR_STOP=1

psql_query() {
    printf "${B}psql -Upostgres $2 -c \"$1\"\n${D}"
    psql -Upostgres $2 -c "$1"
}

psql_file() {
    printf "${B}psql -v ON_ERROR_STOP=1 -Upostgres $2 -f \"$1\" > /dev/null\n${D}"
    psql -v ON_ERROR_STOP=1 -Upostgres $2 -f "$1" > /dev/null
}

psql_query  "DROP DATABASE juno"    && 0
psql_query  "DROP ROLE dba"         && 0

set -e

psql_query  "CREATE DATABASE juno"

# psql_file   "./sql/DDL.sql"                     "juno"

# psql_file   "./sql/DML.sql"                     "juno"

# psql_file   "./sql/DML_CREATE_GROUP.sql"        "juno"
# psql_file   "./sql/DML_CREATE_GROUP.test.sql"   "juno"
# psql_file   "./sql/DML_RETRIVAL_GROUP.sql"      "juno"
# psql_file   "./sql/DML_RETRIVAL_GROUP.test.sql" "juno"
# psql_file   "./sql/DML_UPDATE_GROUP.sql"        "juno"
# psql_file   "./sql/DML_UPDATE_GROUP.test.sql"   "juno"
# psql_file   "./sql/DML_DELETE_GROUP.sql"        "juno"
# psql_file   "./sql/DML_DELETE_GROUP.test.sql"   "juno"

# psql_file   "./sql/DML_CLEAN.sql"               "juno"

# psql_query  "DROP DATABASE juno"
# psql_query  "DROP ROLE dba"
