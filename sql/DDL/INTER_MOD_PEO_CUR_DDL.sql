BEGIN;

\echo  `printf 'admins'`
-- admins

    CREATE  SCHEMA admins;

    GRANT   USAGE
    ON      SCHEMA  admins
    TO      dba;

    CREATE  EXTENSION citext;

    CREATE  DOMAIN email
            AS CITEXT
    CHECK   (value ~ ('^[a-zA-Z0-9.!#$%&''*+/=?^_`{|}~-]+@'
                    || '[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}'
                    || '[a-zA-Z0-9])?(?:\.[a-zA-Z0-9]'
                    || '(?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$'));
--

\echo  `printf 'level 4'`
-- level 4

    \echo  `printf '\tCREATE  TABLE aluno_curso'`
    CREATE  TABLE aluno_curso (
        id                  SERIAL,
        aluno_id            INTEGER             NOT NULL,
        curso_id            INTEGER             NOT NULL,
        inicio              DATE                NOT NULL,

        PRIMARY KEY (id),

        UNIQUE      (aluno_id,
                     curso_id,
                     inicio)
    );

    \echo  `printf '\tCREATE  TABLE administror_curso'`
    CREATE  TABLE administrador_curso (
        id                  SERIAL,
        administrador_id    INTEGER             NOT NULL,
        curso_id            INTEGER             NOT NULL,
        inicio              DATE                NOT NULL,
        termino             DATE,

        PRIMARY KEY (id),

        UNIQUE      (administrador_id,
                     curso_id,
                     inicio),

        CHECK       (inicio <= termino)
    );

    \echo  `printf '\tCREATE  TABLE ministra'`
    CREATE  TABLE ministra (
        id                  SERIAL,
        professor_id        INTEGER             NOT NULL,
        disciplina_id       INTEGER             NOT NULL,
        semestre            INTEGER             NOT NULL,
        ano                 INTEGER             NOT NULL,

        PRIMARY KEY (id),

        UNIQUE      (professor_id,
                     disciplina_id,
                     semestre,
                     ano),

        CHECK       (semestre IN (1, 2))
    );

    \echo  `printf '\tCREATE  TABLE planejamento'`
    CREATE  TABLE planejamento (
        id                  SERIAL,
        aluno_id            INTEGER             NOT NULL,
        disciplina_id       INTEGER             NOT NULL,
        semestre            INTEGER             NOT NULL,
        ano                 INTEGER             NOT NULL,

        PRIMARY KEY (id),

        UNIQUE      (aluno_id,
                     disciplina_id),

        CHECK       (semestre IN (1, 2))
    );

--

\echo  `printf 'level 5'`
-- level 5

    \echo  `printf '\tCREATE  TABLE oferecimento'`
    CREATE  TABLE oferecimento (
        id                      SERIAL,
        ministra_id             INTEGER         NOT NULL,

        PRIMARY KEY (id),

        UNIQUE      (ministra_id),

        FOREIGN KEY (ministra_id)
        REFERENCES  ministra(id)
        ON UPDATE   CASCADE
        ON DELETE   CASCADE
    );

--

\echo  `printf 'level 6'`
-- level 6

    \echo  `printf '\tCREATE  TABLE matricula'`
    CREATE  TABLE matricula (
        id                      SERIAL,
        aluno_id                INTEGER         NOT NULL,
        oferecimento_id         INTEGER         NOT NULL,
        estado                  CHAR            NOT NULL,
        nota                    REAL,
        frequencia              REAL,

        PRIMARY KEY (id),

        UNIQUE      (aluno_id,
                     oferecimento_id),

        FOREIGN KEY (oferecimento_id)
        REFERENCES  oferecimento(id)
        ON UPDATE   CASCADE
        ON DELETE   CASCADE,

        CHECK       (UPPER(estado) IN ('M', 'C', 'X', 'D', 'R')),

        CHECK       (nota >= 0.0
                     AND nota <= 10.0),

        CHECK       (frequencia >= 0.0
                     AND frequencia <= 100.0)
    );

--

COMMIT;
