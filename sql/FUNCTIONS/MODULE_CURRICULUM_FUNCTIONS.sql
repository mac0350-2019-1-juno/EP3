BEGIN;

-- cria um registro em curso
CREATE  FUNCTION create_curso(
                        INTEGER,
                        VARCHAR(150),
                        INTEGER
)
RETURNS SETOF curso
AS $$
BEGIN
    RETURN      QUERY
    INSERT      INTO curso
                (codigo,
                 nome,
                 instituto_id)
    VALUES      ($1, $2, $3)
    RETURNING   id,
                codigo,
                nome,
                instituto_id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;


-- cria um registro em disciplina
CREATE  FUNCTION create_disciplina(
                        VARCHAR(7),
                        INTEGER,
                        VARCHAR(150),
                        INTEGER,
                        INTEGER,
                        INTEGER
)
RETURNS SETOF disciplina
AS $$
BEGIN
    RETURN      QUERY
    INSERT      INTO disciplina
                (sigla,
                 departamento_id,
                 nome,
                 credito_aula,
                 credito_trabalho,
                 semestre_ideal)
    VALUES      ($1, $2, $3, $4, $5, $6)
    RETURNING   id,
                sigla,
                departamento_id,
                nome,
                credito_aula,
                credito_trabalho,
                semestre_ideal;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- cria um registro em enfase
CREATE  FUNCTION create_enfase(
                        VARCHAR(150),
                        INTEGER,
                        INTEGER
)
RETURNS SETOF enfase
AS $$
BEGIN
    RETURN      QUERY
    INSERT      INTO enfase
                (nome,
                 min_modulos,
                 curso_id)
    VALUES      ($1, $2, $3)
    RETURNING   id,
                nome,
                min_modulos,
                curso_id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;


-- cria um registro em prerrequisito
CREATE  FUNCTION create_prerrequisito(
                        INTEGER,
                        INTEGER,
                        INTEGER
)
RETURNS SETOF prerrequisito
AS $$
BEGIN
    RETURN      QUERY
    INSERT      INTO prerrequisito
                (curso_id,
                 disciplina_id,
                 requisito_id)
    VALUES      ($1, $2, $3)
    RETURNING   id,
                curso_id,
                disciplina_id,
                requisito_id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- cria um registro em modulo
CREATE  FUNCTION create_modulo(
                        VARCHAR(150),
                        INTEGER,
                        INTEGER
)
RETURNS SETOF modulo
AS $$
BEGIN
    RETURN      QUERY
    INSERT      INTO modulo
                (nome,
                 min_disciplinas,
                 enfase_id)
    VALUES      ($1, $2, $3)
    RETURNING   id,
                nome,
                min_disciplinas,
                enfase_id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- cria um registro em disciplina_modulo
CREATE  FUNCTION create_disciplina_modulo(
                        INTEGER,
                        INTEGER
)
RETURNS SETOF disciplina_modulo
AS $$
BEGIN
    RETURN      QUERY
    INSERT      INTO disciplina_modulo
                (disciplina_id,
                 modulo_id)
    VALUES      ($1, $2)
    RETURNING   id,
                disciplina_id,
                modulo_id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- remover de curso por id
CREATE  FUNCTION delete_curso_by_id(
                        INTEGER
)
RETURNS SETOF curso
AS $$
BEGIN
    RETURN      QUERY
    DELETE      FROM curso
    WHERE       id = $1
    RETURNING   id,
                codigo,
                nome,
                instituto_id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- remover de curso por codigo
CREATE  FUNCTION delete_curso_by_codigo(
                        INTEGER
)
RETURNS SETOF curso
AS $$
BEGIN
    RETURN      QUERY
    DELETE      FROM curso
    WHERE       codigo = $1
    RETURNING   id,
                codigo,
                nome,
                instituto_id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;



-- remover de disciplina por id
CREATE  FUNCTION delete_disciplina_by_id(
                        INTEGER
)
RETURNS SETOF disciplina
AS $$
BEGIN
    RETURN      QUERY
    DELETE      FROM disciplina
    WHERE       id = $1
    RETURNING   id,
                sigla,
                departamento_id,
                nome,
                credito_aula,
                credito_trabalho,
                semestre_ideal;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- remover de disciplina por sigla
CREATE  FUNCTION delete_disciplina_by_sigla(
                        VARCHAR(7)
)
RETURNS SETOF disciplina
AS $$
BEGIN
    RETURN      QUERY
    DELETE      FROM disciplina
    WHERE       sigla = $1
    RETURNING   id,
                sigla,
                departamento_id,
                nome,
                credito_aula,
                credito_trabalho,
                semestre_ideal;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- remover de enfase por id
CREATE  FUNCTION delete_enfase_by_id(
                        INTEGER
)
RETURNS SETOF enfase
AS $$
BEGIN
    RETURN      QUERY
    DELETE      FROM enfase
    WHERE       id = $1
    RETURNING   id,
                nome,
                min_modulos,
                curso_id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- remover de enfase por nome
CREATE  FUNCTION delete_enfase_by_nome(
                        VARCHAR(150)
)
RETURNS SETOF enfase
AS $$
BEGIN
    RETURN      QUERY
    DELETE      FROM enfase
    WHERE       nome = $1
    RETURNING   id,
                nome,
                min_modulos,
                curso_id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;



-- remover de prerrequisito por id
CREATE  FUNCTION delete_prerrequisito_by_id(
                        INTEGER
)
RETURNS SETOF prerrequisito
AS $$
BEGIN
    RETURN      QUERY
    DELETE      FROM prerrequisito
    WHERE       id = $1
    RETURNING   id,
                curso_id,
                disciplina_id,
                requisito_id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- remover de prerrequisito por disciplina_id, curso_id, requisito_id
CREATE  FUNCTION delete_prerrequisito_by_disciplina_id_curso_id_requisito_id(
                        INTEGER,
                        INTEGER,
                        INTEGER
)
RETURNS SETOF prerrequisito
AS $$
BEGIN
    RETURN      QUERY
    DELETE      FROM prerrequisito
    WHERE       disciplina_id = $1
               AND curso_id = $2
               AND requisito_id = $3
    RETURNING   id,
                curso_id,
                disciplina_id,
                requisito_id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- remover de modulo por id
CREATE  FUNCTION delete_modulo_by_id(
                        INTEGER
)
RETURNS SETOF modulo
AS $$
BEGIN
    RETURN      QUERY
    DELETE      FROM modulo
    WHERE       id = $1
    RETURNING   id,
                nome,
                min_disciplinas,
                enfase_id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- remover de modulo por nome
CREATE  FUNCTION delete_modulo_by_nome(
                        VARCHAR(150)
)
RETURNS SETOF modulo
AS $$
BEGIN
    RETURN      QUERY
    DELETE      FROM modulo
    WHERE       nome = $1
    RETURNING   id,
                nome,
                min_disciplinas,
                enfase_id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- remover de disciplina_modulo por id
CREATE  FUNCTION delete_disciplina_modulo_by_id(
                        INTEGER
)
RETURNS SETOF disciplina_modulo
AS $$
BEGIN
    RETURN      QUERY
    DELETE      FROM disciplina_modulo
    WHERE       id = $1
    RETURNING   id,
                disciplina_id,
                modulo_id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- remover de disciplina_modulo por disciplina_id, modulo_id
CREATE  FUNCTION delete_disciplina_modulo_by_disciplina_id_modulo_id(
                        INTEGER,
                        INTEGER
)
RETURNS SETOF disciplina_modulo
AS $$
BEGIN
    RETURN      QUERY
    DELETE      FROM disciplina_modulo
    WHERE       disciplina_id = $1
               AND modulo_id = $2
    RETURNING   id,
                disciplina_id,
                modulo_id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- recuperar todos os registros em curso
CREATE  FUNCTION retrieve_curso_all()
RETURNS SETOF curso
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            codigo,
            nome,
            instituto_id
    FROM    curso
    ORDER   BY  id,
                codigo,
                nome,
                instituto_id;
END;
$$
LANGUAGE    plpgsql;

-- recuperar o registro em  curso por id
CREATE  FUNCTION retrieve_curso_by_id(
                        INTEGER
)
RETURNS SETOF curso
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            codigo,
            nome,
            instituto_id
    FROM    curso
    WHERE   id = $1
    ORDER   BY  id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- recuperar o registro em  curso por codigo
CREATE  FUNCTION retrieve_curso_by_codigo(
                        INTEGER
)
RETURNS SETOF curso
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            codigo,
            nome,
            instituto_id
    FROM    curso
    WHERE   codigo = $1
    ORDER   BY  codigo;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- recuperar todos os resgistros em curso por instituto_id
CREATE  FUNCTION retrieve_curso_all_by_instituto_id(
                        INTEGER
)
RETURNS SETOF curso
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            codigo,
            nome,
            instituto_id
    FROM    curso
    WHERE   instituto_id = $1
    ORDER   BY  instituto_id;
END;
$$
LANGUAGE    plpgsql;



-- recuperar todos os registros em disciplina
CREATE  FUNCTION retrieve_disciplina_all()
RETURNS SETOF disciplina
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            sigla,
            departamento_id,
            nome,
            credito_aula,
            credito_trabalho,
            semestre_ideal
    FROM    disciplina
    ORDER   BY  id,
                sigla,
                departamento_id,
                nome,
                credito_aula,
                credito_trabalho,
                semestre_ideal;
END;
$$
LANGUAGE    plpgsql;

-- recuperar o registro em  disciplina por id
CREATE  FUNCTION retrieve_disciplina_by_id(
                        INTEGER
)
RETURNS SETOF disciplina
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            sigla,
            departamento_id,
            nome,
            credito_aula,
            credito_trabalho,
            semestre_ideal
    FROM    disciplina
    WHERE   id = $1
    ORDER   BY  id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- recuperar o registro em  disciplina por sigla
CREATE  FUNCTION retrieve_disciplina_by_sigla(
                        VARCHAR(7)
)
RETURNS SETOF disciplina
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            sigla,
            departamento_id,
            nome,
            credito_aula,
            credito_trabalho,
            semestre_ideal
    FROM    disciplina
    WHERE   sigla = $1
    ORDER   BY  sigla;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- recuperar todos os resgistros em disciplina por departamento_id
CREATE  FUNCTION retrieve_disciplina_all_by_departamento_id(
                        INTEGER
)
RETURNS SETOF disciplina
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            sigla,
            departamento_id,
            nome,
            credito_aula,
            credito_trabalho,
            semestre_ideal
    FROM    disciplina
    WHERE   departamento_id = $1
    ORDER   BY  departamento_id;
END;
$$
LANGUAGE    plpgsql;

-- recuperar todos os registros em enfase
CREATE  FUNCTION retrieve_enfase_all()
RETURNS SETOF enfase
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            nome,
            min_modulos,
            curso_id
    FROM    enfase
    ORDER   BY  id,
                nome,
                min_modulos,
                curso_id;
END;
$$
LANGUAGE    plpgsql;

-- recuperar o registro em  enfase por id
CREATE  FUNCTION retrieve_enfase_by_id(
                        INTEGER
)
RETURNS SETOF enfase
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            nome,
            min_modulos,
            curso_id
    FROM    enfase
    WHERE   id = $1
    ORDER   BY  id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- recuperar o registro em  enfase por nome
CREATE  FUNCTION retrieve_enfase_by_nome(
                        VARCHAR(150)
)
RETURNS SETOF enfase
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            nome,
            min_modulos,
            curso_id
    FROM    enfase
    WHERE   nome = $1
    ORDER   BY  nome;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- recuperar todos os resgistros em enfase por curso_id
CREATE  FUNCTION retrieve_enfase_all_by_curso_id(
                        INTEGER
)
RETURNS SETOF enfase
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            nome,
            min_modulos,
            curso_id
    FROM    enfase
    WHERE   curso_id = $1
    ORDER   BY  curso_id;
END;
$$
LANGUAGE    plpgsql;



-- recuperar todos os registros em prerrequisito
CREATE  FUNCTION retrieve_prerrequisito_all()
RETURNS SETOF prerrequisito
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            curso_id,
            disciplina_id,
            requisito_id
    FROM    prerrequisito
    ORDER   BY  id,
                curso_id,
                disciplina_id,
                requisito_id;
END;
$$
LANGUAGE    plpgsql;

-- recuperar o registro em  prerrequisito por id
CREATE  FUNCTION retrieve_prerrequisito_by_id(
                        INTEGER
)
RETURNS SETOF prerrequisito
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            curso_id,
            disciplina_id,
            requisito_id
    FROM    prerrequisito
    WHERE   id = $1
    ORDER   BY  id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- recuperar o registro em  prerrequisito por disciplina_id, curso_id, requisito_id
CREATE  FUNCTION retrieve_prerrequisito_by_disciplina_id_curso_id_requisito_id(
                        INTEGER,
                        INTEGER,
                        INTEGER
)
RETURNS SETOF prerrequisito
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            curso_id,
            disciplina_id,
            requisito_id
    FROM    prerrequisito
    WHERE   disciplina_id = $1
               AND curso_id = $2
               AND requisito_id = $3
    ORDER   BY  disciplina_id,
                curso_id,
                requisito_id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- recuperar todos os resgistros em prerrequisito por disciplina_id
CREATE  FUNCTION retrieve_prerrequisito_all_by_disciplina_id(
                        INTEGER
)
RETURNS SETOF prerrequisito
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            curso_id,
            disciplina_id,
            requisito_id
    FROM    prerrequisito
    WHERE   disciplina_id = $1
    ORDER   BY  disciplina_id;
END;
$$
LANGUAGE    plpgsql;

-- recuperar todos os resgistros em prerrequisito por curso_id
CREATE  FUNCTION retrieve_prerrequisito_all_by_curso_id(
                        INTEGER
)
RETURNS SETOF prerrequisito
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            curso_id,
            disciplina_id,
            requisito_id
    FROM    prerrequisito
    WHERE   curso_id = $1
    ORDER   BY  curso_id;
END;
$$
LANGUAGE    plpgsql;

-- recuperar todos os resgistros em prerrequisito por requisito_id
CREATE  FUNCTION retrieve_prerrequisito_all_by_requisito_id(
                        INTEGER
)
RETURNS SETOF prerrequisito
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            curso_id,
            disciplina_id,
            requisito_id
    FROM    prerrequisito
    WHERE   requisito_id = $1
    ORDER   BY  requisito_id;
END;
$$
LANGUAGE    plpgsql;

-- recuperar todos os registros em modulo
CREATE  FUNCTION retrieve_modulo_all()
RETURNS SETOF modulo
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            nome,
            min_disciplinas,
            enfase_id
    FROM    modulo
    ORDER   BY  id,
                nome,
                min_disciplinas,
                enfase_id;
END;
$$
LANGUAGE    plpgsql;

-- recuperar o registro em  modulo por id
CREATE  FUNCTION retrieve_modulo_by_id(
                        INTEGER
)
RETURNS SETOF modulo
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            nome,
            min_disciplinas,
            enfase_id
    FROM    modulo
    WHERE   id = $1
    ORDER   BY  id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- recuperar o registro em  modulo por nome
CREATE  FUNCTION retrieve_modulo_by_nome(
                        VARCHAR(150)
)
RETURNS SETOF modulo
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            nome,
            min_disciplinas,
            enfase_id
    FROM    modulo
    WHERE   nome = $1
    ORDER   BY  nome;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- recuperar todos os resgistros em modulo por enfase_id
CREATE  FUNCTION retrieve_modulo_all_by_enfase_id(
                        INTEGER
)
RETURNS SETOF modulo
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            nome,
            min_disciplinas,
            enfase_id
    FROM    modulo
    WHERE   enfase_id = $1
    ORDER   BY  enfase_id;
END;
$$
LANGUAGE    plpgsql;

-- recuperar todos os registros em disciplina_modulo
CREATE  FUNCTION retrieve_disciplina_modulo_all()
RETURNS SETOF disciplina_modulo
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            disciplina_id,
            modulo_id
    FROM    disciplina_modulo
    ORDER   BY  id,
                disciplina_id,
                modulo_id;
END;
$$
LANGUAGE    plpgsql;

-- recuperar o registro em  disciplina_modulo por id
CREATE  FUNCTION retrieve_disciplina_modulo_by_id(
                        INTEGER
)
RETURNS SETOF disciplina_modulo
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            disciplina_id,
            modulo_id
    FROM    disciplina_modulo
    WHERE   id = $1
    ORDER   BY  id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- recuperar o registro em  disciplina_modulo por disciplina_id, modulo_id
CREATE  FUNCTION retrieve_disciplina_modulo_by_disciplina_id_modulo_id(
                        INTEGER,
                        INTEGER
)
RETURNS SETOF disciplina_modulo
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            disciplina_id,
            modulo_id
    FROM    disciplina_modulo
    WHERE   disciplina_id = $1
               AND modulo_id = $2
    ORDER   BY  disciplina_id,
                modulo_id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- recuperar todos os resgistros em disciplina_modulo por disciplina_id
CREATE  FUNCTION retrieve_disciplina_modulo_all_by_disciplina_id(
                        INTEGER
)
RETURNS SETOF disciplina_modulo
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            disciplina_id,
            modulo_id
    FROM    disciplina_modulo
    WHERE   disciplina_id = $1
    ORDER   BY  disciplina_id;
END;
$$
LANGUAGE    plpgsql;

-- recuperar todos os resgistros em disciplina_modulo por modulo_id
CREATE  FUNCTION retrieve_disciplina_modulo_all_by_modulo_id(
                        INTEGER
)
RETURNS SETOF disciplina_modulo
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            disciplina_id,
            modulo_id
    FROM    disciplina_modulo
    WHERE   modulo_id = $1
    ORDER   BY  modulo_id;
END;
$$
LANGUAGE    plpgsql;

-- atualizar em curso por id
CREATE  FUNCTION update_curso_by_id(
                        INTEGER,
                        INTEGER,
                        VARCHAR(150),
                        INTEGER
)
RETURNS SETOF curso
AS $$
BEGIN
    RETURN      QUERY
    UPDATE      curso
    SET         codigo = $2,
                nome = $3,
                instituto_id = $4
    WHERE       id = $1
    RETURNING   id,
                codigo,
                nome,
                instituto_id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- atualizar em curso por codigo
CREATE  FUNCTION update_curso_by_codigo(
                        INTEGER,
                        INTEGER,
                        VARCHAR(150),
                        INTEGER
)
RETURNS SETOF curso
AS $$
BEGIN
    RETURN      QUERY
    UPDATE      curso
    SET         codigo = $2,
                nome = $3,
                instituto_id = $4
    WHERE       codigo = $1
    RETURNING   id,
                codigo,
                nome,
                instituto_id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;



-- atualizar em disciplina por id
CREATE  FUNCTION update_disciplina_by_id(
                        INTEGER,
                        VARCHAR(7),
                        INTEGER,
                        VARCHAR(150),
                        INTEGER,
                        INTEGER,
                        INTEGER
)
RETURNS SETOF disciplina
AS $$
BEGIN
    RETURN      QUERY
    UPDATE      disciplina
    SET         sigla = $2,
                departamento_id = $3,
                nome = $4,
                credito_aula = $5,
                credito_trabalho = $6,
                semestre_ideal = $7
    WHERE       id = $1
    RETURNING   id,
                sigla,
                departamento_id,
                nome,
                credito_aula,
                credito_trabalho,
                semestre_ideal;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- atualizar em disciplina por sigla
CREATE  FUNCTION update_disciplina_by_sigla(
                        VARCHAR(7),
                        VARCHAR(7),
                        INTEGER,
                        VARCHAR(150),
                        INTEGER,
                        INTEGER,
                        INTEGER
)
RETURNS SETOF disciplina
AS $$
BEGIN
    RETURN      QUERY
    UPDATE      disciplina
    SET         sigla = $2,
                departamento_id = $3,
                nome = $4,
                credito_aula = $5,
                credito_trabalho = $6,
                semestre_ideal = $7
    WHERE       sigla = $1
    RETURNING   id,
                sigla,
                departamento_id,
                nome,
                credito_aula,
                credito_trabalho,
                semestre_ideal;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- atualizar em enfase por id
CREATE  FUNCTION update_enfase_by_id(
                        INTEGER,
                        VARCHAR(150),
                        INTEGER,
                        INTEGER
)
RETURNS SETOF enfase
AS $$
BEGIN
    RETURN      QUERY
    UPDATE      enfase
    SET         nome = $2,
                min_modulos = $3,
                curso_id = $4
    WHERE       id = $1
    RETURNING   id,
                nome,
                min_modulos,
                curso_id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- atualizar em enfase por nome
CREATE  FUNCTION update_enfase_by_nome(
                        VARCHAR(150),
                        VARCHAR(150),
                        INTEGER,
                        INTEGER
)
RETURNS SETOF enfase
AS $$
BEGIN
    RETURN      QUERY
    UPDATE      enfase
    SET         nome = $2,
                min_modulos = $3,
                curso_id = $4
    WHERE       nome = $1
    RETURNING   id,
                nome,
                min_modulos,
                curso_id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;



-- atualizar em prerrequisito por id
CREATE  FUNCTION update_prerrequisito_by_id(
                        INTEGER,
                        INTEGER,
                        INTEGER,
                        INTEGER
)
RETURNS SETOF prerrequisito
AS $$
BEGIN
    RETURN      QUERY
    UPDATE      prerrequisito
    SET         curso_id = $2,
                disciplina_id = $3,
                requisito_id = $4
    WHERE       id = $1
    RETURNING   id,
                curso_id,
                disciplina_id,
                requisito_id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- atualizar em prerrequisito por disciplina_id, curso_id, requisito_id
CREATE  FUNCTION update_prerrequisito_by_disciplina_id_curso_id_requisito_id(
                        INTEGER,
                        INTEGER,
                        INTEGER,
                        INTEGER,
                        INTEGER,
                        INTEGER
)
RETURNS SETOF prerrequisito
AS $$
BEGIN
    RETURN      QUERY
    UPDATE      prerrequisito
    SET         curso_id = $4,
                disciplina_id = $5,
                requisito_id = $6
    WHERE       disciplina_id = $1
               AND curso_id = $2
               AND requisito_id = $3
    RETURNING   id,
                curso_id,
                disciplina_id,
                requisito_id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- atualizar em modulo por id
CREATE  FUNCTION update_modulo_by_id(
                        INTEGER,
                        VARCHAR(150),
                        INTEGER,
                        INTEGER
)
RETURNS SETOF modulo
AS $$
BEGIN
    RETURN      QUERY
    UPDATE      modulo
    SET         nome = $2,
                min_disciplinas = $3,
                enfase_id = $4
    WHERE       id = $1
    RETURNING   id,
                nome,
                min_disciplinas,
                enfase_id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- atualizar em modulo por nome
CREATE  FUNCTION update_modulo_by_nome(
                        VARCHAR(150),
                        VARCHAR(150),
                        INTEGER,
                        INTEGER
)
RETURNS SETOF modulo
AS $$
BEGIN
    RETURN      QUERY
    UPDATE      modulo
    SET         nome = $2,
                min_disciplinas = $3,
                enfase_id = $4
    WHERE       nome = $1
    RETURNING   id,
                nome,
                min_disciplinas,
                enfase_id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- atualizar em disciplina_modulo por id
CREATE  FUNCTION update_disciplina_modulo_by_id(
                        INTEGER,
                        INTEGER,
                        INTEGER
)
RETURNS SETOF disciplina_modulo
AS $$
BEGIN
    RETURN      QUERY
    UPDATE      disciplina_modulo
    SET         disciplina_id = $2,
                modulo_id = $3
    WHERE       id = $1
    RETURNING   id,
                disciplina_id,
                modulo_id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- atualizar em disciplina_modulo por disciplina_id, modulo_id
CREATE  FUNCTION update_disciplina_modulo_by_disciplina_id_modulo_id(
                        INTEGER,
                        INTEGER,
                        INTEGER,
                        INTEGER
)
RETURNS SETOF disciplina_modulo
AS $$
BEGIN
    RETURN      QUERY
    UPDATE      disciplina_modulo
    SET         disciplina_id = $3,
                modulo_id = $4
    WHERE       disciplina_id = $1
               AND modulo_id = $2
    RETURNING   id,
                disciplina_id,
                modulo_id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;


COMMIT;
