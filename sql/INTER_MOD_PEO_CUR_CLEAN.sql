BEGIN;

DELETE  FROM aluno_curso;
ALTER   SEQUENCE aluno_curso_id_seq
        RESTART WITH 1;

DELETE  FROM administrador_curso;
ALTER   SEQUENCE administrador_curso_id_seq
        RESTART WITH 1;

DELETE  FROM ministra;
ALTER   SEQUENCE ministra_id_seq
        RESTART WITH 1;

DELETE  FROM planejamento;
ALTER   SEQUENCE planejamento_id_seq
        RESTART WITH 1;

DELETE  FROM oferecimento;
ALTER   SEQUENCE oferecimento_id_seq
        RESTART WITH 1;

DELETE  FROM matricula;
ALTER   SEQUENCE matricula_id_seq
        RESTART WITH 1;

COMMIT;
