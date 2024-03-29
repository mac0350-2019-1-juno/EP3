BEGIN;

\echo  `printf 'admins'`
-- admins

    CREATE  SCHEMA admins;

    GRANT   USAGE
    ON      SCHEMA  admins
    TO      dbajuno;

--

\echo  `printf 'level 3'`
-- level 3

    \echo  `printf '\tCREATE  TABLE curso'`
    CREATE  TABLE curso (
        id                  SERIAL,
        codigo              INTEGER             NOT NULL,
        nome                VARCHAR(150)        NOT NULL,
        instituto_id        INTEGER             NOT NULL,

        PRIMARY KEY (id),

        UNIQUE      (codigo)
    );

    \echo  `printf '\tCREATE  TABLE disciplina'`
    CREATE  TABLE disciplina (
        id                  SERIAL,
        sigla               VARCHAR(7)          NOT NULL,
        departamento_id     INTEGER             NOT NULL,
        nome                VARCHAR(150)        NOT NULL,
        credito_aula        INTEGER             NOT NULL,
        credito_trabalho    INTEGER             NOT NULL,
        semestre_ideal      INTEGER             NOT NULL,

        PRIMARY KEY (id),

        UNIQUE      (sigla)
    );

--

\echo  `printf 'level 4'`
-- level 4

    \echo  `printf '\tCREATE  TABLE enfase'`
    CREATE  TABLE enfase (
        id                  SERIAL,
        nome                VARCHAR(150)        NOT NULL,
        min_modulos         INTEGER             NOT NULL,
        curso_id            INTEGER             NOT NULL,

        PRIMARY KEY (id),

        UNIQUE      (nome),

        FOREIGN KEY (curso_id)
        REFERENCES  curso(id)
        ON UPDATE   CASCADE
        ON DELETE   CASCADE
    );

    \echo  `printf '\tCREATE  TABLE prerrequisito'`
    CREATE  TABLE prerrequisito (
        id                  SERIAL,
        curso_id            INTEGER             NOT NULL,
        disciplina_id       INTEGER             NOT NULL,
        requisito_id        INTEGER             NOT NULL,

        PRIMARY KEY (id),

        UNIQUE      (disciplina_id,
                     curso_id,
                     requisito_id),

        FOREIGN KEY (disciplina_id)
        REFERENCES  disciplina(id)
        ON UPDATE   CASCADE
        ON DELETE   CASCADE,

        FOREIGN KEY (curso_id)
        REFERENCES  curso(id)
        ON UPDATE   CASCADE
        ON DELETE   CASCADE,

        FOREIGN KEY (requisito_id)
        REFERENCES  disciplina(id)
        ON UPDATE   CASCADE
        ON DELETE   CASCADE
    );

--

\echo  `printf 'level 5'`
-- level 5

    \echo  `printf '\tCREATE  TABLE modulo'`
    CREATE  TABLE modulo (
        id                      SERIAL,
        nome                    VARCHAR(150)    NOT NULL,
        min_disciplinas         INTEGER         NOT NULL,
        enfase_id               INTEGER         NOT NULL,

        PRIMARY KEY (id),

        UNIQUE      (nome),

        FOREIGN KEY (enfase_id)
        REFERENCES  enfase(id)
        ON UPDATE   CASCADE
        ON DELETE   CASCADE
    );

--

-- level 6

\echo  `printf '\tCREATE  TABLE disciplina_modulo'`
CREATE  TABLE disciplina_modulo (
    id                      SERIAL,
    disciplina_id           INTEGER         NOT NULL,
    modulo_id               INTEGER         NOT NULL,

    PRIMARY KEY (id),

    UNIQUE      (disciplina_id,
                 modulo_id),

    FOREIGN KEY (disciplina_id)
    REFERENCES  disciplina(id)
    ON UPDATE   CASCADE
    ON DELETE   CASCADE,

    FOREIGN KEY (modulo_id)
    REFERENCES  modulo(id)
    ON UPDATE   CASCADE
    ON DELETE   CASCADE
);

--

COMMIT;
