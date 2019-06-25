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

\echo  `printf 'level 2'`
-- level 2

    \echo  `printf '\tCREATE  TABLE pessoa_usuario'`
    CREATE  TABLE pessoa_usuario (
        id                  SERIAL,
        pessoa_id           INTEGER             NOT NULL,
        usuario_id          INTEGER             NOT NULL,

        PRIMARY KEY (id),

        UNIQUE      (pessoa_id, 
                     usuario_id),

        FOREIGN KEY (pessoa_id)
        REFERENCES  pessoa(id)
        ON UPDATE   CASCADE
        ON DELETE   CASCADE,
        
        FOREIGN KEY (usuario_id)
        REFERENCES  usuario(id)
        ON UPDATE   CASCADE
        ON DELETE   CASCADE
    );

--

COMMIT;
