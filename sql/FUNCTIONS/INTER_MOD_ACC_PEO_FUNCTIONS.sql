BEGIN;

-- cria um registro em pessoa_usuario
CREATE  FUNCTION create_pessoa_usuario(
                        INTEGER,
                        INTEGER
)
RETURNS SETOF pessoa_usuario
AS $$
BEGIN
    RETURN      QUERY
    INSERT      INTO pessoa_usuario
                (pessoa_id,
                 usuario_id)
    VALUES      ($1, $2)
    RETURNING   id,
                pessoa_id,
                usuario_id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- remover de pessoa_usuario por id
CREATE  FUNCTION delete_pessoa_usuario_by_id(
                        INTEGER
)
RETURNS SETOF pessoa_usuario
AS $$
BEGIN
    RETURN      QUERY
    DELETE      FROM pessoa_usuario
    WHERE       id = $1
    RETURNING   id,
                pessoa_id,
                usuario_id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- remover de pessoa_usuario por pessoa_id, usuario_id
CREATE  FUNCTION delete_pessoa_usuario_by_pessoa_id_usuario_id(
                        INTEGER,
                        INTEGER
)
RETURNS SETOF pessoa_usuario
AS $$
BEGIN
    RETURN      QUERY
    DELETE      FROM pessoa_usuario
    WHERE       pessoa_id = $1
               AND usuario_id = $2
    RETURNING   id,
                pessoa_id,
                usuario_id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- recuperar todos os registros em pessoa_usuario
CREATE  FUNCTION retrieve_pessoa_usuario_all()
RETURNS SETOF pessoa_usuario
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            pessoa_id,
            usuario_id
    FROM    pessoa_usuario
    ORDER   BY  id,
                pessoa_id,
                usuario_id;
END;
$$
LANGUAGE    plpgsql;

-- recuperar o registro em  pessoa_usuario por id
CREATE  FUNCTION retrieve_pessoa_usuario_by_id(
                        INTEGER
)
RETURNS SETOF pessoa_usuario
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            pessoa_id,
            usuario_id
    FROM    pessoa_usuario
    WHERE   id = $1
    ORDER   BY  id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- recuperar o registro em  pessoa_usuario por pessoa_id, usuario_id
CREATE  FUNCTION retrieve_pessoa_usuario_by_pessoa_id_usuario_id(
                        INTEGER,
                        INTEGER
)
RETURNS SETOF pessoa_usuario
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            pessoa_id,
            usuario_id
    FROM    pessoa_usuario
    WHERE   pessoa_id = $1
               AND usuario_id = $2
    ORDER   BY  pessoa_id,
                usuario_id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- recuperar todos os resgistros em pessoa_usuario por pessoa_id
CREATE  FUNCTION retrieve_pessoa_usuario_all_by_pessoa_id(
                        INTEGER
)
RETURNS SETOF pessoa_usuario
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            pessoa_id,
            usuario_id
    FROM    pessoa_usuario
    WHERE   pessoa_id = $1
    ORDER   BY  pessoa_id;
END;
$$
LANGUAGE    plpgsql;

-- recuperar todos os resgistros em pessoa_usuario por usuario_id
CREATE  FUNCTION retrieve_pessoa_usuario_all_by_usuario_id(
                        INTEGER
)
RETURNS SETOF pessoa_usuario
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            pessoa_id,
            usuario_id
    FROM    pessoa_usuario
    WHERE   usuario_id = $1
    ORDER   BY  usuario_id;
END;
$$
LANGUAGE    plpgsql;


-- recuperar todos os registros em usuario_perfil
CREATE  FUNCTION retrieve_usuario_perfil_all()
RETURNS SETOF usuario_perfil
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            usuario_id,
            perfil_id
    FROM    usuario_perfil
    ORDER   BY  id,
                usuario_id,
                perfil_id;
END;
$$
LANGUAGE    plpgsql;

-- recuperar o registro em  usuario_perfil por id
CREATE  FUNCTION retrieve_usuario_perfil_by_id(
                        INTEGER
)
RETURNS SETOF usuario_perfil
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            usuario_id,
            perfil_id
    FROM    usuario_perfil
    WHERE   id = $1
    ORDER   BY  id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- recuperar o registro em  usuario_perfil por usuario_id, perfil_id
CREATE  FUNCTION retrieve_usuario_perfil_by_usuario_id_perfil_id(
                        INTEGER,
                        INTEGER
)
RETURNS SETOF usuario_perfil
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            usuario_id,
            perfil_id
    FROM    usuario_perfil
    WHERE   usuario_id = $1
               AND perfil_id = $2
    ORDER   BY  usuario_id,
                perfil_id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- recuperar todos os resgistros em usuario_perfil por usuario_id
CREATE  FUNCTION retrieve_usuario_perfil_all_by_usuario_id(
                        INTEGER
)
RETURNS SETOF usuario_perfil
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            usuario_id,
            perfil_id
    FROM    usuario_perfil
    WHERE   usuario_id = $1
    ORDER   BY  usuario_id;
END;
$$
LANGUAGE    plpgsql;

-- recuperar todos os resgistros em usuario_perfil por perfil_id
CREATE  FUNCTION retrieve_usuario_perfil_all_by_perfil_id(
                        INTEGER
)
RETURNS SETOF usuario_perfil
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            usuario_id,
            perfil_id
    FROM    usuario_perfil
    WHERE   perfil_id = $1
    ORDER   BY  perfil_id;
END;
$$
LANGUAGE    plpgsql;



-- perfis associados a um usuario
CREATE  FUNCTION retrieve_perf_usuario(
                        INTEGER
)
RETURNS TABLE (
    perfil_id           VARCHAR(20)
) AS $$
BEGIN
    RETURN  QUERY
    SELECT  usuario_perfil.perfil_id
    FROM    usuario_perfil
    WHERE   usuario_perfil.usuario_id = $1;
END;
$$
LANGUAGE    plpgsql;

-- dados do usuario/pessoa a partir do nusp (nome, email e perfil)
CREATE  FUNCTION retrieve_usuario_pessoa(
    ps_nusp_                    INTEGER
)
RETURNS TABLE (
    ps_nome                     VARCHAR(128),
    us_email                    email,
    pf_tipo                     VARCHAR(20)
) AS $$
BEGIN
    RETURN  QUERY
    SELECT  ps_nome,
            us_email,
            pf_tipo
    FROM    pessoa,
            users,
            acesso,
            usuario_perfil
    WHERE   ps_nusp=$1
            AND ac_pessoa=ps_nusp
            AND ac_user=us_id
            AND usuario_perfil.usuario_id = us_id;
END;
$$
LANGUAGE    plpgsql;

-- atualizar em pessoa_usuario por id
CREATE  FUNCTION update_pessoa_usuario_by_id(
                        INTEGER,
                        INTEGER,
                        INTEGER
)
RETURNS SETOF pessoa_usuario
AS $$
BEGIN
    RETURN      QUERY
    UPDATE      pessoa_usuario
    SET         pessoa_id = $2,
                usuario_id = $3
    WHERE       id = $1
    RETURNING   id,
                pessoa_id,
                usuario_id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- atualizar em pessoa_usuario por pessoa_id, usuario_id
CREATE  FUNCTION update_pessoa_usuario_by_pessoa_id_usuario_id(
                        INTEGER,
                        INTEGER,
                        INTEGER,
                        INTEGER
)
RETURNS SETOF pessoa_usuario
AS $$
BEGIN
    RETURN      QUERY
    UPDATE      pessoa_usuario
    SET         pessoa_id = $3,
                usuario_id = $4
    WHERE       pessoa_id = $1
               AND usuario_id = $2
    RETURNING   id,
                pessoa_id,
                usuario_id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;



-- atualizar em usuario_perfil por id
CREATE  FUNCTION update_usuario_perfil_by_id(
                        INTEGER,
                        INTEGER,
                        INTEGER
)
RETURNS SETOF usuario_perfil
AS $$
BEGIN
    RETURN      QUERY
    UPDATE      usuario_perfil
    SET         usuario_id = $2,
                perfil_id = $3
    WHERE       id = $1
    RETURNING   id,
                usuario_id,
                perfil_id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- atualizar em usuario_perfil por usuario_id, perfil_id
CREATE  FUNCTION update_usuario_perfil_by_usuario_id_perfil_id(
                        INTEGER,
                        INTEGER,
                        INTEGER,
                        INTEGER
)
RETURNS SETOF usuario_perfil
AS $$
BEGIN
    RETURN      QUERY
    UPDATE      usuario_perfil
    SET         usuario_id = $3,
                perfil_id = $4
    WHERE       usuario_id = $1
               AND perfil_id = $2
    RETURNING   id,
                usuario_id,
                perfil_id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

COMMIT;
