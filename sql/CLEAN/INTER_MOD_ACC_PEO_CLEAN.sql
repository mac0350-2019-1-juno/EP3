BEGIN;

DELETE  FROM pessoa_usuario;
ALTER   SEQUENCE pessoa_usuario_id_seq
        RESTART WITH 1;
        
DELETE  FROM usuario_perfil;
ALTER   SEQUENCE usuario_perfil_id_seq
        RESTART WITH 1;

DELETE  FROM perfil_servico;
ALTER   SEQUENCE perfil_servico_id_seq
        RESTART WITH 1;


COMMIT;
