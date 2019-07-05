BEGIN;


  DELETE  FROM instituto;
  ALTER   SEQUENCE instituto_id_seq
          RESTART WITH 1;

  DELETE  FROM pessoa;
  ALTER   SEQUENCE pessoa_id_seq
          RESTART WITH 1;

  DELETE  FROM departamento;
  ALTER   SEQUENCE departamento_id_seq
          RESTART WITH 1;

  DELETE  FROM aluno;
  ALTER   SEQUENCE aluno_id_seq
          RESTART WITH 1;

  DELETE  FROM administrador;
  ALTER   SEQUENCE administrador_id_seq
          RESTART WITH 1;

  DELETE  FROM professor;
  ALTER   SEQUENCE professor_id_seq
          RESTART WITH 1;

COMMIT;
