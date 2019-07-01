BEGIN;
\echo  `printf 'admins'`
-- admins

    CREATE  SCHEMA admins;

    GRANT   USAGE
    ON      SCHEMA  admins
    TO      dbajuno;

--
\echo  `printf 'email'`
-- email

    CREATE  EXTENSION citext;

    CREATE  DOMAIN email
            AS CITEXT
    CHECK   (value ~ ('^[a-zA-Z0-9.!#$%&''*+/=?^_`{|}~-]+@'
                    || '[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}'
                    || '[a-zA-Z0-9])?(?:\.[a-zA-Z0-9]'
                    || '(?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$'));

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
                     usuario_id)
    );

--

COMMIT;
