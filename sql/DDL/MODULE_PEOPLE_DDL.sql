BEGIN;
\echo  `printf 'admins'`
-- admins

    CREATE  ROLE dba
      WITH    SUPERUSER
              CREATEDB
              CREATEROLE
      LOGIN   ENCRYPTED PASSWORD 'dba1234'
      VALID   UNTIL '2019-07-01';
      
    CREATE  SCHEMA admins;

    GRANT   USAGE
    ON      SCHEMA  admins
    TO      dba;

--

\echo  `printf 'level 1'`
-- level 1

    \echo  `printf '\tCREATE  TABLE instituto'`
    CREATE  TABLE instituto (
        id                  SERIAL,
        nome                VARCHAR(128)        NOT NULL,

        PRIMARY KEY (id),

        UNIQUE      (nome)
    );

    \echo  `printf '\tCREATE  TABLE pessoa'`
    CREATE  TABLE pessoa (
        id                  SERIAL,
        nusp                INTEGER             NOT NULL,
        cpf                 VARCHAR(14)         NOT NULL,
        nome                VARCHAR(128)        NOT NULL,

        PRIMARY KEY (id),

        UNIQUE      (nusp),

        UNIQUE      (cpf),

        CHECK       (SUBSTRING(cpf,4,1) = '.'
                     AND SUBSTRING(cpf,8,1) = '.'
                     AND SUBSTRING(cpf,12,1) = '-'
                     AND LENGTH(cpf) = 14)
    );

--

\echo  `printf 'level 2'`
-- level 2

    \echo  `printf '\tCREATE  TABLE departamento'`
    CREATE  TABLE departamento (
        id                  SERIAL,
        sigla               VARCHAR(3)          NOT NULL,
        instituto_id        INTEGER             NOT NULL,

        PRIMARY KEY (id),

        UNIQUE      (sigla),

        FOREIGN KEY (instituto_id)
        REFERENCES  instituto(id)
        ON UPDATE   CASCADE
        ON DELETE   CASCADE
    );

    \echo  `printf '\tCREATE  TABLE aluno'`
    CREATE  TABLE aluno (
        id                  SERIAL,
        pessoa_id           INTEGER             NOT NULL,

        PRIMARY KEY (id),

        UNIQUE      (pessoa_id),

        FOREIGN KEY (pessoa_id)
        REFERENCES  pessoa(id)
        ON UPDATE   CASCADE
        ON DELETE   CASCADE
    );

--

\echo  `printf 'level 3'`
-- level 3

    \echo  `printf '\tCREATE  TABLE administrador'`
    CREATE  TABLE administrador (
        id                  SERIAL,
        pessoa_id           INTEGER             NOT NULL,
        departamento_id     INTEGER             NOT NULL,

        PRIMARY KEY (id),

        UNIQUE      (pessoa_id),

        FOREIGN KEY (pessoa_id)
        REFERENCES  pessoa(id)
        ON UPDATE   CASCADE
        ON DELETE   CASCADE,

        FOREIGN KEY (departamento_id)
        REFERENCES  departamento(id)
        ON UPDATE   CASCADE
        ON DELETE   CASCADE
    );

    \echo  `printf '\tCREATE  TABLE professor'`
    CREATE  TABLE professor (
        id                  SERIAL,
        pessoa_id           INTEGER             NOT NULL,
        departamento_id     INTEGER             NOT NULL,

        PRIMARY KEY (id),

        UNIQUE      (pessoa_id),

        FOREIGN KEY (pessoa_id)
        REFERENCES  pessoa(id)
        ON UPDATE   CASCADE
        ON DELETE   CASCADE,

        FOREIGN KEY (departamento_id)
        REFERENCES  departamento(id)
        ON UPDATE   CASCADE
        ON DELETE   CASCADE
    );

--

COMMIT;
