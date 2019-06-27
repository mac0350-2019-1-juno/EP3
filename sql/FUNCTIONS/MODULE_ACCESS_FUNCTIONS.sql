BEGIN;

-- cria um registro em usuario
CREATE  FUNCTION create_usuario(
                        email,
                        TEXT
)
RETURNS SETOF usuario
AS $$
BEGIN
    RETURN      QUERY
    INSERT      INTO usuario
                (email,
                 senha)
    VALUES      ($1, public.crypt($2, gen_salt('bf')))
    RETURNING   id,
                email,
                senha;
EXCEPTION
WHEN        OTHERS
THEN

END;
$$
LANGUAGE    plpgsql;

-- cria um registro em perfil
CREATE  FUNCTION create_perfil(
                        VARCHAR(20)
)
RETURNS SETOF perfil
AS $$
BEGIN
    RETURN      QUERY
    INSERT      INTO perfil
                (tipo)
    VALUES      ($1)
    RETURNING   id,
                tipo;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;


-- cria um registro em servico
CREATE  FUNCTION create_servico(
                        VARCHAR(80),
                        TEXT
)
RETURNS SETOF servico
AS $$
BEGIN
    RETURN      QUERY
    INSERT      INTO servico
                (nome,
                 descricao)
    VALUES      ($1, $2)
    RETURNING   id,
                nome,
                descricao;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;


-- cria um registro em usuario_perfil
CREATE  FUNCTION create_usuario_perfil(
                        INTEGER,
                        INTEGER
)
RETURNS SETOF usuario_perfil
AS $$
BEGIN
    RETURN      QUERY
    INSERT      INTO usuario_perfil
                (usuario_id,
                 perfil_id)
    VALUES      ($1, $2)
    RETURNING   id,
                usuario_id,
                perfil_id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;


-- cria um registro em perfil_servico
CREATE  FUNCTION create_perfil_servico(
                        INTEGER,
                        INTEGER
)
RETURNS SETOF perfil_servico
AS $$
BEGIN
    RETURN      QUERY
    INSERT      INTO perfil_servico
                (perfil_id,
                 servico_id)
    VALUES      ($1, $2)
    RETURNING   id,
                perfil_id,
                servico_id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;


-- remover de usuario por id
CREATE  FUNCTION delete_usuario_by_id(
                        INTEGER
)
RETURNS SETOF usuario
AS $$
BEGIN
    RETURN      QUERY
    DELETE      FROM usuario
    WHERE       id = $1
    RETURNING   id,
                email,
                senha;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- remover de perfil por id
CREATE  FUNCTION delete_perfil_by_id(
                        INTEGER
)
RETURNS SETOF perfil
AS $$
BEGIN
    RETURN      QUERY
    DELETE      FROM perfil
    WHERE       id = $1
    RETURNING   id,
                tipo;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- remover de perfil por tipo
CREATE  FUNCTION delete_perfil_by_tipo(
                        VARCHAR(20)
)
RETURNS SETOF perfil
AS $$
BEGIN
    RETURN      QUERY
    DELETE      FROM perfil
    WHERE       tipo = $1
    RETURNING   id,
                tipo;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;



-- remover de servico por id
CREATE  FUNCTION delete_servico_by_id(
                        INTEGER
)
RETURNS SETOF servico
AS $$
BEGIN
    RETURN      QUERY
    DELETE      FROM servico
    WHERE       id = $1
    RETURNING   id,
                nome,
                descricao;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- remover de servico por nome
CREATE  FUNCTION delete_servico_by_nome(
                        VARCHAR(80)
)
RETURNS SETOF servico
AS $$
BEGIN
    RETURN      QUERY
    DELETE      FROM servico
    WHERE       nome = $1
    RETURNING   id,
                nome,
                descricao;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- remover de usuario_perfil por id
CREATE  FUNCTION delete_usuario_perfil_by_id(
                        INTEGER
)
RETURNS SETOF usuario_perfil
AS $$
BEGIN
    RETURN      QUERY
    DELETE      FROM usuario_perfil
    WHERE       id = $1
    RETURNING   id,
                usuario_id,
                perfil_id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- remover de usuario_perfil por usuario_id, perfil_id
CREATE  FUNCTION delete_usuario_perfil_by_usuario_id_perfil_id(
                        INTEGER,
                        INTEGER
)
RETURNS SETOF usuario_perfil
AS $$
BEGIN
    RETURN      QUERY
    DELETE      FROM usuario_perfil
    WHERE       usuario_id = $1
               AND perfil_id = $2
    RETURNING   id,
                usuario_id,
                perfil_id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;



-- remover de perfil_servico por id
CREATE  FUNCTION delete_perfil_servico_by_id(
                        INTEGER
)
RETURNS SETOF perfil_servico
AS $$
BEGIN
    RETURN      QUERY
    DELETE      FROM perfil_servico
    WHERE       id = $1
    RETURNING   id,
                perfil_id,
                servico_id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- remover de perfil_servico por perfil_id, servico_id
CREATE  FUNCTION delete_perfil_servico_by_perfil_id_servico_id(
                        INTEGER,
                        INTEGER
)
RETURNS SETOF perfil_servico
AS $$
BEGIN
    RETURN      QUERY
    DELETE      FROM perfil_servico
    WHERE       perfil_id = $1
               AND servico_id = $2
    RETURNING   id,
                perfil_id,
                servico_id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- recuperar todos os registros em usuario
CREATE  FUNCTION retrieve_usuario_all()
RETURNS SETOF usuario
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            email,
            senha
    FROM    usuario
    ORDER   BY  id,
                email,
                senha;
END;
$$
LANGUAGE    plpgsql;

-- recuperar o registro em  usuario por id
CREATE  FUNCTION retrieve_usuario_by_id(
                        INTEGER
)
RETURNS SETOF usuario
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            email,
            senha
    FROM    usuario
    WHERE   id = $1
    ORDER   BY  id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- recuperar todos os registros em perfil
CREATE  FUNCTION retrieve_perfil_all()
RETURNS SETOF perfil
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            tipo
    FROM    perfil
    ORDER   BY  id,
                tipo;
END;
$$
LANGUAGE    plpgsql;

-- recuperar o registro em  perfil por id
CREATE  FUNCTION retrieve_perfil_by_id(
                        INTEGER
)
RETURNS SETOF perfil
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            tipo
    FROM    perfil
    WHERE   id = $1
    ORDER   BY  id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- recuperar o registro em  perfil por tipo
CREATE  FUNCTION retrieve_perfil_by_tipo(
                        VARCHAR(20)
)
RETURNS SETOF perfil
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            tipo
    FROM    perfil
    WHERE   tipo = $1
    ORDER   BY  tipo;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;



-- recuperar todos os registros em servico
CREATE  FUNCTION retrieve_servico_all()
RETURNS SETOF servico
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            nome,
            descricao
    FROM    servico
    ORDER   BY  id,
                nome,
                descricao;
END;
$$
LANGUAGE    plpgsql;

-- recuperar o registro em  servico por id
CREATE  FUNCTION retrieve_servico_by_id(
                        INTEGER
)
RETURNS SETOF servico
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            nome,
            descricao
    FROM    servico
    WHERE   id = $1
    ORDER   BY  id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- recuperar o registro em  servico por nome
CREATE  FUNCTION retrieve_servico_by_nome(
                        VARCHAR(80)
)
RETURNS SETOF servico
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            nome,
            descricao
    FROM    servico
    WHERE   nome = $1
    ORDER   BY  nome;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- recuperar todos os registros em perfil_servico
CREATE  FUNCTION retrieve_perfil_servico_all()
RETURNS SETOF perfil_servico
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            perfil_id,
            servico_id
    FROM    perfil_servico
    ORDER   BY  id,
                perfil_id,
                servico_id;
END;
$$
LANGUAGE    plpgsql;

-- recuperar o registro em  perfil_servico por id
CREATE  FUNCTION retrieve_perfil_servico_by_id(
                        INTEGER
)
RETURNS SETOF perfil_servico
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            perfil_id,
            servico_id
    FROM    perfil_servico
    WHERE   id = $1
    ORDER   BY  id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- recuperar o registro em  perfil_servico por perfil_id, servico_id
CREATE  FUNCTION retrieve_perfil_servico_by_perfil_id_servico_id(
                        INTEGER,
                        INTEGER
)
RETURNS SETOF perfil_servico
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            perfil_id,
            servico_id
    FROM    perfil_servico
    WHERE   perfil_id = $1
               AND servico_id = $2
    ORDER   BY  perfil_id,
                servico_id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- recuperar todos os resgistros em perfil_servico por perfil_id
CREATE  FUNCTION retrieve_perfil_servico_all_by_perfil_id(
                        INTEGER
)
RETURNS SETOF perfil_servico
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            perfil_id,
            servico_id
    FROM    perfil_servico
    WHERE   perfil_id = $1
    ORDER   BY  perfil_id;
END;
$$
LANGUAGE    plpgsql;

-- recuperar todos os resgistros em perfil_servico por servico_id
CREATE  FUNCTION retrieve_perfil_servico_all_by_servico_id(
                        INTEGER
)
RETURNS SETOF perfil_servico
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            perfil_id,
            servico_id
    FROM    perfil_servico
    WHERE   servico_id = $1
    ORDER   BY  servico_id;
END;
$$
LANGUAGE    plpgsql;



-- os servicos de um perfil
CREATE  FUNCTION retrieve_serv_de_peril(
    pm_perfil                   VARCHAR(20)
)
RETURNS TABLE (
    pm_servico                  VARCHAR(20)
) AS $$
BEGIN
    RETURN  QUERY
    SELECT  pm_servico
    FROM    permissao
    WHERE   pm_perfil=$1;
END;
$$
LANGUAGE    plpgsql;

-- atualizar em usuario por id
CREATE  FUNCTION update_usuario_by_id(
                        INTEGER,
                        email,
                        TEXT
)
RETURNS SETOF usuario
AS $$
BEGIN
    RETURN      QUERY
    UPDATE      usuario
    SET         email = $2,
                senha = public.crypt($3, gen_salt('bf'))
    WHERE       id = $1
    RETURNING   id,
                email,
                senha;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- atualizar em perfil por id
CREATE  FUNCTION update_perfil_by_id(
                        INTEGER,
                        VARCHAR(20)
)
RETURNS SETOF perfil
AS $$
BEGIN
    RETURN      QUERY
    UPDATE      perfil
    SET         tipo = $2
    WHERE       id = $1
    RETURNING   id,
                tipo;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- atualizar em perfil por tipo
CREATE  FUNCTION update_perfil_by_tipo(
                        VARCHAR(20),
                        VARCHAR(20)
)
RETURNS SETOF perfil
AS $$
BEGIN
    RETURN      QUERY
    UPDATE      perfil
    SET         tipo = $2
    WHERE       tipo = $1
    RETURNING   id,
                tipo;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;



-- atualizar em servico por id
CREATE  FUNCTION update_servico_by_id(
                        INTEGER,
                        VARCHAR(80),
                        TEXT
)
RETURNS SETOF servico
AS $$
BEGIN
    RETURN      QUERY
    UPDATE      servico
    SET         nome = $2,
                descricao = $3
    WHERE       id = $1
    RETURNING   id,
                nome,
                descricao;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- atualizar em servico por nome
CREATE  FUNCTION update_servico_by_nome(
                        VARCHAR(80),
                        VARCHAR(80),
                        TEXT
)
RETURNS SETOF servico
AS $$
BEGIN
    RETURN      QUERY
    UPDATE      servico
    SET         nome = $2,
                descricao = $3
    WHERE       nome = $1
    RETURNING   id,
                nome,
                descricao;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- atualizar em perfil_servico por id
CREATE  FUNCTION update_perfil_servico_by_id(
                        INTEGER,
                        INTEGER,
                        INTEGER
)
RETURNS SETOF perfil_servico
AS $$
BEGIN
    RETURN      QUERY
    UPDATE      perfil_servico
    SET         perfil_id = $2,
                servico_id = $3
    WHERE       id = $1
    RETURNING   id,
                perfil_id,
                servico_id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- atualizar em perfil_servico por perfil_id, servico_id
CREATE  FUNCTION update_perfil_servico_by_perfil_id_servico_id(
                        INTEGER,
                        INTEGER,
                        INTEGER,
                        INTEGER
)
RETURNS SETOF perfil_servico
AS $$
BEGIN
    RETURN      QUERY
    UPDATE      perfil_servico
    SET         perfil_id = $3,
                servico_id = $4
    WHERE       perfil_id = $1
               AND servico_id = $2
    RETURNING   id,
                perfil_id,
                servico_id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

COMMIT;
