BEGIN;

-- cria um registro em instituto
CREATE  FUNCTION create_instituto(
                        VARCHAR(128)
)
RETURNS SETOF instituto
AS $$
BEGIN
    RETURN      QUERY
    INSERT      INTO instituto
                (nome)
    VALUES      ($1)
    RETURNING   id,
                nome;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;


-- cria um registro em pessoa
CREATE  FUNCTION create_pessoa(
                        INTEGER,
                        VARCHAR(14),
                        VARCHAR(128)
)
RETURNS SETOF pessoa
AS $$
BEGIN
    RETURN      QUERY
    INSERT      INTO pessoa
                (nusp,
                 cpf,
                 nome)
    VALUES      ($1, $2, $3)
    RETURNING   id,
                nusp,
                cpf,
                nome;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- cria um registro em departamento
CREATE  FUNCTION create_departamento(
                        VARCHAR(3),
                        INTEGER
)
RETURNS SETOF departamento
AS $$
BEGIN
    RETURN      QUERY
    INSERT      INTO departamento
                (sigla,
                 instituto_id)
    VALUES      ($1, $2)
    RETURNING   id,
                sigla,
                instituto_id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;


-- cria um registro em aluno
CREATE  FUNCTION create_aluno(
                        INTEGER
)
RETURNS SETOF aluno
AS $$
BEGIN
    RETURN      QUERY
    INSERT      INTO aluno
                (pessoa_id)
    VALUES      ($1)
    RETURNING   id,
                pessoa_id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- cria um registro em administrador
CREATE  FUNCTION create_administrador(
                        INTEGER,
                        INTEGER
)
RETURNS SETOF administrador
AS $$
BEGIN
    RETURN      QUERY
    INSERT      INTO administrador
                (pessoa_id,
                 departamento_id)
    VALUES      ($1, $2)
    RETURNING   id,
                pessoa_id,
                departamento_id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;


-- cria um registro em professor
CREATE  FUNCTION create_professor(
                        INTEGER,
                        INTEGER
)
RETURNS SETOF professor
AS $$
BEGIN
    RETURN      QUERY
    INSERT      INTO professor
                (pessoa_id,
                 departamento_id)
    VALUES      ($1, $2)
    RETURNING   id,
                pessoa_id,
                departamento_id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- remover de pessoa por id
CREATE  FUNCTION delete_pessoa_by_id(
                        INTEGER
)
RETURNS SETOF pessoa
AS $$
BEGIN
    RETURN      QUERY
    DELETE      FROM pessoa
    WHERE       id = $1
    RETURNING   id,
                nusp,
                cpf,
                nome;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- remover de pessoa por nusp
CREATE  FUNCTION delete_pessoa_by_nusp(
                        INTEGER
)
RETURNS SETOF pessoa
AS $$
BEGIN
    RETURN      QUERY
    DELETE      FROM pessoa
    WHERE       nusp = $1
    RETURNING   id,
                nusp,
                cpf,
                nome;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- remover de pessoa por cpf
CREATE  FUNCTION delete_pessoa_by_cpf(
                        VARCHAR(14)
)
RETURNS SETOF pessoa
AS $$
BEGIN
    RETURN      QUERY
    DELETE      FROM pessoa
    WHERE       cpf = $1
    RETURNING   id,
                nusp,
                cpf,
                nome;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;


-- remover de departamento por id
CREATE  FUNCTION delete_departamento_by_id(
                        INTEGER
)
RETURNS SETOF departamento
AS $$
BEGIN
    RETURN      QUERY
    DELETE      FROM departamento
    WHERE       id = $1
    RETURNING   id,
                sigla,
                instituto_id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- remover de departamento por sigla
CREATE  FUNCTION delete_departamento_by_sigla(
                        VARCHAR(3)
)
RETURNS SETOF departamento
AS $$
BEGIN
    RETURN      QUERY
    DELETE      FROM departamento
    WHERE       sigla = $1
    RETURNING   id,
                sigla,
                instituto_id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;



-- remover de aluno por id
CREATE  FUNCTION delete_aluno_by_id(
                        INTEGER
)
RETURNS SETOF aluno
AS $$
BEGIN
    RETURN      QUERY
    DELETE      FROM aluno
    WHERE       id = $1
    RETURNING   id,
                pessoa_id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- remover de aluno por pessoa_id
CREATE  FUNCTION delete_aluno_by_pessoa_id(
                        INTEGER
)
RETURNS SETOF aluno
AS $$
BEGIN
    RETURN      QUERY
    DELETE      FROM aluno
    WHERE       pessoa_id = $1
    RETURNING   id,
                pessoa_id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- remover de administrador por id
CREATE  FUNCTION delete_administrador_by_id(
                        INTEGER
)
RETURNS SETOF administrador
AS $$
BEGIN
    RETURN      QUERY
    DELETE      FROM administrador
    WHERE       id = $1
    RETURNING   id,
                pessoa_id,
                departamento_id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- remover de administrador por pessoa_id
CREATE  FUNCTION delete_administrador_by_pessoa_id(
                        INTEGER
)
RETURNS SETOF administrador
AS $$
BEGIN
    RETURN      QUERY
    DELETE      FROM administrador
    WHERE       pessoa_id = $1
    RETURNING   id,
                pessoa_id,
                departamento_id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;



-- remover de professor por id
CREATE  FUNCTION delete_professor_by_id(
                        INTEGER
)
RETURNS SETOF professor
AS $$
BEGIN
    RETURN      QUERY
    DELETE      FROM professor
    WHERE       id = $1
    RETURNING   id,
                pessoa_id,
                departamento_id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- remover de professor por pessoa_id
CREATE  FUNCTION delete_professor_by_pessoa_id(
                        INTEGER
)
RETURNS SETOF professor
AS $$
BEGIN
    RETURN      QUERY
    DELETE      FROM professor
    WHERE       pessoa_id = $1
    RETURNING   id,
                pessoa_id,
                departamento_id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- recuperar todos os registros em instituto
CREATE  FUNCTION retrieve_instituto_all()
RETURNS SETOF instituto
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            nome
    FROM    instituto
    ORDER   BY  id,
                nome;
END;
$$
LANGUAGE    plpgsql;

-- recuperar o registro em  instituto por id
CREATE  FUNCTION retrieve_instituto_by_id(
                        INTEGER
)
RETURNS SETOF instituto
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            nome
    FROM    instituto
    WHERE   id = $1
    ORDER   BY  id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- recuperar o registro em  instituto por nome
CREATE  FUNCTION retrieve_instituto_by_nome(
                        VARCHAR(128)
)
RETURNS SETOF instituto
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            nome
    FROM    instituto
    WHERE   nome = $1
    ORDER   BY  nome;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;



-- recuperar todos os registros em pessoa
CREATE  FUNCTION retrieve_pessoa_all()
RETURNS SETOF pessoa
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            nusp,
            cpf,
            nome
    FROM    pessoa
    ORDER   BY  id,
                nusp,
                cpf,
                nome;
END;
$$
LANGUAGE    plpgsql;

-- recuperar o registro em  pessoa por id
CREATE  FUNCTION retrieve_pessoa_by_id(
                        INTEGER
)
RETURNS SETOF pessoa
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            nusp,
            cpf,
            nome
    FROM    pessoa
    WHERE   id = $1
    ORDER   BY  id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- recuperar o registro em  pessoa por nusp
CREATE  FUNCTION retrieve_pessoa_by_nusp(
                        INTEGER
)
RETURNS SETOF pessoa
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            nusp,
            cpf,
            nome
    FROM    pessoa
    WHERE   nusp = $1
    ORDER   BY  nusp;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- recuperar o registro em  pessoa por cpf
CREATE  FUNCTION retrieve_pessoa_by_cpf(
                        VARCHAR(14)
)
RETURNS SETOF pessoa
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            nusp,
            cpf,
            nome
    FROM    pessoa
    WHERE   cpf = $1
    ORDER   BY  cpf;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- recuperar todos os registros em departamento
CREATE  FUNCTION retrieve_departamento_all()
RETURNS SETOF departamento
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            sigla,
            instituto_id
    FROM    departamento
    ORDER   BY  id,
                sigla,
                instituto_id;
END;
$$
LANGUAGE    plpgsql;

-- recuperar o registro em  departamento por id
CREATE  FUNCTION retrieve_departamento_by_id(
                        INTEGER
)
RETURNS SETOF departamento
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            sigla,
            instituto_id
    FROM    departamento
    WHERE   id = $1
    ORDER   BY  id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- recuperar o registro em  departamento por sigla
CREATE  FUNCTION retrieve_departamento_by_sigla(
                        VARCHAR(3)
)
RETURNS SETOF departamento
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            sigla,
            instituto_id
    FROM    departamento
    WHERE   sigla = $1
    ORDER   BY  sigla;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- recuperar todos os resgistros em departamento por instituto_id
CREATE  FUNCTION retrieve_departamento_all_by_instituto_id(
                        INTEGER
)
RETURNS SETOF departamento
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            sigla,
            instituto_id
    FROM    departamento
    WHERE   instituto_id = $1
    ORDER   BY  instituto_id;
END;
$$
LANGUAGE    plpgsql;



-- recuperar todos os registros em aluno
CREATE  FUNCTION retrieve_aluno_all()
RETURNS SETOF aluno
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            pessoa_id
    FROM    aluno
    ORDER   BY  id,
                pessoa_id;
END;
$$
LANGUAGE    plpgsql;

-- recuperar o registro em  aluno por id
CREATE  FUNCTION retrieve_aluno_by_id(
                        INTEGER
)
RETURNS SETOF aluno
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            pessoa_id
    FROM    aluno
    WHERE   id = $1
    ORDER   BY  id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- recuperar o registro em  aluno por pessoa_id
CREATE  FUNCTION retrieve_aluno_by_pessoa_id(
                        INTEGER
)
RETURNS SETOF aluno
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            pessoa_id
    FROM    aluno
    WHERE   pessoa_id = $1
    ORDER   BY  pessoa_id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- recuperar todos os resgistros em aluno por pessoa_id
CREATE  FUNCTION retrieve_aluno_all_by_pessoa_id(
                        INTEGER
)
RETURNS SETOF aluno
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            pessoa_id
    FROM    aluno
    WHERE   pessoa_id = $1
    ORDER   BY  pessoa_id;
END;
$$
LANGUAGE    plpgsql;

-- recuperar todos os registros em administrador
CREATE  FUNCTION retrieve_administrador_all()
RETURNS SETOF administrador
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            pessoa_id,
            departamento_id
    FROM    administrador
    ORDER   BY  id,
                pessoa_id,
                departamento_id;
END;
$$
LANGUAGE    plpgsql;

-- recuperar o registro em  administrador por id
CREATE  FUNCTION retrieve_administrador_by_id(
                        INTEGER
)
RETURNS SETOF administrador
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            pessoa_id,
            departamento_id
    FROM    administrador
    WHERE   id = $1
    ORDER   BY  id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- recuperar o registro em  administrador por pessoa_id
CREATE  FUNCTION retrieve_administrador_by_pessoa_id(
                        INTEGER
)
RETURNS SETOF administrador
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            pessoa_id,
            departamento_id
    FROM    administrador
    WHERE   pessoa_id = $1
    ORDER   BY  pessoa_id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- recuperar todos os resgistros em administrador por pessoa_id
CREATE  FUNCTION retrieve_administrador_all_by_pessoa_id(
                        INTEGER
)
RETURNS SETOF administrador
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            pessoa_id,
            departamento_id
    FROM    administrador
    WHERE   pessoa_id = $1
    ORDER   BY  pessoa_id;
END;
$$
LANGUAGE    plpgsql;

-- recuperar todos os resgistros em administrador por departamento_id
CREATE  FUNCTION retrieve_administrador_all_by_departamento_id(
                        INTEGER
)
RETURNS SETOF administrador
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            pessoa_id,
            departamento_id
    FROM    administrador
    WHERE   departamento_id = $1
    ORDER   BY  departamento_id;
END;
$$
LANGUAGE    plpgsql;



-- recuperar todos os registros em professor
CREATE  FUNCTION retrieve_professor_all()
RETURNS SETOF professor
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            pessoa_id,
            departamento_id
    FROM    professor
    ORDER   BY  id,
                pessoa_id,
                departamento_id;
END;
$$
LANGUAGE    plpgsql;

-- recuperar o registro em  professor por id
CREATE  FUNCTION retrieve_professor_by_id(
                        INTEGER
)
RETURNS SETOF professor
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            pessoa_id,
            departamento_id
    FROM    professor
    WHERE   id = $1
    ORDER   BY  id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- recuperar o registro em  professor por pessoa_id
CREATE  FUNCTION retrieve_professor_by_pessoa_id(
                        INTEGER
)
RETURNS SETOF professor
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            pessoa_id,
            departamento_id
    FROM    professor
    WHERE   pessoa_id = $1
    ORDER   BY  pessoa_id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- recuperar todos os resgistros em professor por pessoa_id
CREATE  FUNCTION retrieve_professor_all_by_pessoa_id(
                        INTEGER
)
RETURNS SETOF professor
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            pessoa_id,
            departamento_id
    FROM    professor
    WHERE   pessoa_id = $1
    ORDER   BY  pessoa_id;
END;
$$
LANGUAGE    plpgsql;

-- recuperar todos os resgistros em professor por departamento_id
CREATE  FUNCTION retrieve_professor_all_by_departamento_id(
                        INTEGER
)
RETURNS SETOF professor
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            pessoa_id,
            departamento_id
    FROM    professor
    WHERE   departamento_id = $1
    ORDER   BY  departamento_id;
END;
$$
LANGUAGE    plpgsql;

-- atualizar em instituto por id
CREATE  FUNCTION update_instituto_by_id(
                        INTEGER,
                        VARCHAR(128)
)
RETURNS SETOF instituto
AS $$
BEGIN
    RETURN      QUERY
    UPDATE      instituto
    SET         nome = $2
    WHERE       id = $1
    RETURNING   id,
                nome;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- atualizar em instituto por nome
CREATE  FUNCTION update_instituto_by_nome(
                        VARCHAR(128),
                        VARCHAR(128)
)
RETURNS SETOF instituto
AS $$
BEGIN
    RETURN      QUERY
    UPDATE      instituto
    SET         nome = $2
    WHERE       nome = $1
    RETURNING   id,
                nome;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- atualizar em pessoa por id
CREATE  FUNCTION update_pessoa_by_id(
                        INTEGER,
                        INTEGER,
                        VARCHAR(14),
                        VARCHAR(128)
)
RETURNS SETOF pessoa
AS $$
BEGIN
    RETURN      QUERY
    UPDATE      pessoa
    SET         nusp = $2,
                cpf = $3,
                nome = $4
    WHERE       id = $1
    RETURNING   id,
                nusp,
                cpf,
                nome;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- atualizar em pessoa por nusp
CREATE  FUNCTION update_pessoa_by_nusp(
                        INTEGER,
                        INTEGER,
                        VARCHAR(14),
                        VARCHAR(128)
)
RETURNS SETOF pessoa
AS $$
BEGIN
    RETURN      QUERY
    UPDATE      pessoa
    SET         nusp = $2,
                cpf = $3,
                nome = $4
    WHERE       nusp = $1
    RETURNING   id,
                nusp,
                cpf,
                nome;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- atualizar em pessoa por cpf
CREATE  FUNCTION update_pessoa_by_cpf(
                        VARCHAR(14),
                        INTEGER,
                        VARCHAR(14),
                        VARCHAR(128)
)
RETURNS SETOF pessoa
AS $$
BEGIN
    RETURN      QUERY
    UPDATE      pessoa
    SET         nusp = $2,
                cpf = $3,
                nome = $4
    WHERE       cpf = $1
    RETURNING   id,
                nusp,
                cpf,
                nome;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- atualizar em departamento por id
CREATE  FUNCTION update_departamento_by_id(
                        INTEGER,
                        VARCHAR(3),
                        INTEGER
)
RETURNS SETOF departamento
AS $$
BEGIN
    RETURN      QUERY
    UPDATE      departamento
    SET         sigla = $2,
                instituto_id = $3
    WHERE       id = $1
    RETURNING   id,
                sigla,
                instituto_id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- atualizar em departamento por sigla
CREATE  FUNCTION update_departamento_by_sigla(
                        VARCHAR(3),
                        VARCHAR(3),
                        INTEGER
)
RETURNS SETOF departamento
AS $$
BEGIN
    RETURN      QUERY
    UPDATE      departamento
    SET         sigla = $2,
                instituto_id = $3
    WHERE       sigla = $1
    RETURNING   id,
                sigla,
                instituto_id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- atualizar em aluno por id
CREATE  FUNCTION update_aluno_by_id(
                        INTEGER,
                        INTEGER
)
RETURNS SETOF aluno
AS $$
BEGIN
    RETURN      QUERY
    UPDATE      aluno
    SET         pessoa_id = $2
    WHERE       id = $1
    RETURNING   id,
                pessoa_id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- atualizar em aluno por pessoa_id
CREATE  FUNCTION update_aluno_by_pessoa_id(
                        INTEGER,
                        INTEGER
)
RETURNS SETOF aluno
AS $$
BEGIN
    RETURN      QUERY
    UPDATE      aluno
    SET         pessoa_id = $2
    WHERE       pessoa_id = $1
    RETURNING   id,
                pessoa_id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- atualizar em administrador por id
CREATE  FUNCTION update_administrador_by_id(
                        INTEGER,
                        INTEGER,
                        INTEGER
)
RETURNS SETOF administrador
AS $$
BEGIN
    RETURN      QUERY
    UPDATE      administrador
    SET         pessoa_id = $2,
                departamento_id = $3
    WHERE       id = $1
    RETURNING   id,
                pessoa_id,
                departamento_id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- atualizar em administrador por pessoa_id
CREATE  FUNCTION update_administrador_by_pessoa_id(
                        INTEGER,
                        INTEGER,
                        INTEGER
)
RETURNS SETOF administrador
AS $$
BEGIN
    RETURN      QUERY
    UPDATE      administrador
    SET         pessoa_id = $2,
                departamento_id = $3
    WHERE       pessoa_id = $1
    RETURNING   id,
                pessoa_id,
                departamento_id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;



-- atualizar em professor por id
CREATE  FUNCTION update_professor_by_id(
                        INTEGER,
                        INTEGER,
                        INTEGER
)
RETURNS SETOF professor
AS $$
BEGIN
    RETURN      QUERY
    UPDATE      professor
    SET         pessoa_id = $2,
                departamento_id = $3
    WHERE       id = $1
    RETURNING   id,
                pessoa_id,
                departamento_id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- atualizar em professor por pessoa_id
CREATE  FUNCTION update_professor_by_pessoa_id(
                        INTEGER,
                        INTEGER,
                        INTEGER
)
RETURNS SETOF professor
AS $$
BEGIN
    RETURN      QUERY
    UPDATE      professor
    SET         pessoa_id = $2,
                departamento_id = $3
    WHERE       pessoa_id = $1
    RETURNING   id,
                pessoa_id,
                departamento_id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

COMMIT;
