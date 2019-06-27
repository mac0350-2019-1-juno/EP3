BEGIN;
CREATE EXTENSION IF NOT EXISTS postgres_fdw;
\echo  `printf 'admins'`
-- admins

    GRANT   USAGE
    ON      SCHEMA  admins
    TO      dba;

--
SELECT * FROM app.pessoa;
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
        REFERENCES  app.pessoa(id)
        ON UPDATE   CASCADE
        ON DELETE   CASCADE,

        FOREIGN KEY (usuario_id)
        REFERENCES  app.usuario(id)
        ON UPDATE   CASCADE
        ON DELETE   CASCADE
    );

--

COMMIT;
