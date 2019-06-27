BEGIN;
\echo  `printf 'admins'`
-- admins

    CREATE  SCHEMA admins;

    GRANT   USAGE
    ON      SCHEMA  admins
    TO      dba;

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

\echo  `printf 'security'`
-- security

    CREATE  EXTENSION pgcrypto;

    CREATE  FUNCTION check_senha(
        email               email,
        senha               TEXT
    )
    RETURNS BOOLEAN AS $$
    DECLARE
        valid_login             BOOLEAN;
    BEGIN
        SELECT  COUNT(*) = 1 INTO valid_login
        FROM    public.usuario
        WHERE   email = $1
                AND senha = public.crypt($2, senha);

        RETURN valid_login;
    END;
    $$
    LANGUAGE    plpgsql
    SECURITY    DEFINER
    SET         search_path = admins, pg_temp;

    REVOKE  ALL
    ON      FUNCTION check_senha(
        email               email,
        senha               TEXT
    )
    FROM    PUBLIC;

    GRANT   EXECUTE
    ON      FUNCTION check_senha(
        email               email,
        senha               TEXT)
    TO      dba;

--

\echo  `printf 'level 1'`
-- level 1

    \echo  `printf '\tCREATE  TABLE usuario'`
    CREATE  TABLE usuario (
        id                  SERIAL,
        email               email               NOT NULL,
        senha               TEXT                NOT NULL,

        PRIMARY KEY (id)
    );

    \echo  `printf '\tCREATE  TABLE perfil'`
    CREATE  TABLE perfil (
        id                  SERIAL,
        tipo                VARCHAR(20)         NOT NULL,

        PRIMARY KEY (id),

        UNIQUE      (tipo)
    );

    \echo  `printf '\tCREATE  TABLE servico'`
    CREATE  TABLE servico (
        id                  SERIAL,
        nome                VARCHAR(80)         NOT NULL,
        descricao           TEXT                NOT NULL,

        PRIMARY KEY (id),

        UNIQUE      (nome)
    );

--

\echo  `printf 'level 2'`
-- level 2

    \echo  `printf '\tCREATE  TABLE usuario_perfil'`
    CREATE  TABLE usuario_perfil (
        id                  SERIAL,
        usuario_id          INTEGER             NOT NULL,
        perfil_id           INTEGER             NOT NULL,

        PRIMARY KEY (id),

        UNIQUE      (usuario_id,
                     perfil_id),

        FOREIGN KEY (usuario_id)
        REFERENCES  usuario(id)
        ON UPDATE   CASCADE
        ON DELETE   CASCADE,

        FOREIGN KEY (perfil_id)
        REFERENCES  perfil(id)
        ON UPDATE   CASCADE
        ON DELETE   CASCADE
    );

    \echo  `printf '\tCREATE  TABLE perfil_servico'`
    CREATE  TABLE perfil_servico (
        id                  SERIAL,
        perfil_id           INTEGER             NOT NULL,
        servico_id          INTEGER             NOT NULL,

        PRIMARY KEY (id),

        UNIQUE      (perfil_id,
                     servico_id),

        FOREIGN KEY (perfil_id)
        REFERENCES  perfil(id)
        ON UPDATE   CASCADE
        ON DELETE   CASCADE,

        FOREIGN KEY (servico_id)
        REFERENCES  servico(id)
        ON UPDATE   CASCADE
        ON DELETE   CASCADE
    );

--

COMMIT;
