BEGIN;

DELETE  FROM curso;
ALTER   SEQUENCE curso_id_seq
        RESTART WITH 1;

DELETE  FROM disciplina;
ALTER   SEQUENCE disciplina_id_seq
        RESTART WITH 1;

DELETE  FROM enfase;
ALTER   SEQUENCE enfase_id_seq
        RESTART WITH 1;

DELETE  FROM prerrequisito;
ALTER   SEQUENCE prerrequisito_id_seq
        RESTART WITH 1;

DELETE  FROM modulo;
ALTER   SEQUENCE modulo_id_seq
        RESTART WITH 1;

DELETE  FROM disciplina_modulo;
ALTER   SEQUENCE disciplina_modulo_id_seq
        RESTART WITH 1;


COMMIT;
