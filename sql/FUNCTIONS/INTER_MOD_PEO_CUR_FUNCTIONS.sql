BEGIN;

-- cria um registro em aluno_curso
CREATE  FUNCTION create_aluno_curso(
                        INTEGER,
                        INTEGER,
                        DATE
)
RETURNS SETOF aluno_curso
AS $$
BEGIN
    RETURN      QUERY
    INSERT      INTO aluno_curso
                (aluno_id,
                 curso_id,
                 inicio)
    VALUES      ($1, $2, $3)
    RETURNING   id,
                aluno_id,
                curso_id,
                inicio;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- cria um registro em administrador_curso
CREATE  FUNCTION create_administrador_curso(
                        INTEGER,
                        INTEGER,
                        DATE,
                        DATE
)
RETURNS SETOF administrador_curso
AS $$
BEGIN
    RETURN      QUERY
    INSERT      INTO administrador_curso
                (administrador_id,
                 curso_id,
                 inicio,
                 termino)
    VALUES      ($1, $2, $3, $4)
    RETURNING   id,
                administrador_id,
                curso_id,
                inicio,
                termino;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- cria um registro em ministra
CREATE  FUNCTION create_ministra(
                        INTEGER,
                        INTEGER,
                        INTEGER,
                        INTEGER
)
RETURNS SETOF ministra
AS $$
BEGIN
    RETURN      QUERY
    INSERT      INTO ministra
                (professor_id,
                 disciplina_id,
                 semestre,
                 ano)
    VALUES      ($1, $2, $3, $4)
    RETURNING   id,
                professor_id,
                disciplina_id,
                semestre,
                ano;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;


-- cria um registro em planejamento
CREATE  FUNCTION create_planejamento(
                        INTEGER,
                        INTEGER,
                        INTEGER,
                        INTEGER
)
RETURNS SETOF planejamento
AS $$
BEGIN
    RETURN      QUERY
    INSERT      INTO planejamento
                (aluno_id,
                 disciplina_id,
                 semestre,
                 ano)
    VALUES      ($1, $2, $3, $4)
    RETURNING   id,
                aluno_id,
                disciplina_id,
                semestre,
                ano;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- cria um registro em oferecimento
CREATE  FUNCTION create_oferecimento(
                        INTEGER
)
RETURNS SETOF oferecimento
AS $$
BEGIN
    RETURN      QUERY
    INSERT      INTO oferecimento
                (ministra_id)
    VALUES      ($1)
    RETURNING   id,
                ministra_id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- cria um registro em matricula
CREATE  FUNCTION create_matricula(
                        INTEGER,
                        INTEGER,
                        CHARACTER,
                        REAL,
                        REAL
)
RETURNS SETOF matricula
AS $$
BEGIN
    RETURN      QUERY
    INSERT      INTO matricula
                (aluno_id,
                 oferecimento_id,
                 estado,
                 nota,
                 frequencia)
    VALUES      ($1, $2, $3, $4, $5)
    RETURNING   id,
                aluno_id,
                oferecimento_id,
                estado,
                nota,
                frequencia;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;


-- remover de aluno_curso por id
CREATE  FUNCTION delete_aluno_curso_by_id(
                        INTEGER
)
RETURNS SETOF aluno_curso
AS $$
BEGIN
    RETURN      QUERY
    DELETE      FROM aluno_curso
    WHERE       id = $1
    RETURNING   id,
                aluno_id,
                curso_id,
                inicio;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- remover de aluno_curso por aluno_id, curso_id, inicio
CREATE  FUNCTION delete_aluno_curso_by_aluno_id_curso_id_inicio(
                        INTEGER,
                        INTEGER,
                        DATE
)
RETURNS SETOF aluno_curso
AS $$
BEGIN
    RETURN      QUERY
    DELETE      FROM aluno_curso
    WHERE       aluno_id = $1
               AND curso_id = $2
               AND inicio = $3
    RETURNING   id,
                aluno_id,
                curso_id,
                inicio;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- remover de administrador_curso por id
CREATE  FUNCTION delete_administrador_curso_by_id(
                        INTEGER
)
RETURNS SETOF administrador_curso
AS $$
BEGIN
    RETURN      QUERY
    DELETE      FROM administrador_curso
    WHERE       id = $1
    RETURNING   id,
                administrador_id,
                curso_id,
                inicio,
                termino;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- remover de administrador_curso por administrador_id, curso_id, inicio
CREATE  FUNCTION delete_administrador_curso_by_administrador_id_curso_id_inicio(
                        INTEGER,
                        INTEGER,
                        DATE
)
RETURNS SETOF administrador_curso
AS $$
BEGIN
    RETURN      QUERY
    DELETE      FROM administrador_curso
    WHERE       administrador_id = $1
               AND curso_id = $2
               AND inicio = $3
    RETURNING   id,
                administrador_id,
                curso_id,
                inicio,
                termino;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;



-- remover de ministra por id
CREATE  FUNCTION delete_ministra_by_id(
                        INTEGER
)
RETURNS SETOF ministra
AS $$
BEGIN
    RETURN      QUERY
    DELETE      FROM ministra
    WHERE       id = $1
    RETURNING   id,
                professor_id,
                disciplina_id,
                semestre,
                ano;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- remover de ministra por professor_id, disciplina_id, semestre, ano
CREATE  FUNCTION delete_ministra_by_professor_id_disciplina_id_semestre_ano(
                        INTEGER,
                        INTEGER,
                        INTEGER,
                        INTEGER
)
RETURNS SETOF ministra
AS $$
BEGIN
    RETURN      QUERY
    DELETE      FROM ministra
    WHERE       professor_id = $1
               AND disciplina_id = $2
               AND semestre = $3
               AND ano = $4
    RETURNING   id,
                professor_id,
                disciplina_id,
                semestre,
                ano;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;



-- remover de planejamento por id
CREATE  FUNCTION delete_planejamento_by_id(
                        INTEGER
)
RETURNS SETOF planejamento
AS $$
BEGIN
    RETURN      QUERY
    DELETE      FROM planejamento
    WHERE       id = $1
    RETURNING   id,
                aluno_id,
                disciplina_id,
                semestre,
                ano;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- remover de planejamento por aluno_id, disciplina_id
CREATE  FUNCTION delete_planejamento_by_aluno_id_disciplina_id(
                        INTEGER,
                        INTEGER
)
RETURNS SETOF planejamento
AS $$
BEGIN
    RETURN      QUERY
    DELETE      FROM planejamento
    WHERE       aluno_id = $1
               AND disciplina_id = $2
    RETURNING   id,
                aluno_id,
                disciplina_id,
                semestre,
                ano;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- remover de oferecimento por id
CREATE  FUNCTION delete_oferecimento_by_id(
                        INTEGER
)
RETURNS SETOF oferecimento
AS $$
BEGIN
    RETURN      QUERY
    DELETE      FROM oferecimento
    WHERE       id = $1
    RETURNING   id,
                ministra_id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- remover de oferecimento por ministra_id
CREATE  FUNCTION delete_oferecimento_by_ministra_id(
                        INTEGER
)
RETURNS SETOF oferecimento
AS $$
BEGIN
    RETURN      QUERY
    DELETE      FROM oferecimento
    WHERE       ministra_id = $1
    RETURNING   id,
                ministra_id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- remover de matricula por id
CREATE  FUNCTION delete_matricula_by_id(
                        INTEGER
)
RETURNS SETOF matricula
AS $$
BEGIN
    RETURN      QUERY
    DELETE      FROM matricula
    WHERE       id = $1
    RETURNING   id,
                aluno_id,
                oferecimento_id,
                estado,
                nota,
                frequencia;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- remover de matricula por aluno_id, oferecimento_id
CREATE  FUNCTION delete_matricula_by_aluno_id_oferecimento_id(
                        INTEGER,
                        INTEGER
)
RETURNS SETOF matricula
AS $$
BEGIN
    RETURN      QUERY
    DELETE      FROM matricula
    WHERE       aluno_id = $1
               AND oferecimento_id = $2
    RETURNING   id,
                aluno_id,
                oferecimento_id,
                estado,
                nota,
                frequencia;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;



-- recuperar todos os registros em aluno_curso
CREATE  FUNCTION retrieve_aluno_curso_all()
RETURNS SETOF aluno_curso
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            aluno_id,
            curso_id,
            inicio
    FROM    aluno_curso
    ORDER   BY  id,
                aluno_id,
                curso_id,
                inicio;
END;
$$
LANGUAGE    plpgsql;

-- recuperar o registro em  aluno_curso por id
CREATE  FUNCTION retrieve_aluno_curso_by_id(
                        INTEGER
)
RETURNS SETOF aluno_curso
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            aluno_id,
            curso_id,
            inicio
    FROM    aluno_curso
    WHERE   id = $1
    ORDER   BY  id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- recuperar o registro em  aluno_curso por aluno_id, curso_id, inicio
CREATE  FUNCTION retrieve_aluno_curso_by_aluno_id_curso_id_inicio(
                        INTEGER,
                        INTEGER,
                        DATE
)
RETURNS SETOF aluno_curso
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            aluno_id,
            curso_id,
            inicio
    FROM    aluno_curso
    WHERE   aluno_id = $1
               AND curso_id = $2
               AND inicio = $3
    ORDER   BY  aluno_id,
                curso_id,
                inicio;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- recuperar todos os resgistros em aluno_curso por aluno_id
CREATE  FUNCTION retrieve_aluno_curso_all_by_aluno_id(
                        INTEGER
)
RETURNS SETOF aluno_curso
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            aluno_id,
            curso_id,
            inicio
    FROM    aluno_curso
    WHERE   aluno_id = $1
    ORDER   BY  aluno_id;
END;
$$
LANGUAGE    plpgsql;

-- recuperar todos os resgistros em aluno_curso por curso_id
CREATE  FUNCTION retrieve_aluno_curso_all_by_curso_id(
                        INTEGER
)
RETURNS SETOF aluno_curso
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            aluno_id,
            curso_id,
            inicio
    FROM    aluno_curso
    WHERE   curso_id = $1
    ORDER   BY  curso_id;
END;
$$
LANGUAGE    plpgsql;



-- alunos de um curso
CREATE  FUNCTION retrieve_aluno_curso(
    ca_curso                    INTEGER
)
RETURNS TABLE (
    ps_nusp                     INTEGER,
    ps_nome                     VARCHAR(128),
    us_email                    email
) AS $$
BEGIN
    RETURN  QUERY
    SELECT  ps_nusp,
            ps_nome,
            us_email
    FROM    pessoa,
            users,
            acesso,
            cursa
    WHERE   ca_curso=$1;
END;
$$
LANGUAGE    plpgsql;

-- recuperar todos os registros em administrador_curso
CREATE  FUNCTION retrieve_administrador_curso_all()
RETURNS SETOF administrador_curso
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            administrador_id,
            curso_id,
            inicio,
            termino
    FROM    administrador_curso
    ORDER   BY  id,
                administrador_id,
                curso_id,
                inicio,
                termino;
END;
$$
LANGUAGE    plpgsql;

-- recuperar o registro em  administrador_curso por id
CREATE  FUNCTION retrieve_administrador_curso_by_id(
                        INTEGER
)
RETURNS SETOF administrador_curso
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            administrador_id,
            curso_id,
            inicio,
            termino
    FROM    administrador_curso
    WHERE   id = $1
    ORDER   BY  id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- recuperar o registro em  administrador_curso por administrador_id, curso_id, inicio
CREATE  FUNCTION retrieve_administrador_curso_by_administrador_id_curso_id_inici(
                        INTEGER,
                        INTEGER,
                        DATE
)
RETURNS SETOF administrador_curso
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            administrador_id,
            curso_id,
            inicio,
            termino
    FROM    administrador_curso
    WHERE   administrador_id = $1
               AND curso_id = $2
               AND inicio = $3
    ORDER   BY  administrador_id,
                curso_id,
                inicio;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- recuperar todos os resgistros em administrador_curso por administrador_id
CREATE  FUNCTION retrieve_administrador_curso_all_by_administrador_id(
                        INTEGER
)
RETURNS SETOF administrador_curso
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            administrador_id,
            curso_id,
            inicio,
            termino
    FROM    administrador_curso
    WHERE   administrador_id = $1
    ORDER   BY  administrador_id;
END;
$$
LANGUAGE    plpgsql;

-- recuperar todos os resgistros em administrador_curso por curso_id
CREATE  FUNCTION retrieve_administrador_curso_all_by_curso_id(
                        INTEGER
)
RETURNS SETOF administrador_curso
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            administrador_id,
            curso_id,
            inicio,
            termino
    FROM    administrador_curso
    WHERE   curso_id = $1
    ORDER   BY  curso_id;
END;
$$
LANGUAGE    plpgsql;



-- todos os administradores de um curso no momento atual (nusp, nome, email, data de inicio)
CREATE  FUNCTION retrieve_admin_atual(
    da_administrador            INTEGER,
    da_curso                    INTEGER
)
RETURNS TABLE (
    ps_nusp                     INTEGER,
    ps_nome                     VARCHAR(128),
    us_email                    email,
    da_data_inicio              DATE
) AS $$
BEGIN
    RETURN  QUERY
    SELECT  ps_nusp,
            ps_nome,
            us_email,
            da_data_inicio
    FROM    pessoa,
            users,
            acesso,
            administra
    WHERE   da_administrador=$1
            AND da_curso=$2
            AND da_data_termino=NULL
            AND ps_nusp=us_pessoa
            AND ps_nusp=ac_pessoa
            AND us_id=ac_user;
END;
$$
LANGUAGE    plpgsql;

-- recuperar todos os registros em ministra
CREATE  FUNCTION retrieve_ministra_all()
RETURNS SETOF ministra
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            professor_id,
            disciplina_id,
            semestre,
            ano
    FROM    ministra
    ORDER   BY  id,
                professor_id,
                disciplina_id,
                semestre,
                ano;
END;
$$
LANGUAGE    plpgsql;

-- recuperar o registro em  ministra por id
CREATE  FUNCTION retrieve_ministra_by_id(
                        INTEGER
)
RETURNS SETOF ministra
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            professor_id,
            disciplina_id,
            semestre,
            ano
    FROM    ministra
    WHERE   id = $1
    ORDER   BY  id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- recuperar o registro em  ministra por professor_id, disciplina_id, semestre, ano
CREATE  FUNCTION retrieve_ministra_by_professor_id_disciplina_id_semestre_ano(
                        INTEGER,
                        INTEGER,
                        INTEGER,
                        INTEGER
)
RETURNS SETOF ministra
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            professor_id,
            disciplina_id,
            semestre,
            ano
    FROM    ministra
    WHERE   professor_id = $1
               AND disciplina_id = $2
               AND semestre = $3
               AND ano = $4
    ORDER   BY  professor_id,
                disciplina_id,
                semestre,
                ano;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- recuperar todos os resgistros em ministra por professor_id
CREATE  FUNCTION retrieve_ministra_all_by_professor_id(
                        INTEGER
)
RETURNS SETOF ministra
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            professor_id,
            disciplina_id,
            semestre,
            ano
    FROM    ministra
    WHERE   professor_id = $1
    ORDER   BY  professor_id;
END;
$$
LANGUAGE    plpgsql;

-- recuperar todos os resgistros em ministra por disciplina_id
CREATE  FUNCTION retrieve_ministra_all_by_disciplina_id(
                        INTEGER
)
RETURNS SETOF ministra
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            professor_id,
            disciplina_id,
            semestre,
            ano
    FROM    ministra
    WHERE   disciplina_id = $1
    ORDER   BY  disciplina_id;
END;
$$
LANGUAGE    plpgsql;



-- todas as disciplinas que foram ministradas por um professor
CREATE  FUNCTION retrieve_prof_ministra(
    mn_professor                INTEGER
)
RETURNS TABLE (
    "sigla"                     VARCHAR(7),
    "departamento"              VARCHAR(3),
    "nome"                      VARCHAR(150)
) AS $$
BEGIN
    RETURN  QUERY
    SELECT  ds_sigla,
            ds_departamento,
            ds_nome
    FROM    disciplina,
            ministra
    WHERE   mn_professor=$1
            AND ds_sigla=mn_disciplina;
END;
$$
LANGUAGE    plpgsql;

-- recuperar todos os registros em planejamento
CREATE  FUNCTION retrieve_planejamento_all()
RETURNS SETOF planejamento
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            aluno_id,
            disciplina_id,
            semestre,
            ano
    FROM    planejamento
    ORDER   BY  id,
                aluno_id,
                disciplina_id,
                semestre,
                ano;
END;
$$
LANGUAGE    plpgsql;

-- recuperar o registro em  planejamento por id
CREATE  FUNCTION retrieve_planejamento_by_id(
                        INTEGER
)
RETURNS SETOF planejamento
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            aluno_id,
            disciplina_id,
            semestre,
            ano
    FROM    planejamento
    WHERE   id = $1
    ORDER   BY  id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- recuperar o registro em  planejamento por aluno_id, disciplina_id
CREATE  FUNCTION retrieve_planejamento_by_aluno_id_disciplina_id(
                        INTEGER,
                        INTEGER
)
RETURNS SETOF planejamento
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            aluno_id,
            disciplina_id,
            semestre,
            ano
    FROM    planejamento
    WHERE   aluno_id = $1
               AND disciplina_id = $2
    ORDER   BY  aluno_id,
                disciplina_id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- recuperar todos os resgistros em planejamento por aluno_id
CREATE  FUNCTION retrieve_planejamento_all_by_aluno_id(
                        INTEGER
)
RETURNS SETOF planejamento
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            aluno_id,
            disciplina_id,
            semestre,
            ano
    FROM    planejamento
    WHERE   aluno_id = $1
    ORDER   BY  aluno_id;
END;
$$
LANGUAGE    plpgsql;

-- recuperar todos os resgistros em planejamento por disciplina_id
CREATE  FUNCTION retrieve_planejamento_all_by_disciplina_id(
                        INTEGER
)
RETURNS SETOF planejamento
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            aluno_id,
            disciplina_id,
            semestre,
            ano
    FROM    planejamento
    WHERE   disciplina_id = $1
    ORDER   BY  disciplina_id;
END;
$$
LANGUAGE    plpgsql;


-- recuperar todos os registros em oferecimento
CREATE  FUNCTION retrieve_oferecimento_all()
RETURNS SETOF oferecimento
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            ministra_id
    FROM    oferecimento
    ORDER   BY  id,
                ministra_id;
END;
$$
LANGUAGE    plpgsql;

-- recuperar o registro em  oferecimento por id
CREATE  FUNCTION retrieve_oferecimento_by_id(
                        INTEGER
)
RETURNS SETOF oferecimento
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            ministra_id
    FROM    oferecimento
    WHERE   id = $1
    ORDER   BY  id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- recuperar o registro em  oferecimento por ministra_id
CREATE  FUNCTION retrieve_oferecimento_by_ministra_id(
                        INTEGER
)
RETURNS SETOF oferecimento
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            ministra_id
    FROM    oferecimento
    WHERE   ministra_id = $1
    ORDER   BY  ministra_id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- recuperar todos os resgistros em oferecimento por ministra_id
CREATE  FUNCTION retrieve_oferecimento_all_by_ministra_id(
                        INTEGER
)
RETURNS SETOF oferecimento
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            ministra_id
    FROM    oferecimento
    WHERE   ministra_id = $1
    ORDER   BY  ministra_id;
END;
$$
LANGUAGE    plpgsql;



-- todos os oferecimentos de um departamento no semestre e ano
CREATE  FUNCTION retrieve_ofer_dep_semestre(
    ds_departamento             VARCHAR(3),
    of_semestre                 INTEGER,
    of_ano                      INTEGER
)
RETURNS TABLE (
    "sigla"                     VARCHAR(7),
    "nome"                      VARCHAR(150),
    "professor"                 INTEGER
) AS $$
BEGIN
    RETURN  QUERY
    SELECT  ds_sigla,
            ds_nome,
            of_professor
    FROM    oferecimento,
            disciplina
    WHERE   ds_departamento=$1
            AND of_semestre=$2
            AND of_ano=$3
            AND ds_sigla=of_disciplina;
END;
$$
LANGUAGE    plpgsql;

-- todos os oferecimentos feitos de uma disciplina
CREATE  FUNCTION retrieve_ofer_disc(
    of_professor                INTEGER,
    of_semestre                 INTEGER,
    of_ano                      INTEGER
)
RETURNS TABLE (
    "professor"                 INTEGER,
    "disciplina"                VARCHAR(7),
    "semestre"                  INTEGER,
    "ano"                       INTEGER
) AS $$
BEGIN
    RETURN  QUERY
    SELECT  of_professor,
            of_disciplina,
            of_semestre,
            of_ano
    FROM    oferecimento
    WHERE   of_professor=$1
            AND of_semestre=$2
            AND of_ano=$3
    ORDER   BY  of_professor,
                of_disciplina,
                of_semestre,
                of_ano;
END;
$$
LANGUAGE    plpgsql;

-- recuperar todos os registros em matricula
CREATE  FUNCTION retrieve_matricula_all()
RETURNS SETOF matricula
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            aluno_id,
            oferecimento_id,
            estado,
            nota,
            frequencia
    FROM    matricula
    ORDER   BY  id,
                aluno_id,
                oferecimento_id,
                estado,
                nota,
                frequencia;
END;
$$
LANGUAGE    plpgsql;

-- recuperar o registro em  matricula por id
CREATE  FUNCTION retrieve_matricula_by_id(
                        INTEGER
)
RETURNS SETOF matricula
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            aluno_id,
            oferecimento_id,
            estado,
            nota,
            frequencia
    FROM    matricula
    WHERE   id = $1
    ORDER   BY  id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- recuperar o registro em  matricula por aluno_id, oferecimento_id
CREATE  FUNCTION retrieve_matricula_by_aluno_id_oferecimento_id(
                        INTEGER,
                        INTEGER
)
RETURNS SETOF matricula
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            aluno_id,
            oferecimento_id,
            estado,
            nota,
            frequencia
    FROM    matricula
    WHERE   aluno_id = $1
               AND oferecimento_id = $2
    ORDER   BY  aluno_id,
                oferecimento_id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- recuperar todos os resgistros em matricula por aluno_id
CREATE  FUNCTION retrieve_matricula_all_by_aluno_id(
                        INTEGER
)
RETURNS SETOF matricula
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            aluno_id,
            oferecimento_id,
            estado,
            nota,
            frequencia
    FROM    matricula
    WHERE   aluno_id = $1
    ORDER   BY  aluno_id;
END;
$$
LANGUAGE    plpgsql;

-- recuperar todos os resgistros em matricula por oferecimento_id
CREATE  FUNCTION retrieve_matricula_all_by_oferecimento_id(
                        INTEGER
)
RETURNS SETOF matricula
AS $$
BEGIN
    RETURN  QUERY
    SELECT  id,
            aluno_id,
            oferecimento_id,
            estado,
            nota,
            frequencia
    FROM    matricula
    WHERE   oferecimento_id = $1
    ORDER   BY  oferecimento_id;
END;
$$
LANGUAGE    plpgsql;



-- alunos matriculados em um oferecimento
CREATE  FUNCTION retrieve_alunos_matriculados_ofer(
    ma_professor                INTEGER,
    ma_disciplina               VARCHAR(7),
    ma_semestre                 INTEGER,
    ma_ano                      INTEGER
)
RETURNS TABLE (
    "nusp"                      INTEGER,
    "nome"                      VARCHAR(128),
    "email"                     email
) AS $$
BEGIN
    RETURN  QUERY
    SELECT  ps_nusp,
            ps_nome,
            us_email
    FROM    pessoa,
            users,
            acesso,
            matricula
    WHERE   ma_professor=$1
            AND ma_disciplina=$2
            AND ma_semestre=$3
            AND ma_ano=$4
            AND ma_aluno=ps_nusp
            AND ps_nusp=ac_pessoa
            AND us_id=ac_user;
END;
$$
LANGUAGE    plpgsql;

-- alunos aprovados em uma disciplina
CREATE  FUNCTION retrieve_todos_alunos_aprovados_disc(
    ma_professor                INTEGER,
    ma_disciplina               VARCHAR(7),
    ma_semestre                 INTEGER,
    ma_ano                      INTEGER
)
RETURNS TABLE (
    "nusp"                      INTEGER,
    "nome"                      VARCHAR(128),
    "email"                     email
) AS $$
BEGIN
    RETURN  QUERY
    SELECT  ps_nusp,
            ps_nome,
            us_email
    FROM    pessoa,
            users,
            acesso,
            matricula
    WHERE   ma_professor=$1
            AND ma_disciplina=$2
            AND ma_semestre=$3
            AND ma_ano=$4
            AND ma_aluno=ps_nusp
            AND ps_nusp=ac_pessoa
            AND us_id=ac_user
            AND ma_status='C';
END;
$$
LANGUAGE    plpgsql;

-- alunos reprovados em uma disciplina
CREATE  FUNCTION retrieve_todos_alunos_reprovados_disc(
    ma_professor                INTEGER,
    ma_disciplina               VARCHAR(7),
    ma_semestre                 INTEGER,
    ma_ano                      INTEGER
)
RETURNS TABLE (
    "nusp"                      INTEGER,
    "nome"                      VARCHAR(128),
    "email"                     email
) AS $$
BEGIN
    RETURN  QUERY
    SELECT  ps_nusp,
            ps_nome,
            us_email
    FROM    pessoa,
            users,
            acesso,
            matricula
    WHERE   ma_professor=$1
            AND ma_disciplina=$2
            AND ma_semestre=$3
            AND ma_ano=$4
            AND ma_aluno=ps_nusp
            AND ps_nusp=ac_pessoa
            AND us_id=ac_user
            AND ma_status NOT IN ('C', 'M');
END;
$$
LANGUAGE    plpgsql;

-- quais os prerrequisitos de uma disciplina que o aluno ja cumṕriu para o seu curso
CREATE  FUNCTION retrieve_prerrequisito_para_aluno(
    ma_aluno                    INTEGER,
    rq_disciplina               VARCHAR(7)
)
RETURNS TABLE (
    "sigla"                     VARCHAR(7),
    "nome"                      VARCHAR(150)
) AS $$
BEGIN
    RETURN  QUERY
    SELECT  ds_sigla,
            ds_nome
    FROM    disciplina,
            prerrequisito,
            matricula
    WHERE   rq_curso=$1
            AND rq_disciplina=$2
            AND rq_requisito=ma_disciplina
            AND ma_status='C';
END;
$$
LANGUAGE    plpgsql;

-- notas e dados dos alunos que estiveram/estao matriculados em um oferecimento
CREATE  FUNCTION retrieve_notas_e_dados_oferecimento(
    ma_professor                INTEGER,
    ma_disciplina               VARCHAR(7),
    ma_semestre                 INTEGER,
    ma_ano                      INTEGER
)
RETURNS TABLE (
    "nusp"                      INTEGER,
    "nome"                      VARCHAR(128),
    "status"                    CHARACTER,
    "nota"                      REAL,
    "frequencia"                REAL
) AS $$
BEGIN
    RETURN  QUERY
    SELECT  ps_nusp,
            ps_nome,
            ma_status,
            ma_nota,
            ma_frequencia
    FROM    matricula,
            pessoa
    WHERE   ma_professor=$1
            AND ma_disciplina=$2
            AND ma_semestre=$3
            AND ma_ano=$4
            AND ma_aluno=ps_nusp;
END;
$$
LANGUAGE    plpgsql;

-- todas as notas e status das disciplinas de um aluno
CREATE  FUNCTION retrieve_notas_aluno(
    ma_aluno                    INTEGER
)
RETURNS TABLE (
    "disciplina"                VARCHAR(7),
    "status"                    CHARACTER,
    "nota"                      REAL,
    "frequencia"                REAL
) AS $$
BEGIN
    RETURN  QUERY
    SELECT  ma_disciplina,
            ma_status,
            ma_nota,
            ma_frequencia
    FROM    matricula
    WHERE   ma_aluno=$1
            AND ma_status!='M';
END;
$$
LANGUAGE    plpgsql;

-- media de todas as notas de um aluno em disciplinas aprovadas ou reprovadas
CREATE  FUNCTION retrieve_media_aluno(
    ma_aluno                    INTEGER
)
RETURNS NUMERIC AS $$
BEGIN
    RETURN  (
        SELECT  AVG(ma_nota)
        FROM    matricula
        WHERE   ma_aluno=$1
    );
END;
$$
LANGUAGE    plpgsql;

-- media das notas dos alunos em um oferecimento, que ja foram aprovados ou reprovados
CREATE  FUNCTION retrieve_media_oferecimento(
    ma_professor                INTEGER,
    ma_disciplina               VARCHAR(7),
    ma_semestre                 INTEGER,
    ma_ano                      INTEGER
)
RETURNS NUMERIC AS $$
BEGIN
    RETURN  (
        SELECT  AVG(ma_nota)
        FROM    matricula
        WHERE   ma_professor=$1
                AND ma_disciplina=$2
                AND ma_semestre=$3
                AND ma_ano=$4
                AND ma_status!='M'
    );
END;
$$
LANGUAGE    plpgsql;


-- todas as disciplinas que o aluno foi aprovado
CREATE  FUNCTION retrieve_disciplina_aprovado(
    nusp_aluno                  INTEGER
)
RETURNS TABLE (
    ap_disciplinas              VARCHAR(7)
) AS $$
BEGIN
    RETURN  QUERY
    SELECT  ma_disciplina
    FROM    matricula
    WHERE   ma_aluno = $1
            AND ma_status = 'C';
END;
$$  LANGUAGE plpgsql;

-- Verifica se o aluno completou um modulo
CREATE  FUNCTION retrieve_aluno_completou_modulo(
    nusp_pessoa_aluno   INTEGER,
    nome_modulo         VARCHAR(150)
)
RETURNS BOOLEAN
AS $$
BEGIN
    RETURN  (
        SELECT  (   SELECT  COUNT(DISTINCT mn.disciplina_id)
                    FROM    matricula ma

                    INNER   JOIN aluno al
                    ON      ma.aluno_id = al.id
                    INNER   JOIN pessoa ps
                    ON      al.pessoa_id = ps.id

                    INNER   JOIN oferecimento of
                    ON      ma.oferecimento_id = of.id
                    INNER   JOIN ministra mn
                    ON      of.ministra_id = mn.id

                    INNER   JOIN disciplina_modulo dm
                    ON      mn.disciplina_id = dm.disciplina_id
                    INNER   JOIN modulo md
                    ON      dm.modulo_id = md.id

                    WHERE   ps.nusp = $1
                            AND md.nome = $2
                            AND ma.estado = 'C'
                ) >= md.min_disciplinas
        FROM    modulo md
        WHERE   md.nome = $2
    );
END;
$$
LANGUAGE    plpgsql;

-- Verifica se o aluno completou uma enfase
CREATE  FUNCTION retrieve_aluno_completou_enfase(
    nusp_pessoa_aluno   INTEGER,
    nome_enfase         VARCHAR(150)
)
RETURNS BOOLEAN
AS $$
BEGIN
    RETURN  (
        SELECT  (   SELECT  COUNT(CASE  WHEN retrieve_aluno_completou_modulo($1, md.nome)
                                        THEN 1
                                        END)
                    FROM    enfase ef

                    INNER   JOIN modulo md
                    ON      md.enfase_id = ef.id

                    WHERE   ef.nome = $2
                ) >= ef.min_modulos
        FROM    enfase ef
        WHERE   ef.nome = $2
    );
END;
$$
LANGUAGE    plpgsql;

-- Verifica se o aluno completou um curso
CREATE  FUNCTION retrieve_aluno_completou_curso(
    nusp_pessoa_aluno   INTEGER,
    nome_curso          VARCHAR(150)
)
RETURNS BOOLEAN
AS $$
BEGIN
    RETURN  retrieve_aluno_completou_enfase($1, $2);
END;
$$
LANGUAGE    plpgsql;

-- atualizar em aluno_curso por id
CREATE  FUNCTION update_aluno_curso_by_id(
                        INTEGER,
                        INTEGER,
                        INTEGER,
                        DATE
)
RETURNS SETOF aluno_curso
AS $$
BEGIN
    RETURN      QUERY
    UPDATE      aluno_curso
    SET         aluno_id = $2,
                curso_id = $3,
                inicio = $4
    WHERE       id = $1
    RETURNING   id,
                aluno_id,
                curso_id,
                inicio;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- atualizar em aluno_curso por aluno_id, curso_id, inicio
CREATE  FUNCTION update_aluno_curso_by_aluno_id_curso_id_inicio(
                        INTEGER,
                        INTEGER,
                        DATE,
                        INTEGER,
                        INTEGER,
                        DATE
)
RETURNS SETOF aluno_curso
AS $$
BEGIN
    RETURN      QUERY
    UPDATE      aluno_curso
    SET         aluno_id = $4,
                curso_id = $5,
                inicio = $6
    WHERE       aluno_id = $1
               AND curso_id = $2
               AND inicio = $3
    RETURNING   id,
                aluno_id,
                curso_id,
                inicio;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- atualizar em administrador_curso por id
CREATE  FUNCTION update_administrador_curso_by_id(
                        INTEGER,
                        INTEGER,
                        INTEGER,
                        DATE,
                        DATE
)
RETURNS SETOF administrador_curso
AS $$
BEGIN
    RETURN      QUERY
    UPDATE      administrador_curso
    SET         administrador_id = $2,
                curso_id = $3,
                inicio = $4,
                termino = $5
    WHERE       id = $1
    RETURNING   id,
                administrador_id,
                curso_id,
                inicio,
                termino;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- atualizar em administrador_curso por administrador_id, curso_id, inicio
CREATE  FUNCTION update_administrador_curso_by_administrador_id_curso_id_inicio(
                        INTEGER,
                        INTEGER,
                        DATE,
                        INTEGER,
                        INTEGER,
                        DATE,
                        DATE
)
RETURNS SETOF administrador_curso
AS $$
BEGIN
    RETURN      QUERY
    UPDATE      administrador_curso
    SET         administrador_id = $4,
                curso_id = $5,
                inicio = $6,
                termino = $7
    WHERE       administrador_id = $1
               AND curso_id = $2
               AND inicio = $3
    RETURNING   id,
                administrador_id,
                curso_id,
                inicio,
                termino;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;



-- atualizar em ministra por id
CREATE  FUNCTION update_ministra_by_id(
                        INTEGER,
                        INTEGER,
                        INTEGER,
                        INTEGER,
                        INTEGER
)
RETURNS SETOF ministra
AS $$
BEGIN
    RETURN      QUERY
    UPDATE      ministra
    SET         professor_id = $2,
                disciplina_id = $3,
                semestre = $4,
                ano = $5
    WHERE       id = $1
    RETURNING   id,
                professor_id,
                disciplina_id,
                semestre,
                ano;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- atualizar em ministra por professor_id, disciplina_id, semestre, ano
CREATE  FUNCTION update_ministra_by_professor_id_disciplina_id_semestre_ano(
                        INTEGER,
                        INTEGER,
                        INTEGER,
                        INTEGER,
                        INTEGER,
                        INTEGER,
                        INTEGER,
                        INTEGER
)
RETURNS SETOF ministra
AS $$
BEGIN
    RETURN      QUERY
    UPDATE      ministra
    SET         professor_id = $5,
                disciplina_id = $6,
                semestre = $7,
                ano = $8
    WHERE       professor_id = $1
               AND disciplina_id = $2
               AND semestre = $3
               AND ano = $4
    RETURNING   id,
                professor_id,
                disciplina_id,
                semestre,
                ano;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;



-- atualizar em planejamento por id
CREATE  FUNCTION update_planejamento_by_id(
                        INTEGER,
                        INTEGER,
                        INTEGER,
                        INTEGER,
                        INTEGER
)
RETURNS SETOF planejamento
AS $$
BEGIN
    RETURN      QUERY
    UPDATE      planejamento
    SET         aluno_id = $2,
                disciplina_id = $3,
                semestre = $4,
                ano = $5
    WHERE       id = $1
    RETURNING   id,
                aluno_id,
                disciplina_id,
                semestre,
                ano;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- atualizar em planejamento por aluno_id, disciplina_id
CREATE  FUNCTION update_planejamento_by_aluno_id_disciplina_id(
                        INTEGER,
                        INTEGER,
                        INTEGER,
                        INTEGER,
                        INTEGER,
                        INTEGER
)
RETURNS SETOF planejamento
AS $$
BEGIN
    RETURN      QUERY
    UPDATE      planejamento
    SET         aluno_id = $3,
                disciplina_id = $4,
                semestre = $5,
                ano = $6
    WHERE       aluno_id = $1
               AND disciplina_id = $2
    RETURNING   id,
                aluno_id,
                disciplina_id,
                semestre,
                ano;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- atualizar em oferecimento por id
CREATE  FUNCTION update_oferecimento_by_id(
                        INTEGER,
                        INTEGER
)
RETURNS SETOF oferecimento
AS $$
BEGIN
    RETURN      QUERY
    UPDATE      oferecimento
    SET         ministra_id = $2
    WHERE       id = $1
    RETURNING   id,
                ministra_id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- atualizar em oferecimento por ministra_id
CREATE  FUNCTION update_oferecimento_by_ministra_id(
                        INTEGER,
                        INTEGER
)
RETURNS SETOF oferecimento
AS $$
BEGIN
    RETURN      QUERY
    UPDATE      oferecimento
    SET         ministra_id = $2
    WHERE       ministra_id = $1
    RETURNING   id,
                ministra_id;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- atualizar em matricula por id
CREATE  FUNCTION update_matricula_by_id(
                        INTEGER,
                        INTEGER,
                        INTEGER,
                        CHARACTER,
                        REAL,
                        REAL
)
RETURNS SETOF matricula
AS $$
BEGIN
    RETURN      QUERY
    UPDATE      matricula
    SET         aluno_id = $2,
                oferecimento_id = $3,
                estado = $4,
                nota = $5,
                frequencia = $6
    WHERE       id = $1
    RETURNING   id,
                aluno_id,
                oferecimento_id,
                estado,
                nota,
                frequencia;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

-- atualizar em matricula por aluno_id, oferecimento_id
CREATE  FUNCTION update_matricula_by_aluno_id_oferecimento_id(
                        INTEGER,
                        INTEGER,
                        INTEGER,
                        INTEGER,
                        CHARACTER,
                        REAL,
                        REAL
)
RETURNS SETOF matricula
AS $$
BEGIN
    RETURN      QUERY
    UPDATE      matricula
    SET         aluno_id = $3,
                oferecimento_id = $4,
                estado = $5,
                nota = $6,
                frequencia = $7
    WHERE       aluno_id = $1
               AND oferecimento_id = $2
    RETURNING   id,
                aluno_id,
                oferecimento_id,
                estado,
                nota,
                frequencia;

EXCEPTION   WHEN OTHERS THEN

END;
$$
LANGUAGE    plpgsql;

COMMIT;
