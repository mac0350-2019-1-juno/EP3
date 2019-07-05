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

\echo  `printf 'level 3'`
-- level 3

    \echo  `printf '\tCREATE  TABLE curso'`
    CREATE  TABLE curso (
        id                  SERIAL,
        codigo              INTEGER             NOT NULL,
        nome                VARCHAR(150)        NOT NULL,
        instituto_id        INTEGER             NOT NULL,

        PRIMARY KEY (id),

        UNIQUE      (codigo),

        FOREIGN KEY (instituto_id)
        REFERENCES  instituto(id)
        ON UPDATE   CASCADE
        ON DELETE   CASCADE
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

        UNIQUE      (sigla),

        FOREIGN KEY (departamento_id)
        REFERENCES  departamento(id)
        ON UPDATE   CASCADE
        ON DELETE   CASCADE
    );

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
                     inicio),

        FOREIGN KEY (aluno_id)
        REFERENCES  aluno(id)
        ON UPDATE   CASCADE
        ON DELETE   CASCADE,

        FOREIGN KEY (curso_id)
        REFERENCES  curso(id)
        ON UPDATE   CASCADE
        ON DELETE   CASCADE
    );

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

        FOREIGN KEY (administrador_id)
        REFERENCES  administrador(id)
        ON UPDATE   CASCADE
        ON DELETE   CASCADE,

        FOREIGN KEY (curso_id)
        REFERENCES  curso(id)
        ON UPDATE   CASCADE
        ON DELETE   CASCADE,

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

        FOREIGN KEY (professor_id)
        REFERENCES  professor(id)
        ON UPDATE   CASCADE
        ON DELETE   CASCADE,

        FOREIGN KEY (disciplina_id)
        REFERENCES  disciplina(id)
        ON UPDATE   CASCADE
        ON DELETE   CASCADE,

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

        FOREIGN KEY (aluno_id)
        REFERENCES  aluno(id)
        ON UPDATE   CASCADE
        ON DELETE   CASCADE,

        FOREIGN KEY (disciplina_id)
        REFERENCES  disciplina(id)
        ON UPDATE   CASCADE
        ON DELETE   CASCADE,

        CHECK       (semestre IN (1, 2))
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

        FOREIGN KEY (aluno_id)
        REFERENCES  aluno(id) 
        ON UPDATE   CASCADE
        ON DELETE   CASCADE,

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
