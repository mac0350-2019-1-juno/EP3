BEGIN;

DELETE  FROM usuario;
ALTER   SEQUENCE usuario_id_seq
        RESTART WITH 1;

DELETE  FROM perfil;
ALTER   SEQUENCE perfil_id_seq
        RESTART WITH 1;

DELETE  FROM servico;
ALTER   SEQUENCE servico_id_seq
        RESTART WITH 1;



COMMIT;
